# 🎮 Cursor Biome Implementation Instructions

Complete guide for using Cursor to generate the Cosmo Cats biome folder structure in Roblox Studio.

## 📋 Quick Start Command

When you're ready to generate all biomes, paste this command into Cursor:

```
Cursor — create a folder structure for all biomes listed under Cosmo Cats World Architecture, including placeholder Parts, TerrainRegions, Lighting presets, and RegionMarkers for each biome. Follow the ASCII map layout.
```

## 🎯 What Cursor Will Generate

### 1. Biome Folders Structure

```
Workspace/
└── Map/
    ├── NebulaForest/
    │   ├── TerrainRegion/
    │   ├── RegionMarker/
    │   ├── SpawnPoint/
    │   ├── TeleportPoints/
    │   ├── LightingPreset/
    │   └── PlaceholderModels/
    ├── LunarCaverns/
    │   ├── TerrainRegion/
    │   ├── RegionMarker/
    │   ├── SpawnPoint/
    │   ├── TeleportPoints/
    │   ├── LightingPreset/
    │   └── PlaceholderModels/
    ├── StarfallDesert/
    │   ├── TerrainRegion/
    │   ├── RegionMarker/
    │   ├── SpawnPoint/
    │   ├── TeleportPoints/
    │   ├── LightingPreset/
    │   └── PlaceholderModels/
    ├── CometShores/
    │   ├── TerrainRegion/
    │   ├── RegionMarker/
    │   ├── SpawnPoint/
    │   ├── TeleportPoints/
    │   ├── LightingPreset/
    │   └── PlaceholderModels/
    ├── VoidTemple/
    │   ├── TerrainRegion/
    │   ├── RegionMarker/
    │   ├── SpawnPoint/
    │   ├── TeleportPoints/
    │   ├── LightingPreset/
    │   └── PlaceholderModels/
    ├── OuterRim/
    │   ├── TerrainRegion/
    │   ├── RegionMarker/
    │   ├── SpawnPoint/
    │   ├── TeleportPoints/
    │   ├── LightingPreset/
    │   └── PlaceholderModels/
    ├── AuroraTundra/
    │   ├── TerrainRegion/
    │   ├── RegionMarker/
    │   ├── SpawnPoint/
    │   ├── TeleportPoints/
    │   ├── LightingPreset/
    │   └── PlaceholderModels/
    └── RiftFragment/
        ├── TerrainRegion/
        ├── RegionMarker/
        ├── SpawnPoint/
        ├── TeleportPoints/
        ├── LightingPreset/
        └── PlaceholderModels/
```

## 📐 Detailed Component Specifications

### TerrainRegion (Part)
For each biome, create a Part that represents the biome's area:

```lua
-- Example: NebulaForest/TerrainRegion
local terrainRegion = Instance.new("Part")
terrainRegion.Name = "TerrainRegion"
terrainRegion.Size = Vector3.new(512, 10, 512) -- Adjust per biome
terrainRegion.Anchored = true
terrainRegion.CanCollide = false
terrainRegion.Transparency = 0.5 -- Semi-transparent for visibility
terrainRegion.BrickColor = BrickColor.new("Bright green") -- Biome-specific color
terrainRegion.Material = Enum.Material.ForceField
terrainRegion.Parent = workspace.Map.NebulaForest
```

**Biome-Specific Colors:**
- **NebulaForest**: Bright green
- **LunarCaverns**: Bright blue
- **StarfallDesert**: Bright yellow
- **CometShores**: Bright cyan
- **VoidTemple**: Really black
- **OuterRim**: Bright violet
- **AuroraTundra**: Bright blue
- **RiftFragment**: Really red

### RegionMarker (StringValue)
Marks the biome for scripts to identify:

```lua
-- Example: NebulaForest/RegionMarker
local regionMarker = Instance.new("StringValue")
regionMarker.Name = "RegionMarker"
regionMarker.Value = "NebulaForest"
regionMarker.Parent = workspace.Map.NebulaForest
```

### SpawnPoint (SpawnLocation)
Main spawn point for the biome:

```lua
-- Example: NebulaForest/SpawnPoint
local spawnPoint = Instance.new("SpawnLocation")
spawnPoint.Name = "SpawnPoint"
spawnPoint.Size = Vector3.new(4, 1, 4)
spawnPoint.Position = Vector3.new(0, 10, 0) -- Adjust per biome
spawnPoint.Anchored = true
spawnPoint.BrickColor = BrickColor.new("Bright green")
spawnPoint.Material = Enum.Material.Neon
spawnPoint.Neutral = true
spawnPoint.Parent = workspace.Map.NebulaForest
```

