--[[
	EventManager.server.lua
	Manages global events for Cosmo Cats.
	Implements Tier 1, 2, 3, and Ultra-Rare events from GLOBAL_EVENTS_SYSTEM_BIBLE.md
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local EventManager = {}
EventManager.__index = EventManager

-- ============================================
-- EVENT DEFINITIONS
-- ============================================

-- Tier 1 Events (Frequent, every 10-30 minutes)
local TIER_1_EVENTS = {
	{
		Name = "NebulaBloom",
		DisplayName = "Nebula Bloom",
		Duration = 60,
		Cooldown = 600, -- 10 minutes
		Biome = "NebulaForest",
		Rewards = {Stardust = 10},
	},
	{
		Name = "CrystalResonance",
		DisplayName = "Crystal Resonance",
		Duration = 45,
		Cooldown = 900, -- 15 minutes
		Biome = "LunarCaverns",
		Rewards = {XP = 20},
	},
	{
		Name = "DuneWhispers",
		DisplayName = "Dune Whispers",
		Duration = 30,
		Cooldown = 1200, -- 20 minutes
		Biome = "StarfallDesert",
		Rewards = {Stardust = 15},
	},
	{
		Name = "TidalChorus",
		DisplayName = "Tidal Chorus",
		Duration = 40,
		Cooldown = 1800, -- 30 minutes
		Biome = "CometShores",
		Rewards = {XP = 10},
	},
}

-- Tier 2 Events (Daily, 1-3 times per day)
local TIER_2_EVENTS = {
	{
		Name = "Starfall",
		DisplayName = "Starfall",
		Duration = 120,
		Cooldown = 3600, -- 1 hour
		Biome = "StarfallDesert",
		TimeOfDay = "Night",
		Rewards = {Stardust = 50, XP = 50},
	},
	{
		Name = "AuroraDance",
		DisplayName = "Aurora Dance",
		Duration = 240,
		Cooldown = 7200, -- 2 hours
		Biome = "AuroraTundra",
		TimeOfDay = "Night",
		Rewards = {Stardust = 20, PrestigeChance = 0.05},
	},
	{
		Name = "NebulaDrift",
		DisplayName = "Nebula Drift",
		Duration = 90,
		Cooldown = 5400, -- 1.5 hours
		Biome = "NebulaForest",
		MinPlayers = 7,
		Rewards = {XP = 100},
	},
	{
		Name = "CrystalStorm",
		DisplayName = "Crystal Storm",
		Duration = 60,
		Cooldown = 10800, -- 3 hours
		Biome = "LunarCaverns",
		Rewards = {XP = 40, LoreFragment = true},
	},
}

-- Tier 3 Events (Server-defining, every 2-4 hours)
local TIER_3_EVENTS = {
	{
		Name = "LunarConvergence",
		DisplayName = "Lunar Convergence",
		Duration = 120,
		Cooldown = 7200, -- 2 hours
		Biome = "VoidTemple",
		Rewards = {XP = 150, Stardust = 50},
	},
	{
		Name = "VoidEclipse",
		DisplayName = "Void Eclipse",
		Duration = 120,
		Cooldown = 10800, -- 3 hours
		Biome = "VoidTemple",
		Rewards = {XP = 200, PrestigeChance = 0.20},
	},
	{
		Name = "OrbitalAlignment",
		DisplayName = "Orbital Alignment",
		Duration = 180,
		Cooldown = 14400, -- 4 hours
		Biome = "OuterRim",
		Rewards = {XP = 300, Stardust = 100, PrestigePoints = 2},
	},
}

-- Ultra-Rare Events (Legendary, 1-2 per day)
local ULTRA_RARE_EVENTS = {
	{
		Name = "CosmicBloom",
		DisplayName = "Cosmic Bloom",
		Duration = 300,
		Cooldown = 43200, -- 12 hours
		Biome = "All",
		Chance = 0.005, -- 0.5% per hour
		Rewards = {PrestigePoints = 2, Stardust = 200, Title = "Cosmic Witness"},
	},
	{
		Name = "SolarAscension",
		DisplayName = "Solar Ascension",
		Duration = 60,
		Cooldown = 86400, -- 24 hours
		Biome = "StarfallDesert",
		TimeOfDay = "Day",
		Chance = 0.001, -- Very rare
		Rewards = {XP = 500, LoreFragment = true},
	},
	{
		Name = "VoidSingularity",
		DisplayName = "Void Singularity",
		Duration = 45,
		Cooldown = 86400, -- 24 hours
		Biome = "VoidTemple",
		RequiresMaxPrestige = true,
		Rewards = {PrestigePoints = 3, ExclusiveEffect = "VoidSigil"},
	},
}

-- ============================================
-- EVENT STATE
-- ============================================

local activeEvents = {} -- [eventName] = {startTime, endTime}
local eventCooldowns = {} -- [eventName] = timestamp
local currentEvent = nil

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
	
	local eventRemotes = remotesFolder:FindFirstChild("EventRemotes")
	if not eventRemotes then
		eventRemotes = Instance.new("Folder")
		eventRemotes.Name = "EventRemotes"
		eventRemotes.Parent = remotesFolder
	end
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = eventRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = eventRemotes
		end
		return remote
	end
	
	return {
		EventStarted = getOrCreateRemote("EventStarted", "RemoteEvent"),
		EventEnded = getOrCreateRemote("EventEnded", "RemoteEvent"),
	}
end

local remotes = getRemotes()

-- ============================================
-- EVENT TRIGGERS
-- ============================================

local function canTriggerEvent(event: table): boolean
	-- Check cooldown
	local lastTrigger = eventCooldowns[event.Name]
	if lastTrigger and (os.time() - lastTrigger) < event.Cooldown then
		return false
	end
	
	-- Check if event is already active
	if activeEvents[event.Name] then
		return false
	end
	
	-- Check time of day requirement
	if event.TimeOfDay then
		-- TODO: Check actual time of day
	end
	
	-- Check minimum players
	if event.MinPlayers then
		local playerCount = #game:GetService("Players"):GetPlayers()
		if playerCount < event.MinPlayers then
			return false
		end
	end
	
	-- Check prestige requirement
	if event.RequiresMaxPrestige then
		-- TODO: Check if any player has max prestige
	end
	
	-- Check chance for rare events
	if event.Chance then
		if math.random() > event.Chance then
			return false
		end
	end
	
	return true
end

local function triggerEvent(event: table)
	if not canTriggerEvent(event) then
		return
	end
	
	-- Mark as active
	local startTime = os.time()
	local endTime = startTime + event.Duration
	activeEvents[event.Name] = {startTime = startTime, endTime = endTime}
	eventCooldowns[event.Name] = startTime
	currentEvent = event
	
	-- Announce to all players
	remotes.EventStarted:FireAllClients(event.Name, event.DisplayName, event.Duration)
	
	-- Apply visual effects
	-- TODO: Change skybox, lighting, fog, etc.
	
	-- Server announcement
	print(`🌌 [EventManager] {event.DisplayName} has begun! Duration: {event.Duration}s`)
	
	-- Schedule end
	task.delay(event.Duration, function()
		endEvent(event.Name)
	end)
end

local function endEvent(eventName: string)
	local eventData = activeEvents[eventName]
	if not eventData then
		return
	end
	
	-- Remove from active
	activeEvents[eventName] = nil
	if currentEvent and currentEvent.Name == eventName then
		currentEvent = nil
	end
	
	-- Announce end
	remotes.EventEnded:FireAllClients(eventName)
	
	-- Give rewards to all players
	-- TODO: Distribute rewards
	
	print(`🌌 [EventManager] {eventName} has ended`)
end

-- ============================================
-- EVENT LOOP
-- ============================================

task.spawn(function()
	while true do
		task.wait(60) -- Check every minute
		
		-- Check for Tier 1 events (frequent)
		for _, event in ipairs(TIER_1_EVENTS) do
			if canTriggerEvent(event) then
				triggerEvent(event)
				break -- Only one event at a time
			end
		end
		
		-- Check for Tier 2 events (daily)
		if math.random() < 0.1 then -- 10% chance per check
			for _, event in ipairs(TIER_2_EVENTS) do
				if canTriggerEvent(event) then
					triggerEvent(event)
					break
				end
			end
		end
		
		-- Check for Tier 3 events (rare)
		if math.random() < 0.05 then -- 5% chance per check
			for _, event in ipairs(TIER_3_EVENTS) do
				if canTriggerEvent(event) then
					triggerEvent(event)
					break
				end
			end
		end
		
		-- Check for Ultra-Rare events (very rare)
		if math.random() < 0.01 then -- 1% chance per check
			for _, event in ipairs(ULTRA_RARE_EVENTS) do
				if canTriggerEvent(event) then
					triggerEvent(event)
					break
				end
			end
		end
	end
end)

-- ============================================
-- INITIALIZATION
-- ============================================

print("[EventManager] Initialized - Global events system ready")
print("  - Tier 1 events: " .. #TIER_1_EVENTS .. " (frequent)")
print("  - Tier 2 events: " .. #TIER_2_EVENTS .. " (daily)")
print("  - Tier 3 events: " .. #TIER_3_EVENTS .. " (server-defining)")
print("  - Ultra-Rare events: " .. #ULTRA_RARE_EVENTS .. " (legendary)")
print("  - Event loop: Active")

return EventManager

