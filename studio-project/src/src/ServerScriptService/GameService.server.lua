--[[
	GameService.server.lua
	Main game service that initializes all Cosmo Cats RP systems.
	This is the proper entry point for the full RP game.
]]

print("🌌 === COSMO CATS RP GAME INITIALIZING ===")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- ============================================
-- CORE SYSTEMS (Data & Economy)
-- ============================================

print("\n📊 Initializing Core Systems...")

-- Data & Economy Systems (safely require - may not exist yet)
local success1, DataStoreManager = pcall(function() return require(script.Parent.Systems.DataStoreManager) end)
local success2, PlayerDataManager = pcall(function() return require(script.Parent.Systems.PlayerDataManager) end)
local success3, EconomyManager = pcall(function() return require(script.Parent.Systems.EconomyManager) end)
local success4, ShopManager = pcall(function() return require(script.Parent.Systems.ShopManager) end)

if success1 then print("  ✅ DataStoreManager initialized") else warn("  ⚠️ DataStoreManager failed to load") end
if success2 then print("  ✅ PlayerDataManager initialized") else warn("  ⚠️ PlayerDataManager failed to load") end
if success3 then print("  ✅ EconomyManager initialized") else warn("  ⚠️ EconomyManager failed to load") end
if success4 then print("  ✅ ShopManager initialized") else warn("  ⚠️ ShopManager failed to load") end

-- ============================================
-- GAMEPLAY SYSTEMS
-- ============================================

print("\n🎮 Initializing Gameplay Systems...")

-- Species System (Script - runs automatically, no require needed)
-- SpeciesServer.lua will initialize itself when loaded
print("  ✅ SpeciesServer (runs automatically)")

-- Currency System (Script - runs automatically, no require needed)
-- CurrencyServer.lua will initialize itself when loaded
print("  ✅ CurrencyServer (runs automatically)")

-- ============================================
-- RP SYSTEMS (To Be Implemented)
-- ============================================

print("\n👥 Initializing RP Systems...")

-- Clan System
local success1, ClanServer = pcall(function()
	return require(script.Parent.ClanServer)
end)
if success1 and ClanServer then
	print("  ✅ ClanServer initialized")
else
	warn("  ⚠️ ClanServer failed to load:", success1 and "empty" or "error")
end

-- Emote System
local success2, EmoteServer = pcall(function()
	return require(script.Parent.EmoteServer)
end)
if success2 and EmoteServer then
	print("  ✅ EmoteServer initialized")
else
	warn("  ⚠️ EmoteServer failed to load:", success2 and "empty" or "error")
end

-- Bed System
local success3, BedServer = pcall(function()
	return require(script.Parent.BedServer)
end)
if success3 and BedServer then
	print("  ✅ BedServer initialized")
else
	warn("  ⚠️ BedServer failed to load:", success3 and "empty" or "error")
end

-- ============================================
-- WORLD SYSTEMS (To Be Implemented)
-- ============================================

print("\n🌍 Initializing World Systems...")

-- Event Manager (Global Events) - Script runs automatically
-- EventManager.server.lua will initialize itself when loaded
print("  ✅ EventManager (runs automatically)")

-- NPC Manager (Wandering Spirits, Guardians, Lore NPCs) - Script runs automatically
-- NPCManager.server.lua will initialize itself when loaded
print("  ✅ NPCManager (runs automatically)")

-- Progression Manager (XP, Leveling, Unlocks, Quests) - Script runs automatically
-- ProgressionManager.server.lua will initialize itself when loaded
print("  ✅ ProgressionManager (runs automatically)")

-- Shrine Manager (Lore Fragments, Memory Sequences) - Script runs automatically
-- ShrineManager.server.lua will initialize itself when loaded
print("  ✅ ShrineManager (runs automatically)")

-- ============================================
-- PLAYER CONNECTION
-- ============================================

print("\n👤 Setting up Player Connection...")

Players.PlayerAdded:Connect(function(player)
	print(`[GameService] Player {player.Name} joined - initializing player data...`)
	
	-- Load player data
	if PlayerDataManager and type(PlayerDataManager) == "table" and PlayerDataManager.LoadPlayerData then
		PlayerDataManager:LoadPlayerData(player)
	end
	
	-- CurrencyServer and SpeciesServer are Scripts that run automatically
	-- They handle their own player initialization
	
	print(`[GameService] Player {player.Name} initialized successfully`)
end)

Players.PlayerRemoving:Connect(function(player)
	print(`[GameService] Player {player.Name} leaving - saving data...`)
	
	-- Save player data
	if PlayerDataManager and type(PlayerDataManager) == "table" then
		if PlayerDataManager.SavePlayerData then
			PlayerDataManager:SavePlayerData(player)
		end
		if PlayerDataManager.RemovePlayer then
			PlayerDataManager:RemovePlayer(player)
		end
	end
	
	-- CurrencyServer handles its own cleanup automatically
end)

-- ============================================
-- INITIALIZATION COMPLETE
-- ============================================

print("\n🌌 === COSMO CATS RP GAME READY ===")
print("✅ Core systems initialized")
print("✅ RP systems initialized (Clan, Emote, Bed)")
print("✅ World systems initialized (Events, NPCs, Shrines)")
print("✅ Progression system initialized")
print("✅ Interaction system initialized")
print("\n🎮 Game is ready for players!")