### TeleportPoints (Folder)
Contains teleport points to other biomes:

```lua
-- Example: NebulaForest/TeleportPoints/ToLunarCaverns
local teleportPoint = Instance.new("Part")
teleportPoint.Name = "ToLunarCaverns"
teleportPoint.Size = Vector3.new(8, 1, 8)
teleportPoint.Position = Vector3.new(50, 5, 0) -- Adjust per connection
teleportPoint.Anchored = true
teleportPoint.BrickColor = BrickColor.new("Bright blue")
teleportPoint.Material = Enum.Material.Neon
teleportPoint.Shape = Enum.PartType.Cylinder
teleportPoint.Parent = workspace.Map.NebulaForest.TeleportPoints

-- Add StringValue for destination
local destination = Instance.new("StringValue")
destination.Name = "Destination"
destination.Value = "LunarCaverns"
destination.Parent = teleportPoint
```

### LightingPreset (Configuration)
Stores lighting settings for the biome:

```lua
-- Example: NebulaForest/LightingPreset
local lightingPreset = Instance.new("Configuration")
lightingPreset.Name = "LightingPreset"

-- Day settings
local dayAmbient = Instance.new("Color3Value")
dayAmbient.Name = "DayAmbient"
dayAmbient.Value = Color3.fromRGB(100, 150, 200) -- Bright coastal ambient
dayAmbient.Parent = lightingPreset

local dayBrightness = Instance.new("NumberValue")
dayBrightness.Name = "DayBrightness"
dayBrightness.Value = 3.0
dayBrightness.Parent = lightingPreset

local dayFogColor = Instance.new("Color3Value")
dayFogColor.Name = "DayFogColor"
dayFogColor.Value = Color3.fromRGB(150, 200, 255) -- Light blue fog
dayFogColor.Parent = lightingPreset

-- Night settings
local nightAmbient = Instance.new("Color3Value")
nightAmbient.Name = "NightAmbient"
nightAmbient.Value = Color3.fromRGB(20, 40, 80) -- Deep blue night ambient
nightAmbient.Parent = lightingPreset

local nightBrightness = Instance.new("NumberValue")
nightBrightness.Name = "NightBrightness"
nightBrightness.Value = 0.2
nightBrightness.Parent = lightingPreset

lightingPreset.Parent = workspace.Map.NebulaForest
```

### PlaceholderModels (Folder)
Contains placeholder models for key features:

```lua
-- Example: NebulaForest/PlaceholderModels/LifeTree
local placeholder = Instance.new("Part")
placeholder.Name = "LifeTree_Placeholder"
placeholder.Size = Vector3.new(4, 20, 4)
placeholder.Position = Vector3.new(0, 10, 0)
placeholder.Anchored = true
placeholder.BrickColor = BrickColor.new("Bright green")
placeholder.Material = Enum.Material.Neon
placeholder.Shape = Enum.PartType.Cylinder
placeholder.Parent = workspace.Map.NebulaForest.PlaceholderModels

-- Add StringValue for description
local description = Instance.new("StringValue")
description.Name = "Description"
description.Value = "Life Tree - Central RP zone"
description.Parent = placeholder
```

## 🗺️ ASCII Map Layout Reference

Based on the world design, biomes should be positioned as follows:

```
                    [Outer Rim]
                         |
                    [Void Temple]
                         |
        [Aurora Tundra]--+--[Rift Fragment]
                         |
        [Lunar Caverns]--+--[Starfall Desert]
                         |
        [Nebula Forest]--+--[Comet Shores]
                         |
                    [Central Hub]
```

**Position Guidelines:**
- **Nebula Forest**: Center (0, 0, 0)
- **Lunar Caverns**: North (-256, 0, 0)
- **Starfall Desert**: East (256, 0, 0)
- **Comet Shores**: South (0, 0, 256)
- **Void Temple**: Center, elevated (0, 100, 0)
- **Outer Rim**: Far edges (various positions)
- **Aurora Tundra**: North-west (-384, 0, -256)
- **Rift Fragment**: South-east (384, 0, 256)

## 📝 Biome-Specific Placeholder Models

### Nebula Forest
- LifeTree_Placeholder
- GlowingWaterfall_Placeholder
- AncientRuins_Placeholder
- StardustCrystal_Placeholder

### Lunar Caverns
- GlowingCrystal_Placeholder
- IceFormation_Placeholder
- CaveEntrance_Placeholder
- ReflectivePool_Placeholder

