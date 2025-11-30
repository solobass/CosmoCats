--[[
	NPCManager.server.lua
	Manages NPCs for Cosmo Cats: Wandering Spirits, Ancient Guardians, and Lore NPCs.
	Implements NPC system from NPCS_WORLD_LORE_SPIRITS_BIBLE.md
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local PathfindingService = game:GetService("PathfindingService")

local NPCManager = {}
NPCManager.__index = NPCManager

-- ============================================
-- NPC TYPES
-- ============================================

-- Wandering Spirits (Friendly, random spawns)
local WANDERING_SPIRITS = {
	{
		Name = "NebulaWisp",
		Biome = "NebulaForest",
		SpawnChance = 0.3,
		StardustReward = 3,
	},
	{
		Name = "CrystalEcho",
		Biome = "LunarCaverns",
		SpawnChance = 0.25,
		StardustReward = 5,
	},
	{
		Name = "SandstarGhost",
		Biome = "StarfallDesert",
		SpawnChance = 0.2,
		StardustReward = 4,
	},
	{
		Name = "CometGuide",
		Biome = "CometShores",
		SpawnChance = 0.3,
		StardustReward = 3,
	},
	{
		Name = "VoidEcho",
		Biome = "VoidTemple",
		SpawnChance = 0.15,
		StardustReward = 10,
	},
}

-- Ancient Guardians (Rare, majestic)
local ANCIENT_GUARDIANS = {
	{
		Name = "MoonLynx",
		Biome = "LunarCaverns",
		SpawnChance = 0.05,
		LoreFragment = true,
		PrestigeReward = 1,
	},
	{
		Name = "SolarTiger",
		Biome = "StarfallDesert",
		SpawnChance = 0.05,
		LoreFragment = true,
		PrestigeReward = 1,
	},
	{
		Name = "DreamLeviathan",
		Biome = "OuterRim",
		SpawnChance = 0.02,
		LoreFragment = true,
		PrestigeReward = 2,
	},
	{
		Name = "VoidSentinel",
		Biome = "VoidTemple",
		SpawnChance = 0.03,
		LoreFragment = true,
		PrestigeReward = 1,
	},
}

-- Lore NPCs (Stationary, provide lore)
local LORE_NPCS = {
	{
		Name = "StarberryMerchant",
		Biome = "NebulaForest",
		Position = Vector3.new(0, 5, 0), -- TODO: Set actual positions
		LoreLines = {
			"I remember when the sky was whole. Do you?",
			"Follow the drifting petals. They lead to forgotten places.",
		},
	},
	{
		Name = "CrystalArchivist",
		Biome = "LunarCaverns",
		Position = Vector3.new(0, 5, 0),
		LoreLines = {
			"Crystals remember everything.",
			"The moon holds secrets older than the stars.",
		},
	},
	{
		Name = "VoidScribe",
		Biome = "VoidTemple",
		Position = Vector3.new(0, 5, 0),
		LoreLines = {
			"The Void does not hunger. It listens.",
			"In the beginning, the nebula sang with a thousand voices.",
		},
	},
}

-- ============================================
-- NPC INSTANCES
-- ============================================

local activeNPCs = {} -- [npcInstance] = npcData
local npcModels = {} -- [npcName] = model

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
	
	local npcRemotes = remotesFolder:FindFirstChild("NPCRemotes")
	if not npcRemotes then
		npcRemotes = Instance.new("Folder")
		npcRemotes.Name = "NPCRemotes"
		npcRemotes.Parent = remotesFolder
	end
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = npcRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = npcRemotes
		end
		return remote
	end
	
	return {
		InteractNPC = getOrCreateRemote("InteractNPC", "RemoteEvent"),
		NPCDialogue = getOrCreateRemote("NPCDialogue", "RemoteEvent"),
	}
end

local remotes = getRemotes()

-- ============================================
-- NPC SPAWNING
-- ============================================

local function spawnWanderingSpirit(spiritData: table, biome: Instance?): Instance?
	-- TODO: Load spirit model from ReplicatedStorage
	-- TODO: Spawn at random location in biome
	-- TODO: Set up wandering AI
	-- TODO: Add interaction prompt
	
	warn(`[NPCManager] Spawning {spiritData.Name} in {spiritData.Biome} (not yet implemented)`)
	return nil
end

local function spawnGuardian(guardianData: table, biome: Instance?): Instance?
	-- TODO: Load guardian model from ReplicatedStorage
	-- TODO: Spawn at shrine location
	-- TODO: Set up majestic animations
	-- TODO: Add lore interaction
	
	warn(`[NPCManager] Spawning {guardianData.Name} in {guardianData.Biome} (not yet implemented)`)
	return nil
end

local function spawnLoreNPC(loreNPCData: table, biome: Instance?): Instance?
	-- TODO: Load NPC model from ReplicatedStorage
	-- TODO: Spawn at fixed position
	-- TODO: Set up dialogue system
	-- TODO: Add interaction prompt
	
	warn(`[NPCManager] Spawning {loreNPCData.Name} in {loreNPCData.Biome} (not yet implemented)`)
	return nil
end

-- ============================================
-- NPC INTERACTIONS
-- ============================================

remotes.InteractNPC.OnServerEvent:Connect(function(player: Player, npcInstance: Instance)
	local npcData = activeNPCs[npcInstance]
	if not npcData then
		return
	end
	
	-- Handle interaction based on NPC type
	if npcData.Type == "WanderingSpirit" then
		-- Give Stardust reward
		-- TODO: Use CurrencyServer
		print(`[NPCManager] {player.Name} interacted with {npcData.Name} - Stardust reward`)
		
	elseif npcData.Type == "Guardian" then
		-- Give lore fragment and Prestige
		-- TODO: Give rewards
		print(`[NPCManager] {player.Name} interacted with {npcData.Name} - Lore & Prestige reward`)
		
	elseif npcData.Type == "LoreNPC" then
		-- Show dialogue
		local loreLines = npcData.LoreLines or {}
		local randomLine = loreLines[math.random(1, #loreLines)]
		remotes.NPCDialogue:FireClient(player, npcData.Name, randomLine)
		print(`[NPCManager] {player.Name} talked to {npcData.Name}`)
	end
end)

-- ============================================
-- INITIALIZATION
-- ============================================

-- Spawn Lore NPCs (stationary)
task.spawn(function()
	task.wait(5) -- Wait for world to load
	
	-- TODO: Find biome folders and spawn Lore NPCs
	-- For now, just log
	print("[NPCManager] Lore NPCs will spawn when biomes are created")
end)

-- Spawn Wandering Spirits periodically
task.spawn(function()
	while true do
		task.wait(300) -- Check every 5 minutes
		
		-- TODO: Spawn wandering spirits based on chance
		-- For now, just log
	end
end)

print("[NPCManager] Initialized - NPC system ready")
print("  - Wandering Spirits: " .. #WANDERING_SPIRITS)
print("  - Ancient Guardians: " .. #ANCIENT_GUARDIANS)
print("  - Lore NPCs: " .. #LORE_NPCS)
print("  - NPC spawning: Active (models needed)")

return NPCManager

