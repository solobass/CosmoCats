--[[
	Main.server.lua
	Main server script that initializes all systems.
]]

print("=== Cosmo Cats Server Starting ===")

-- Initialize all systems
local PlayerDataManager = require(script.Parent.Systems.PlayerDataManager)
local EconomyManager = require(script.Parent.Systems.EconomyManager)
local ShopManager = require(script.Parent.Systems.ShopManager)

-- Initialize systems (they auto-initialize, but we can add setup here if needed)
print("[Main] All systems initialized:")
print("  - PlayerDataManager: Ready")
print("  - EconomyManager: Ready")
print("  - ShopManager: Ready")

print("=== Cosmo Cats Server Ready ===")