### Starfall Desert
- AncientRuins_Placeholder
- MeteorCrater_Placeholder
- RockFormation_Placeholder
- DesertThrone_Placeholder

### Comet Shores
- BioluminescentBeach_Placeholder
- TidePool_Placeholder
- CometLandingSite_Placeholder
- BeachCave_Placeholder

### Void Temple
- CentralTower_Placeholder
- EnergyPillar_Placeholder
- RitualPit_Placeholder
- TempleArchway_Placeholder

### Outer Rim
- FloatingIsland_Placeholder
- CelestialOrb_Placeholder
- AncientTemple_Placeholder
- Waterfall_Placeholder

### Aurora Tundra
- IceFormation_Placeholder
- AuroraBeam_Placeholder
- FrozenLake_Placeholder
- CrystalCave_Placeholder

### Rift Fragment
- RiftPortal_Placeholder
- FloatingFragment_Placeholder
- EnergyCrystal_Placeholder
- UnstableGround_Placeholder

## 🔧 Script Stubs

Create placeholder scripts for each biome:

### BiomeController.lua (in each biome folder)
```lua
-- BiomeController.lua
-- Controls biome-specific behavior and interactions.

local BiomeController = {}

function BiomeController.Initialize()
    -- TODO: Initialize biome-specific systems
    print("[BiomeController] Initialized:", script.Parent.Name)
end

function BiomeController.OnPlayerEnter(player)
    -- TODO: Handle player entering biome
    print("[BiomeController] Player entered:", player.Name)
end

function BiomeController.OnPlayerExit(player)
    -- TODO: Handle player exiting biome
    print("[BiomeController] Player exited:", player.Name)
end

return BiomeController
```

### TeleportHandler.lua (in TeleportPoints folder)
```lua
-- TeleportHandler.lua
-- Handles teleportation between biomes.

local TeleportHandler = {}

function TeleportHandler.TeleportPlayer(player, destination)
    -- TODO: Teleport player to destination biome
    print("[TeleportHandler] Teleporting", player.Name, "to", destination)
end

return TeleportHandler
```

## ✅ Generation Checklist

When Cursor generates the structure, ensure:

- [ ] All 8 biomes have folders created
- [ ] Each biome has TerrainRegion Part
- [ ] Each biome has RegionMarker StringValue
- [ ] Each biome has SpawnPoint SpawnLocation
- [ ] Each biome has TeleportPoints folder with connections
- [ ] Each biome has LightingPreset Configuration
- [ ] Each biome has PlaceholderModels folder with key features
- [ ] Biome-specific colors are applied
- [ ] Positions follow ASCII map layout
- [ ] Script stubs are created
- [ ] All instances are properly parented

## 🎨 Visual Reference Integration

Each biome folder should include a reference to its visual guide:

- **NebulaForest**: See `docs/biomes/NEBULA_FOREST_VISUAL_REFERENCE.md`
- **LunarCaverns**: See `docs/biomes/LUNAR_CAVERNS_VISUAL_REFERENCE.md`
- **StarfallDesert**: See `docs/biomes/STARFALL_DESERT_VISUAL_REFERENCE.md`
- **CometShores**: See `docs/biomes/COMET_SHORES_VISUAL_REFERENCE.md`
- **VoidTemple**: See `docs/biomes/VOID_TEMPLE_VISUAL_REFERENCE.md`
- **OuterRim**: See `docs/biomes/OUTER_RIM_VISUAL_REFERENCE.md`
- **AuroraTundra**: See `docs/biomes/AURORA_TUNDRA.md` (to be created)
- **RiftFragment**: See `docs/biomes/RIFT_FRAGMENT.md` (to be created)

## 🚀 Next Steps After Generation

1. **Review Structure**: Verify all biomes are created correctly
2. **Adjust Positions**: Fine-tune biome positions based on map layout
3. **Apply Lighting**: Use DayNightController to apply biome lighting
4. **Add Models**: Replace placeholders with actual models
5. **Implement Teleports**: Connect teleport points with scripts
6. **Test Spawns**: Verify spawn points work correctly
7. **Add Interactables**: Place collectibles and interactable items

## 📚 Related Documentation

- **World Design**: `docs/WORLD_DESIGN.md`
- **Biome Guides**: `docs/biomes/README.md`
- **Day/Night Controller**: `studio-project/src/Lighting/DayNightController.lua`
- **Travel Network**: `docs/TRAVEL_NETWORK.md`

---

**Last Updated:** Cursor Biome Implementation Guide  
**Status:** Ready for Cursor generation ✅
