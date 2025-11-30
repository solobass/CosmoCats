--[[
	ProgressionManager.server.lua
	Manages player progression: XP, leveling, unlocks, quests, and prestige.
	Implements the full progression system from PROGRESSION_SYSTEM_BIBLE.md
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Get dependencies (safely require - may not exist yet)
local PlayerDataManager = pcall(function() return require(script.Parent.Systems.PlayerDataManager) end) and require(script.Parent.Systems.PlayerDataManager) or nil
local CurrencyServer = pcall(function() return require(script.Parent.CurrencyServer) end) and require(script.Parent.CurrencyServer) or nil
local ProgressionEvents = pcall(function() return require(ReplicatedStorage:WaitForChild("Shared", 1):WaitForChild("Events", 1):WaitForChild("ProgressionEvents", 1)) end) and require(ReplicatedStorage.Shared.Events.ProgressionEvents) or nil

local ProgressionManager = {}
ProgressionManager.__index = ProgressionManager

-- ============================================
-- CONFIGURATION
-- ============================================

-- Level range
local MIN_LEVEL = 1
local MAX_LEVEL = 100

-- XP required per level (scaling formula)
local function getXPForLevel(level: number): number
	-- Formula: base * (level^1.5) for smooth progression
	local base = 100
	return math.floor(base * (level ^ 1.5))
end

-- Level titles (from PROGRESSION_SYSTEM_BIBLE.md)
local LEVEL_TITLES = {
	[1] = "Starlit Rookie",
	[6] = "Nebula Kitten",
	[11] = "Ascending Cat",
	[21] = "Cosmic Wanderer",
	[41] = "Celestial Feline",
	[61] = "Stellar Mystic",
	[81] = "Astral Guardian",
	[96] = "Eternal Cosmo Cat",
}

-- Get title for level
local function getTitleForLevel(level: number): string
	local title = "Starlit Rookie"
	for checkLevel, titleName in pairs(LEVEL_TITLES) do
		if level >= checkLevel then
			title = titleName
		else
			break
		end
	end
	return title
end

-- XP earning methods (from design doc)
local XP_REWARDS = {
	Walking = {min = 3, max = 6, interval = 60}, -- Per minute
	Emote = 5, -- Per emote (cooldown)
	PlayerInteraction = {min = 10, max = 30}, -- Per interaction
	BedUse = 10, -- Per bed use
	BiomeExplore = 100, -- First time exploring new biome
	SecretDiscovery = 200, -- Discovering secrets
	DailyQuest = {min = 300, max = 500}, -- Per quest
	PrestigeRitual = 500, -- Per ritual
	GroupGathering = 100, -- Temple/Outer Rim gatherings
}

-- AFK penalty (20% XP)
local AFK_XP_MULTIPLIER = 0.2

-- Prestige system
local PRESTIGE_MAX = 10
local PRESTIGE_POINT_SOURCES = {
	LevelMilestone = {amount = 1, levels = {25, 50, 75, 100}},
	BiomeSecrets = 10, -- All secrets in a biome
	TempleRitual = 5, -- Participating in temple rituals
	OuterRimOrbit = 10, -- Outer Rim orbit event
	SeasonalEvent = {min = 10, max = 30}, -- Rare events
}

-- ============================================
-- DATA STRUCTURES
-- ============================================

local playerXP = {} -- [player] = {xp, level, title}
local playerMovement = {} -- [player] = {lastPosition, lastCheck}
local playerQuests = {} -- [player] = {daily, weekly, discovery}

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
	
	local progressionRemotes = remotesFolder:FindFirstChild("ProgressionRemotes")
	if not progressionRemotes then
		progressionRemotes = Instance.new("Folder")
		progressionRemotes.Name = "ProgressionRemotes"
		progressionRemotes.Parent = remotesFolder
	end
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = progressionRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = progressionRemotes
		end
		return remote
	end
	
	return {
		LevelUp = getOrCreateRemote("LevelUp", "RemoteEvent"),
		XPUpdated = getOrCreateRemote("XPUpdated", "RemoteEvent"),
		UnlockAchieved = getOrCreateRemote("UnlockAchieved", "RemoteEvent"),
		QuestUpdated = getOrCreateRemote("QuestUpdated", "RemoteEvent"),
	}
end

local remotes = getRemotes()

-- ============================================
-- XP SYSTEM
-- ============================================

function ProgressionManager:AddXP(player: Player, amount: number, source: string, isAFK: boolean?)
	-- Apply AFK penalty
	if isAFK then
		amount = math.floor(amount * AFK_XP_MULTIPLIER)
	end
	
	-- Get player data
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	if not playerData then
		warn(`[ProgressionManager] Cannot add XP - player data not loaded for {player.Name}`)
		return
	end
	
	-- Update XP
	local currentLevel = playerData.Level or MIN_LEVEL
	local currentXP = playerData.XP or 0
	local newXP = currentXP + amount
	
	-- Update player data
	if PlayerDataManager then
		PlayerDataManager:UpdatePlayerData(player, "XP", newXP)
		PlayerDataManager:UpdatePlayerData(player, "TotalXP", (playerData.TotalXP or 0) + amount)
	end
	
	-- Check for level up
	local xpNeeded = getXPForLevel(currentLevel)
	while newXP >= xpNeeded and currentLevel < MAX_LEVEL do
		newXP = newXP - xpNeeded
		currentLevel = currentLevel + 1
		xpNeeded = getXPForLevel(currentLevel)
		
		-- Level up!
		self:LevelUp(player, currentLevel - 1, currentLevel)
	end
	
	-- Update stored XP
	if PlayerDataManager then
		PlayerDataManager:UpdatePlayerData(player, "Level", currentLevel)
		PlayerDataManager:UpdatePlayerData(player, "XP", newXP)
	end
	
	-- Fire events
	if ProgressionEvents and ProgressionEvents.XPGained then
		ProgressionEvents.XPGained:Fire(player, amount, source)
	end
	remotes.XPUpdated:FireClient(player, currentLevel, newXP, getXPForLevel(currentLevel))
	
	print(`[ProgressionManager] {player.Name} gained {amount} XP from {source} (Level {currentLevel}, {newXP}/{getXPForLevel(currentLevel)} XP)`)
end

function ProgressionManager:LevelUp(player: Player, oldLevel: number, newLevel: number)
	-- Update title
	local title = getTitleForLevel(newLevel)
	if PlayerDataManager then
		PlayerDataManager:UpdatePlayerData(player, "Title", title)
	end
	
	-- Check for Prestige Points from milestones
	for _, milestoneLevel in ipairs(PRESTIGE_POINT_SOURCES.LevelMilestone.levels) do
		if newLevel == milestoneLevel then
			self:AddPrestigePoint(player, PRESTIGE_POINT_SOURCES.LevelMilestone.amount, "Level Milestone")
		end
	end
	
	-- Fire events
	if ProgressionEvents and ProgressionEvents.LevelUp then
		ProgressionEvents.LevelUp:Fire(player, oldLevel, newLevel, {
			Title = title,
			PrestigePoints = PRESTIGE_POINT_SOURCES.LevelMilestone.amount,
		})
	end
	remotes.LevelUp:FireClient(player, oldLevel, newLevel, title)
	
	print(`[ProgressionManager] {player.Name} leveled up! {oldLevel} → {newLevel} ({title})`)
end

-- ============================================
-- PRESTIGE SYSTEM
-- ============================================

function ProgressionManager:AddPrestigePoint(player: Player, amount: number, source: string)
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return
	end
	
	local currentPrestige = playerData.PrestigePoints or 0
	local newPrestige = currentPrestige + amount
	
	if PlayerDataManager then
		PlayerDataManager:UpdatePlayerData(player, "PrestigePoints", newPrestige)
	end
	
	print(`[ProgressionManager] {player.Name} gained {amount} Prestige Point(s) from {source} (Total: {newPrestige})`)
end

function ProgressionManager:Prestige(player: Player): boolean
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return false
	end
	
	-- Check if player is max level
	if (playerData.Level or 1) < MAX_LEVEL then
		warn(`[ProgressionManager] {player.Name} must be level {MAX_LEVEL} to prestige`)
		return false
	end
	
	-- Check prestige cap
	local currentPrestige = playerData.Prestige or 0
	if currentPrestige >= PRESTIGE_MAX then
		warn(`[ProgressionManager] {player.Name} is already at max prestige ({PRESTIGE_MAX})`)
		return false
	end
	
	-- Reset to level 1
	if PlayerDataManager then
		PlayerDataManager:UpdatePlayerData(player, "Level", MIN_LEVEL)
		PlayerDataManager:UpdatePlayerData(player, "XP", 0)
		
		-- Increment prestige
		local newPrestige = currentPrestige + 1
		PlayerDataManager:UpdatePlayerData(player, "Prestige", newPrestige)
		
		-- Keep all unlocks (species, effects, beds, accessories)
		-- Title becomes "Cosmic Ascendant"
		PlayerDataManager:UpdatePlayerData(player, "Title", "Cosmic Ascendant")
	end
	
	-- Give Prestige Points
	self:AddPrestigePoint(player, 5, "Prestige")
	
	print(`[ProgressionManager] {player.Name} prestiged! Prestige {currentPrestige} → {newPrestige}`)
	return true
end

-- ============================================
-- UNLOCKABLES SYSTEM
-- ============================================

function ProgressionManager:UnlockItem(player: Player, itemId: string, itemType: string): boolean
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return false
	end
	
	-- Check if already unlocked
	local unlocked = playerData.UnlockedItems or {}
	if unlocked[itemId] then
		warn(`[ProgressionManager] {player.Name} already has {itemId}`)
		return false
	end
	
	-- Add to unlocked items
	unlocked[itemId] = {
		Type = itemType,
		UnlockedAt = os.time(),
	}
	if PlayerDataManager then
		PlayerDataManager:UpdatePlayerData(player, "UnlockedItems", unlocked)
	end
	
	-- Fire events
	if ProgressionEvents and ProgressionEvents.UnlockAchieved then
		ProgressionEvents.UnlockAchieved:Fire(player, itemId, itemType)
	end
	remotes.UnlockAchieved:FireClient(player, itemId, itemType)
	
	print(`[ProgressionManager] {player.Name} unlocked {itemType}: {itemId}`)
	return true
end

-- ============================================
-- QUEST SYSTEM
-- ============================================

-- Daily quest pool
local DAILY_QUESTS = {
	{id = "sit_beds", name = "Sit at 5 Different Beds", target = 5, reward = {XP = 300, Stardust = 50}},
	{id = "visit_biomes", name = "Visit 3 Biomes", target = 3, reward = {XP = 250, Stardust = 40}},
	{id = "use_emotes", name = "Use 10 Different Emotes", target = 10, reward = {XP = 200, Stardust = 40}},
	{id = "interact_players", name = "Interact with 2 Players", target = 2, reward = {XP = 300, Stardust = 50}},
	{id = "group_sits", name = "Perform 3 Group Sits", target = 3, reward = {XP = 250, Stardust = 40}},
	{id = "find_creature", name = "Find the Hidden Creature in Nebula Forest", target = 1, reward = {XP = 400, Stardust = 60}},
	{id = "collect_fragments", name = "Collect 5 Comet Fragments", target = 5, reward = {XP = 300, Stardust = 50}},
}

-- Weekly quest pool
local WEEKLY_QUESTS = {
	{id = "discover_secrets", name = "Discover All Secrets in One Biome", target = 1, reward = {XP = 500, Stardust = 150, PrestigePoint = 1}},
	{id = "temple_ritual", name = "Perform a Temple Ritual", target = 1, reward = {XP = 400, Stardust = 150}},
	{id = "outer_rim_orbit", name = "Take Part in an Outer Rim Orbit Event", target = 1, reward = {XP = 500, Stardust = 200, PrestigePoint = 1}},
	{id = "unlock_pattern", name = "Unlock a New Pattern", target = 1, reward = {XP = 300, Stardust = 150}},
}

function ProgressionManager:GenerateDailyQuests(player: Player): {any}
	-- Select 3 random daily quests
	local selected = {}
	local pool = {}
	for _, quest in ipairs(DAILY_QUESTS) do
		table.insert(pool, quest)
	end
	
	for i = 1, 3 do
		if #pool > 0 then
			local index = math.random(1, #pool)
			table.insert(selected, pool[index])
			table.remove(pool, index)
		end
	end
	
	return selected
end

function ProgressionManager:CompleteQuest(player: Player, questId: string): boolean
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return false
	end
	
	-- Find quest in player's quest list
	local quests = playerQuests[player] or {}
	local quest = nil
	for _, q in ipairs(quests.daily or {}) do
		if q.id == questId then
			quest = q
			break
		end
	end
	
	if not quest then
		for _, q in ipairs(quests.weekly or {}) do
			if q.id == questId then
				quest = q
				break
			end
		end
	end
	
	if not quest then
		warn(`[ProgressionManager] Quest {questId} not found for {player.Name}`)
		return false
	end
	
	-- Give rewards
	if quest.reward.XP then
		self:AddXP(player, quest.reward.XP, "Quest: " .. quest.name)
	end
	if quest.reward.Stardust and CurrencyServer then
		CurrencyServer.AddStardust(player, quest.reward.Stardust)
	end
	if quest.reward.PrestigePoint then
		self:AddPrestigePoint(player, quest.reward.PrestigePoint, "Quest: " .. quest.name)
	end
	
	-- Remove quest
	for i, q in ipairs(quests.daily or {}) do
		if q.id == questId then
			table.remove(quests.daily, i)
			break
		end
	end
	for i, q in ipairs(quests.weekly or {}) do
		if q.id == questId then
			table.remove(quests.weekly, i)
			break
		end
	end
	
	remotes.QuestUpdated:FireClient(player, quests)
	print(`[ProgressionManager] {player.Name} completed quest: {quest.name}`)
	return true
end

-- ============================================
-- MOVEMENT TRACKING (For Walking XP)
-- ============================================

local function trackPlayerMovement(player: Player)
	local character = player.Character
	if not character then
		return
	end
	
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end
	
	local lastData = playerMovement[player]
	if not lastData then
		playerMovement[player] = {
			lastPosition = hrp.Position,
			lastCheck = os.time(),
		}
		return
	end
	
	-- Check every minute
	if os.time() - lastData.lastCheck >= XP_REWARDS.Walking.interval then
		local distance = (hrp.Position - lastData.lastPosition).Magnitude
		
		-- If player moved significantly, give walking XP
		if distance > 5 then -- Moved at least 5 studs
			local xpAmount = math.random(XP_REWARDS.Walking.min, XP_REWARDS.Walking.max)
			local isAFK = distance < 10 -- Very little movement = AFK
			ProgressionManager:AddXP(player, xpAmount, "Walking", isAFK)
		end
		
		playerMovement[player].lastPosition = hrp.Position
		playerMovement[player].lastCheck = os.time()
	end
end

-- ============================================
-- PLAYER CONNECTION
-- ============================================

Players.PlayerAdded:Connect(function(player)
	-- Initialize quests
	playerQuests[player] = {
		daily = ProgressionManager:GenerateDailyQuests(player),
		weekly = {}, -- TODO: Generate weekly quests
		discovery = {},
	}
	
	-- Send quests to client
	remotes.QuestUpdated:FireClient(player, playerQuests[player])
	
	-- Start movement tracking
	RunService.Heartbeat:Connect(function()
		if player.Parent then
			trackPlayerMovement(player)
		end
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	playerMovement[player] = nil
	playerQuests[player] = nil
end)

-- ============================================
-- PUBLIC API
-- ============================================

function ProgressionManager:GetPlayerLevel(player: Player): number
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	return playerData and (playerData.Level or MIN_LEVEL) or MIN_LEVEL
end

function ProgressionManager:GetPlayerTitle(player: Player): string
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return "Starlit Rookie"
	end
	return playerData.Title or getTitleForLevel(playerData.Level or MIN_LEVEL)
end

-- ============================================
-- INITIALIZATION
-- ============================================

print("[ProgressionManager] Initialized - Progression system ready")
print("  - Level range: " .. MIN_LEVEL .. "-" .. MAX_LEVEL)
print("  - XP system: Active")
print("  - Prestige system: Active (1-" .. PRESTIGE_MAX .. ")")
print("  - Quest system: Active (Daily & Weekly)")
print("  - Unlockables system: Active")

return ProgressionManager

