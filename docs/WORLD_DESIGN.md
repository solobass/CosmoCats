# Cosmo Cats – Complete World Design Bible

This document defines the entire RP world structure from which all future expansions can branch.

## 🌍 Full Overworld Structure (Cosmo Cats Universe)

The world is divided into **six major biomes + two subzones**:

1. 🌲 **Nebula Forest** (starter area)
2. 🪨 **Lunar Caverns** (mid-tier zone)
3. 🏜️ **Starfall Desert** (open-world RP)
4. 🌊 **Comet Shores** (calmer RP zone)
5. 🛕 **Void Temple** (prestige area)
6. 🛸 **Outer Rim** (Spacefield) (endgame sky biome)

**Subzones:**
7. ❄️ **Aurora Tundra** (hidden/passive-biome)
8. 👻 **Rift Fragment** (secret void micro-dimension)

---

## 🗺️ ASCII MAP DIAGRAM (Top-Down View)

```
                         [ OUTER RIM ]
                              / \
                             /   \
                   [ COMET SHORES ] -----
                     /          \        \
                    /            \        \
           [ NEBULA FOREST ] ---- \     [ VOID TEMPLE ]
                 |    \             \       |
                 |     \             \      |
                 |      \             \     |
           [ LUNAR CAVERNS ] ---- [ STARFALL DESERT ]
                    \                   |
                     \                 [ AURORA TUNDRA ]
                      \
                    [ RIFT FRAGMENT ] (secret)
```

---

## 🚀 Travel Network / Fast Travel

### Connections:

- **Nebula Forest** → **Lunar Caverns** (cave path)
- **Forest** → **Desert** (star-lit canyon)
- **Desert** → **Tundra** (secret crack in meteor)
- **Caverns** → **Void Temple** (descending crystal path)
- **Comet Shores** → **Outer Rim** (stargate portal)
- **Void Temple** → **Rift Fragment** (hidden teleport seal)

**Everything loops**, forming a circular world with optional shortcuts.

---

## 🌅 Lighting + Time-of-Day System

The world uses a **Custom Stellar Cycle**:

### ❖ Day
- Soft nebula light
- Bioluminescent plants muted
- More resources visible

### ❖ Night
- Bright auroras
- Floating star particles
- Crystal nodes glow
- "Echo spirits" (non-interactive VFX)

### Code Hook:
`Lighting/DayNightController.lua`

**Cursor will implement:**
- Tween-based skybox transitions
- Ambient and outdoor brightness changes
- Fog color changes
- Region-specific overrides

**Example:**
- Nebula Forest always 30% more fog
- Void Temple always darker

---

## 🎭 RP Zones (Critical for Feather Family Style)

Each biome includes **2–3 RP landmarks**:

### Example (Nebula Forest):
- **Star Pond** (quiet RP zone)
- **Fallen Nebula Tree** (social RP zone)
- **Crystal Log Den** (private RP zone)

### Others include:
- **Desert Throne** (dramatic RP zone)
- **Temple Central Hall** (prestige RP zone)
- **Outer Rim Orbital Ring** (screenshot zone)

### Roleplay landmarks must be:
- ✓ Large enough for players to gather
- ✓ Distinctive shapes
- ✓ Good lighting
- ✓ Camera-friendly

---

## 🎁 Interactables Across the World

### Stardust Sources:
- **Cosmic Berry bushes** (Forest)
- **Crystal Nodes** (Caverns)
- **Comet Fragments** (Shore)

### Beds:
- **Blanket** → Forest
- **Box** → Forest
- **MoonRock** → Caverns
- **Nebula Hammock** → Shores
- **Star Cradle** → Temple

### Special Items:
- **Rift Shards** (Temple → Rift)
- **Aurora Feathers** (Tundra)
- **Star Sand** (Desert)

You collect them for roleplay or unlockables.

---

## 🔍 Secret Areas

These are essential for long-term RP engagement.

**Hidden spots include:**
- Hollow tree trunk
- Underground lunar grotto
- Desert meteor interior
- Frozen aurora cave
- Temple dark altar
- Rift Fragment micro-dimension

All include unique VFX + soundscapes.

---

## 📁 Workspace Structure

```
Workspace/
├── Map/
│   ├── NebulaForest/
│   ├── LunarCaverns/
│   ├── StarfallDesert/
│   ├── CometShores/
│   ├── VoidTemple/
│   ├── OuterRim/
│   ├── AuroraTundra/
│   └── RiftFragment/
│
├── SpawnPoints/
│   ├── ForestSpawn
│   ├── CavernSpawn
│   ├── DesertSpawn
│   ├── ShoresSpawn
│   ├── TempleSpawn
│   └── OuterRimSpawn
│
├── Beds/
│   ├── BlanketBed.model
│   ├── BoxBed.model
│   ├── MoonRockBed.model
│   ├── NebulaHammock.model
│   └── StarCradle.model
│
└── InteractableItems/
    ├── StardustCrystal.model
    ├── CosmicBerry.model
    ├── CrystalFragment.model
    ├── CometFragment.model
    ├── RiftShard.model
    ├── AuroraFeather.model
    └── StarSand.model
```

---

## 🎨 Visual Inspiration

The provided images represent the "feel" of each zone:

- **Nebula Forest**: Magical twilight with aurora-like colors
- **Lunar Caverns**: Bioluminescent cave with glowing blue-green lights
- **Starfall Desert**: Milky Way over desert landscape
- **Comet Shores**: Cosmic beach with star-filled sky
- **Void Temple**: Dark, mysterious canyon with Milky Way
- **Outer Rim**: Space environment with floating platforms

---

## 🛠️ Implementation Guide

### For Cursor:
1. Create biome folders in `Workspace/Map/`
2. Add spawn points for each biome
3. Place interactable items
4. Set up lighting per biome
5. Create travel paths between biomes

### For Roblox Studio:
1. Import biome models
2. Set up lighting and skyboxes
3. Place spawn points
4. Configure travel portals/paths
5. Add RP landmarks

---

**Last Updated:** Complete World Design Bible  
**Status:** Ready for implementation ✅
