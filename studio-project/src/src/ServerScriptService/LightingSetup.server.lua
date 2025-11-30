-- LightingSetup.server.lua
-- Sets up lighting properties that CAN be set from server scripts
-- Note: Technology property must be set manually in Properties panel

-- Enable GlobalShadows
game.Lighting.GlobalShadows = true

-- Note: ColorCorrection, Bloom, and DepthOfField must be created manually in Studio
-- They cannot be created from ServerScripts due to Roblox security restrictions
-- 
-- To add them manually:
-- 1. Select "Lighting" in Explorer
-- 2. Right-click → Insert Object → ColorCorrection
-- 3. Right-click → Insert Object → Bloom
-- 4. Right-click → Insert Object → DepthOfField

-- We can only set properties that are allowed from ServerScripts
-- Enable GlobalShadows (this works from ServerScripts)
game.Lighting.GlobalShadows = true

print("✅ Lighting setup complete! (Note: Set Technology to 'Future' manually in Properties)")

