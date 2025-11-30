--[[
	ShrineManager.server.lua
	Manages shrines, lore fragments, and memory sequences.
	Implements the lore system from NPCS_WORLD_LORE_SPIRITS_BIBLE.md
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Get dependencies (safely require - may not exist yet)
local PlayerDataManager = pcall(function() return require(script.Parent.Systems.PlayerDataManager) end) and require(script.Parent.Systems.PlayerDataManager) or nil
local ProgressionManager = pcall(function() return require(script.Parent.ProgressionManager) end) and require(script.Parent.ProgressionManager) or nil
local CurrencyServer = pcall(function() return require(script.Parent.CurrencyServer) end) and require(script.Parent.CurrencyServer) or nil

local ShrineManager = {}
ShrineManager.__index = ShrineManager

-- ============================================
-- SHRINE LOCATIONS
-- ============================================

local SHRINES = {
	{
		Name = "NebulaShrine",
		Biome = "NebulaForest",
		Position = Vector3.new(0, 5, 0), -- TODO: Set actual positions
		LoreFragments = 5,
	},
	{
		Name = "CrystalShrine",
		Biome = "LunarCaverns",
		Position = Vector3.new(0, 5, 0),
		LoreFragments = 5,
	},
	{
		Name = "StarfallShrine",
		Biome = "StarfallDesert",
		Position = Vector3.new(0, 5, 0),
		LoreFragments = 5,
	},
	{
		Name = "TideShrine",
		Biome = "CometShores",
		Position = Vector3.new(0, 5, 0),
		LoreFragments = 5,
	},
	{
		Name = "VoidShrine",
		Biome = "VoidTemple",
		Position = Vector3.new(0, 5, 0),
		LoreFragments = 5,
	},
	{
		Name = "AscendantShrine",
		Biome = "OuterRim",
		Position = Vector3.new(0, 5, 0),
		LoreFragments = 5,
	},
}

-- ============================================
-- LORE FRAGMENTS
-- ============================================

local LORE_FRAGMENTS = {
	{
		Id = "nebula_001",
		Biome = "NebulaForest",
		Text = "In the beginning, the nebula sang with a thousand voices.",
		Reward = {XP = 200, Stardust = 30},
	},
	{
		Id = "lunar_001",
		Biome = "LunarCaverns",
		Text = "Lunar crystals hold memories older than the stars.",
		Reward = {XP = 200, Stardust = 30},
	},
	{
		Id = "desert_001",
		Biome = "StarfallDesert",
		Text = "The desert is littered with dreams the sky has shed.",
		Reward = {XP = 200, Stardust = 30},
	},
	{
		Id = "void_001",
		Biome = "VoidTemple",
		Text = "The Void does not hunger. It listens.",
		Reward = {XP = 200, Stardust = 30, PrestigePoint = 1},
	},
	-- TODO: Add more lore fragments
}

-- ============================================
-- MEMORY SEQUENCES
-- ============================================

local MEMORY_SEQUENCES = {
	{
		Id = "nebula_awakening",
		Shrine = "NebulaShrine",
		RequiredFragments = 5,
		Duration = 8,
		Text = "The forest remembers when the cosmos was whole...",
		Reward = {XP = 500, Stardust = 100, PrestigePoint = 1},
	},
	-- TODO: Add more memory sequences
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
	
	local shrineRemotes = remotesFolder:FindFirstChild("ShrineRemotes")
	if not shrineRemotes then
		shrineRemotes = Instance.new("Folder")
		shrineRemotes.Name = "ShrineRemotes"
		shrineRemotes.Parent = remotesFolder
	end
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = shrineRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = shrineRemotes
		end
		return remote
	end
	
	return {
		CollectFragment = getOrCreateRemote("CollectFragment", "RemoteEvent"),
		ActivateShrine = getOrCreateRemote("ActivateShrine", "RemoteEvent"),
		MemorySequence = getOrCreateRemote("MemorySequence", "RemoteEvent"),
	}
end

local remotes = getRemotes()

-- ============================================
-- LORE FRAGMENT COLLECTION
-- ============================================

remotes.CollectFragment.OnServerEvent:Connect(function(player: Player, fragmentId: string)
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return
	end
	
	-- Find fragment
	local fragment = nil
	for _, f in ipairs(LORE_FRAGMENTS) do
		if f.Id == fragmentId then
			fragment = f
			break
		end
	end
	
	if not fragment then
		warn(`[ShrineManager] Fragment {fragmentId} not found`)
		return
	end
	
	-- Check if already collected
	local collectedFragments = playerData.CollectedLoreFragments or {}
	if collectedFragments[fragmentId] then
		warn(`[ShrineManager] {player.Name} already collected {fragmentId}`)
		return
	end
	
	-- Add to collected
	collectedFragments[fragmentId] = {
		CollectedAt = os.time(),
		Biome = fragment.Biome,
	}
	if PlayerDataManager then
		PlayerDataManager:UpdatePlayerData(player, "CollectedLoreFragments", collectedFragments)
	end
	
	-- Give rewards
	if fragment.Reward.XP and ProgressionManager then
		ProgressionManager:AddXP(player, fragment.Reward.XP, "Lore Fragment: " .. fragmentId)
	end
	if fragment.Reward.Stardust and CurrencyServer then
		CurrencyServer.AddStardust(player, fragment.Reward.Stardust)
	end
	if fragment.Reward.PrestigePoint and ProgressionManager then
		ProgressionManager:AddPrestigePoint(player, fragment.Reward.PrestigePoint, "Lore Fragment: " .. fragmentId)
	end
	
	print(`[ShrineManager] {player.Name} collected lore fragment: {fragmentId}`)
end)

-- ============================================
-- SHRINE ACTIVATION
-- ============================================

remotes.ActivateShrine.OnServerEvent:Connect(function(player: Player, shrineName: string)
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return
	end
	
	-- Find shrine
	local shrine = nil
	for _, s in ipairs(SHRINES) do
		if s.Name == shrineName then
			shrine = s
			break
		end
	end
	
	if not shrine then
		warn(`[ShrineManager] Shrine {shrineName} not found`)
		return
	end
	
	-- Count collected fragments for this biome
	local collectedFragments = playerData.CollectedLoreFragments or {}
	local biomeFragments = 0
	for fragmentId, data in pairs(collectedFragments) do
		if data.Biome == shrine.Biome then
			biomeFragments = biomeFragments + 1
		end
	end
	
	-- Check if enough fragments for memory sequence
	for _, sequence in ipairs(MEMORY_SEQUENCES) do
		if sequence.Shrine == shrineName and biomeFragments >= sequence.RequiredFragments then
			-- Trigger memory sequence
			remotes.MemorySequence:FireClient(player, sequence.Id, sequence.Text, sequence.Duration)
			
			-- Give rewards after sequence
			task.delay(sequence.Duration, function()
				if sequence.Reward.XP and ProgressionManager then
					ProgressionManager:AddXP(player, sequence.Reward.XP, "Memory Sequence: " .. sequence.Id)
				end
				if sequence.Reward.Stardust and CurrencyServer then
					CurrencyServer.AddStardust(player, sequence.Reward.Stardust)
				end
				if sequence.Reward.PrestigePoint and ProgressionManager then
					ProgressionManager:AddPrestigePoint(player, sequence.Reward.PrestigePoint, "Memory Sequence: " .. sequence.Id)
				end
			end)
			
			print(`[ShrineManager] {player.Name} activated memory sequence at {shrineName}`)
			return
		end
	end
	
	-- Regular shrine interaction (meditation)
	-- TODO: Apply shrine effects (glow, particles, sound)
	print(`[ShrineManager] {player.Name} activated shrine: {shrineName} ({biomeFragments}/{shrine.LoreFragments} fragments)`)
end)

-- ============================================
-- INITIALIZATION
-- ============================================

print("[ShrineManager] Initialized - Shrine system ready")
print("  - Shrines: " .. #SHRINES)
print("  - Lore fragments: " .. #LORE_FRAGMENTS)
print("  - Memory sequences: " .. #MEMORY_SEQUENCES)
print("  - Shrine activation: Active")

return ShrineManager

