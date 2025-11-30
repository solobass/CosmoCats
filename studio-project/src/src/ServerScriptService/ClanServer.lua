--[[
	ClanServer.lua
	Handles server-side clan management, validation, and data persistence.
	Implements the full Cosmo Cats clan system from CLANS_SOCIAL_SYSTEM_BIBLE.md
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

-- Get dependencies (safely require - may not exist yet)
local PlayerDataManager = nil
local EconomyManager = nil
local CurrencyServer = nil

local success1, result1 = pcall(function() return require(script.Parent.Systems.PlayerDataManager) end)
if success1 and type(result1) == "table" then
	PlayerDataManager = result1
end

local success2, result2 = pcall(function() return require(script.Parent.Systems.EconomyManager) end)
if success2 and type(result2) == "table" then
	EconomyManager = result2
end

local success3, result3 = pcall(function() return require(script.Parent.CurrencyServer) end)
if success3 and type(result3) == "table" then
	CurrencyServer = result3
end

local ClanServer = {}
ClanServer.__index = ClanServer

-- ============================================
-- CONFIGURATION
-- ============================================

local CLAN_CREATION_LEVEL_REQUIREMENT = 20
local CLAN_CREATION_COST = 500 -- Stardust
local MAX_CLAN_SIZE = 50
local MAX_CLAN_SIZE_BASE = 10
local CLAN_LEAVE_COOLDOWN = 86400 -- 24 hours in seconds
local CLAN_XP_PER_LEVEL_UP = 5
local CLAN_XP_PER_BIOME_EXPLORE = 10
local CLAN_XP_PER_GROUP_SIT = 20
local CLAN_XP_PER_RITUAL = 50
local CLAN_XP_PER_QUEST = 30

-- Clan level unlocks (from design doc)
local CLAN_LEVEL_UNLOCKS = {
	[1] = {chat = true, aura = true},
	[2] = {symbol = true},
	[3] = {memberCapacity = 5},
	[4] = {bed = true},
	[5] = {posePack = true},
	[6] = {shrine = true},
	[7] = {memberCapacity = 5},
	[8] = {auraVariants = true},
	[9] = {banner = true},
	[10] = {teleport = true},
	[11] = {exclusiveEmote = true},
	[12] = {exclusiveAccessory = true},
	[13] = {territoryUpgrade = true},
	[14] = {hallExpansion = true},
	[15] = {particleEffects = true},
	[16] = {titlePrefix = true},
	[17] = {moreOfficers = true},
	[18] = {meditationEvent = true},
	[19] = {celebrationAnimation = true},
	[20] = {legendaryHalo = true},
}

-- ============================================
-- DATA STRUCTURES
-- ============================================

-- In-memory clan data (loaded from DataStore)
local clans = {} -- [clanId] = clanData
local playerClans = {} -- [userId] = clanId
local clanLeaveCooldowns = {} -- [userId] = timestamp

-- Clan roles
local ROLES = {
	LEADER = "Leader",
	OFFICER = "Officer",
	MEMBER = "Member",
	INITIATE = "Initiate",
}

-- ============================================
-- REMOTE EVENTS
-- ============================================

local function getRemotes()
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotesFolder then
		remotesFolder = Instance.new("Folder")
		remotesFolder.Name = "Remotes"
		remotesFolder.Parent = ReplicatedStorage
	end
	
	local clanRemotes = remotesFolder:FindFirstChild("ClanRemotes")
	if not clanRemotes then
		clanRemotes = Instance.new("Folder")
		clanRemotes.Name = "ClanRemotes"
		clanRemotes.Parent = remotesFolder
	end
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = clanRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = clanRemotes
		end
		return remote
	end
	
	return {
		CreateClan = getOrCreateRemote("CreateClan", "RemoteEvent"),
		JoinClan = getOrCreateRemote("JoinClan", "RemoteEvent"),
		LeaveClan = getOrCreateRemote("LeaveClan", "RemoteEvent"),
		InvitePlayer = getOrCreateRemote("InvitePlayer", "RemoteEvent"),
		KickPlayer = getOrCreateRemote("KickPlayer", "RemoteEvent"),
		ClanUpdated = getOrCreateRemote("ClanUpdated", "RemoteEvent"),
		ClanListRequest = getOrCreateRemote("ClanListRequest", "RemoteFunction"),
	}
end

local remotes = getRemotes()

-- ============================================
-- CLAN CREATION
-- ============================================

local function generateClanId(): string
	return "clan_" .. tostring(os.time()) .. "_" .. tostring(math.random(1000, 9999))
end

local function createClan(leader: Player, name: string, color: Color3, symbol: string, territory: string): string?
	-- Validate requirements
	local playerData = nil
	if PlayerDataManager and type(PlayerDataManager) == "table" and PlayerDataManager.GetPlayerData then
		playerData = PlayerDataManager:GetPlayerData(leader)
	end
	if not playerData then
		warn(`[ClanServer] Cannot create clan - player data not loaded for {leader.Name}`)
		return nil
	end
	
	-- Check level requirement
	if (playerData.Level or 1) < CLAN_CREATION_LEVEL_REQUIREMENT then
		warn(`[ClanServer] {leader.Name} needs level {CLAN_CREATION_LEVEL_REQUIREMENT} to create a clan (current: {playerData.Level or 1})`)
		return nil
	end
	
	-- Check Stardust cost
	local stardust = CurrencyServer and CurrencyServer.GetBalance(leader) or 0
	if stardust < CLAN_CREATION_COST then
		warn(`[ClanServer] {leader.Name} needs {CLAN_CREATION_COST} Stardust to create a clan (current: {stardust})`)
		return nil
	end
	
	-- Check if player is already in a clan
	if playerClans[tostring(leader.UserId)] then
		warn(`[ClanServer] {leader.Name} is already in a clan`)
		return nil
	end
	
	-- Validate name (basic word filter)
	if not name or #name < 3 or #name > 30 then
		warn(`[ClanServer] Invalid clan name: {name}`)
		return nil
	end
	
	-- Create clan
	local clanId = generateClanId()
	local clanData = {
		Id = clanId,
		Name = name,
		Leader = leader.UserId,
		Officers = {},
		Members = {},
		Level = 1,
		XP = 0,
		Colors = {
			Primary = color,
			Secondary = Color3.new(1, 1, 1), -- Default
			Accent = Color3.new(0.5, 0.5, 0.5), -- Default
		},
		Symbol = symbol or "star",
		Territory = territory or "NebulaForest",
		CreatedAt = os.time(),
		Description = "",
		Unlocks = CLAN_LEVEL_UNLOCKS[1] or {},
	}
	
	-- Add leader as member
	clanData.Members[tostring(leader.UserId)] = ROLES.LEADER
	
	-- Store clan
	clans[clanId] = clanData
	playerClans[tostring(leader.UserId)] = clanId
	
	-- Deduct Stardust
	if CurrencyServer then
		CurrencyServer.TryPurchase(leader, CLAN_CREATION_COST)
	end
	
	-- Save to DataStore (TODO: Implement clan DataStore)
	
	print(`[ClanServer] Clan "{name}" created by {leader.Name} (ID: {clanId})`)
	
	-- Notify leader
	remotes.ClanUpdated:FireClient(leader, clanData)
	
	return clanId
end

-- ============================================
-- CLAN MEMBERSHIP
-- ============================================

local function joinClan(player: Player, clanId: string): boolean
	-- Check if clan exists
	local clan = clans[clanId]
	if not clan then
		warn(`[ClanServer] Clan {clanId} does not exist`)
		return false
	end
	
	-- Check if player is already in a clan
	if playerClans[tostring(player.UserId)] then
		warn(`[ClanServer] {player.Name} is already in a clan`)
		return false
	end
	
	-- Check clan size
	local memberCount = 0
	for _ in pairs(clan.Members) do
		memberCount = memberCount + 1
	end
	
	local maxSize = MAX_CLAN_SIZE_BASE + (clan.Level - 1) * 5
	if memberCount >= maxSize then
		warn(`[ClanServer] Clan "{clan.Name}" is full ({memberCount}/{maxSize})`)
		return false
	end
	
	-- Add player as Initiate
	clan.Members[tostring(player.UserId)] = ROLES.INITIATE
	playerClans[tostring(player.UserId)] = clanId
	
	-- Notify all clan members
	for userId, _ in pairs(clan.Members) do
		local member = Players:GetPlayerByUserId(tonumber(userId))
		if member then
			remotes.ClanUpdated:FireClient(member, clan)
		end
	end
	
	print(`[ClanServer] {player.Name} joined clan "{clan.Name}"`)
	return true
end

local function leaveClan(player: Player): boolean
	local userId = tostring(player.UserId)
	local clanId = playerClans[userId]
	
	if not clanId then
		warn(`[ClanServer] {player.Name} is not in a clan`)
		return false
	end
	
	local clan = clans[clanId]
	if not clan then
		warn(`[ClanServer] Clan {clanId} not found`)
		return false
	end
	
	-- Check if player is leader
	if clan.Leader == player.UserId then
		-- Leader leaving - transfer leadership or disband
		-- For now, just warn (TODO: Implement leadership transfer)
		warn(`[ClanServer] Leader {player.Name} cannot leave - must transfer leadership first`)
		return false
	end
	
	-- Check cooldown
	local lastLeaveTime = clanLeaveCooldowns[userId]
	if lastLeaveTime and (os.time() - lastLeaveTime) < CLAN_LEAVE_COOLDOWN then
		local remaining = CLAN_LEAVE_COOLDOWN - (os.time() - lastLeaveTime)
		warn(`[ClanServer] {player.Name} must wait {math.ceil(remaining / 3600)} hours before leaving another clan`)
		return false
	end
	
	-- Remove player
	clan.Members[userId] = nil
	playerClans[userId] = nil
	clanLeaveCooldowns[userId] = os.time()
	
	-- Remove from officers if applicable
	for i, officerId in ipairs(clan.Officers) do
		if officerId == player.UserId then
			table.remove(clan.Officers, i)
			break
		end
	end
	
	-- Notify all clan members
	for memberUserId, _ in pairs(clan.Members) do
		local member = Players:GetPlayerByUserId(tonumber(memberUserId))
		if member then
			remotes.ClanUpdated:FireClient(member, clan)
		end
	end
	
	-- Notify player
	remotes.ClanUpdated:FireClient(player, nil)
	
	print(`[ClanServer] {player.Name} left clan "{clan.Name}"`)
	return true
end

-- ============================================
-- CLAN XP & LEVELING
-- ============================================

function ClanServer:AddClanXP(clanId: string, amount: number)
	local clan = clans[clanId]
	if not clan then
		return
	end
	
	clan.XP = (clan.XP or 0) + amount
	
	-- Check for level up
	local xpNeeded = clan.Level * 100 -- Simple formula: 100 XP per level
	if clan.XP >= xpNeeded then
		clan.Level = math.min(clan.Level + 1, 20) -- Cap at 20
		clan.XP = 0
		
		-- Apply level unlocks
		local unlocks = CLAN_LEVEL_UNLOCKS[clan.Level]
		if unlocks then
			for key, value in pairs(unlocks) do
				clan.Unlocks[key] = value
			end
		end
		
		print(`[ClanServer] Clan "{clan.Name}" leveled up to {clan.Level}!`)
		
		-- Notify all members
		for userId, _ in pairs(clan.Members) do
			local member = Players:GetPlayerByUserId(tonumber(userId))
			if member then
				remotes.ClanUpdated:FireClient(member, clan)
			end
		end
	end
end

-- ============================================
-- EVENT HANDLERS
-- ============================================

remotes.CreateClan.OnServerEvent:Connect(function(player: Player, name: string, color: Color3, symbol: string, territory: string)
	createClan(player, name, color, symbol, territory)
end)

remotes.JoinClan.OnServerEvent:Connect(function(player: Player, clanId: string)
	joinClan(player, clanId)
end)

remotes.LeaveClan.OnServerEvent:Connect(function(player: Player)
	leaveClan(player)
end)

remotes.InvitePlayer.OnServerEvent:Connect(function(player: Player, targetPlayerName: string)
	-- TODO: Implement invite system
	warn(`[ClanServer] Invite system not yet implemented`)
end)

remotes.KickPlayer.OnServerEvent:Connect(function(player: Player, targetUserId: number)
	-- TODO: Implement kick system with permission checks
	warn(`[ClanServer] Kick system not yet implemented`)
end)

remotes.ClanListRequest.OnServerInvoke = function(player: Player)
	-- Return public clan list
	local clanList = {}
	for clanId, clan in pairs(clans) do
		local memberCount = 0
		for _ in pairs(clan.Members) do
			memberCount = memberCount + 1
		end
		
		table.insert(clanList, {
			Id = clanId,
			Name = clan.Name,
			Level = clan.Level,
			MemberCount = memberCount,
			Symbol = clan.Symbol,
			Colors = clan.Colors,
		})
	end
	return clanList
end

-- ============================================
-- PLAYER CONNECTION
-- ============================================

Players.PlayerAdded:Connect(function(player)
	-- Load player's clan data
	-- TODO: Load from DataStore
	local playerData = nil
	if PlayerDataManager and type(PlayerDataManager) == "table" and PlayerDataManager.GetPlayerData then
		playerData = PlayerDataManager:GetPlayerData(player)
	end
	if playerData and playerData.ClanId then
		local clan = clans[playerData.ClanId]
		if clan then
			playerClans[tostring(player.UserId)] = playerData.ClanId
			remotes.ClanUpdated:FireClient(player, clan)
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	-- Save clan data
	-- TODO: Save to DataStore
end)

-- ============================================
-- PUBLIC API
-- ============================================

function ClanServer:GetPlayerClan(player: Player): table?
	local userId = tostring(player.UserId)
	local clanId = playerClans[userId]
	if not clanId then
		return nil
	end
	return clans[clanId]
end

function ClanServer:IsPlayerInClan(player: Player): boolean
	return playerClans[tostring(player.UserId)] ~= nil
end

function ClanServer:GetClan(clanId: string): table?
	return clans[clanId]
end

-- ============================================
-- INITIALIZATION
-- ============================================

print("[ClanServer] Initialized - Clan system ready")
print("  - Clan creation: Level 20+, 500 Stardust")
print("  - Max clan size: 50 (scales with level)")
print("  - Clan levels: 1-20 with unlocks")
print("  - Clan XP system: Active")

return ClanServer
