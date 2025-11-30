# Workspace - Game World

The physical game world for Cosmo Cats, including all biomes, spawn points, interactables, and RP zones.

## Structure

```
Workspace/
├── Map/                    # All biome areas
│   ├── NebulaForest/      # Starter biome
│   ├── LunarCaverns/      # Mid-tier zone
│   ├── StarfallDesert/    # Open-world RP
│   ├── CometShores/       # Calmer RP zone
│   ├── VoidTemple/        # Prestige area
│   ├── OuterRim/          # Endgame sky biome
│   ├── AuroraTundra/      # Hidden zone
│   └── RiftFragment/      # Secret void room
│
├── SpawnPoints/           # Player spawn locations
│   ├── ForestSpawn
│   ├── CavernSpawn
│   ├── DesertSpawn
│   ├── ShoresSpawn
│   ├── TempleSpawn
│   └── OuterRimSpawn
│
├── Beds/                  # Bed models
│   ├── BlanketBed.model
│   ├── BoxBed.model
│   ├── MoonRockBed.model
│   ├── NebulaHammock.model
│   └── StarCradle.model
│
└── InteractableItems/     # Collectibles & resources
    ├── StardustCrystal.model
    ├── CosmicBerry.model
    ├── CrystalFragment.model
    ├── CometFragment.model
    ├── RiftShard.model
    ├── AuroraFeather.model
    └── StarSand.model
```

## Biome Details

See `docs/biomes/` for detailed biome documentation:
- NEBULA_FOREST.md
- LUNAR_CAVERNS.md
- STARFALL_DESERT.md
- COMET_SHORES.md
- VOID_TEMPLE.md
- OUTER_RIM.md
- AURORA_TUNDRA.md
- RIFT_FRAGMENT.md

## Travel Network

See `docs/TRAVEL_NETWORK.md` for complete travel connections.

## RP Zones

Each biome contains 2-3 RP landmarks:
- Large enough for players to gather
- Distinctive shapes
- Good lighting
- Camera-friendly

## Interactables

### Stardust Sources
- Cosmic Berry bushes (Forest)
- Crystal Nodes (Caverns)
- Comet Fragments (Shore)

### Beds by Biome
- Blanket/Box → Forest
- MoonRock → Caverns
- Nebula Hammock → Shores
- Star Cradle → Temple

### Special Collectibles
- Rift Shards (Temple → Rift)
- Aurora Feathers (Tundra)
- Star Sand (Desert)

## Secret Areas

Hidden spots for long-term engagement:
- Hollow tree trunk (Forest)
- Underground lunar grotto (Caverns)
- Desert meteor interior (Desert)
- Frozen aurora cave (Tundra)
- Temple dark altar (Temple)
- Rift Fragment micro-dimension (Rift)

---

**Last Updated:** Workspace Structure  
**Status:** Ready for world building ✅


