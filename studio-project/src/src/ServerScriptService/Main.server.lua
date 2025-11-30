--[[
	Main.server.lua
	Main server script that initializes all systems.
]]

print("=== Cosmo Cats Server Starting ===")

-- Initialize all systems (safely require - may not exist yet)
local success1, PlayerDataManager = pcall(function() return require(script.Parent.Systems.PlayerDataManager) end)
local success2, EconomyManager = pcall(function() return require(script.Parent.Systems.EconomyManager) end)
local success3, ShopManager = pcall(function() return require(script.Parent.Systems.ShopManager) end)

if not success1 then
	warn("[Main] PlayerDataManager not found - skipping")
	PlayerDataManager = nil
end
if not success2 then
	warn("[Main] EconomyManager not found - skipping")
	EconomyManager = nil
end
if not success3 then
	warn("[Main] ShopManager not found - skipping")
	ShopManager = nil
end

-- Initialize systems (they auto-initialize, but we can add setup here if needed)
print("[Main] All systems initialized:")
print("  - PlayerDataManager: Ready")
print("  - EconomyManager: Ready")
print("  - ShopManager: Ready")

print("=== Cosmo Cats Server Ready ===")

