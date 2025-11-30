# COSMO CATS – GITHUB REPOSITORY STRUCTURE & BEST PRACTICES

This structure is optimized for:
- **Roblox Studio's** folder-based architecture
- **Cursor's** multi-file generation abilities
- **Claude Code Pro's** large-context refactors
- **Meshy AI's** model imports
- **Future collaboration** (or solo scaling)

---

## 📁 High-Level Repository Structure

```
cosmo-cats/
│
├── 📄 README.md                          # Main project overview
├── 📄 LICENSE                            # MIT License
├── 📄 .gitignore                         # Git ignore rules
├── 📄 .cursorignore                      # Cursor ignore rules
│
├── 📁 studio-project/                    # All Roblox files (primary game)
│   └── src/                              # Mirrors Roblox Studio Explorer
│       ├── ReplicatedStorage/
│       ├── StarterPlayer/
│       ├── StarterGui/
│       ├── ServerScriptService/
│       ├── ServerStorage/
│       ├── Workspace/
│       └── Lighting/
│
├── 📁 assets/                             # 3D models, textures, animations
│   ├── models/                           # Species models (FBX/RBMX)
│   ├── textures/                         # Texture files
│   ├── animations/                       # Animation files (FBX)
│   └── effects/                          # Particle effects
│
├── 📁 docs/                              # Game design docs
│   ├── DESIGN_OVERVIEW.md                # Overall game design
│   ├── SPECIES_SPECS.md                  # Species specifications
│   ├── 3D_PIPELINE.md                    # 3D pipeline documentation
│   ├── WORLD_DESIGN.md                   # Complete world design bible
│   ├── TRAVEL_NETWORK.md                 # Travel connections
│   ├── 📁 species/                       # Species documentation
│   ├── 📁 pipeline/                     # Pipeline documentation
│   │   └── CHARACTER_PIPELINE.md
│   ├── 📁 ui/                           # UI documentation
│   │   └── UI_WIREFRAMES/
│   ├── 📁 biomes/                       # Biome documentation
│   │   ├── NEBULA_FOREST.md
│   │   ├── LUNAR_CAVERNS.md
│   │   ├── STARFALL_DESERT.md
│   │   ├── COMET_SHORES.md
│   │   ├── VOID_TEMPLE.md
│   │   ├── OUTER_RIM.md
│   │   ├── AURORA_TUNDRA.md
│   │   └── RIFT_FRAGMENT.md
│   └── 📁 MAP_LAYOUTS/                  # Map layouts
│
├── 📁 tools/                              # Automation scripts
│   ├── 📁 blender/                       # Blender scripts
│   │   ├── apply_rig_names.py
│   │   └── fix_uvs.py
│   ├── 📁 mesh/                          # Mesh processing
│   │   ├── combine_meshes.py
│   │   └── reduce_polys.py
│   └── 📁 animation/                     # Animation export
│       └── export_batch.py
│
└── 📁 tests/                              # Automated tests
    ├── 📁 unit/                          # Unit tests
    │   ├── test_species_controller.lua
    │   └── test_currency_controller.lua
    ├── 📁 integration/                   # Integration tests
    └── 📁 validation/                    # Validation tests
```

---

## 📝 Files You Should .gitignore

Add this to `.gitignore` in the root:

```gitignore
# Roblox Studio
*.rbxl
*.rbxlx
*.rbxm
*.rblx
*.rbxl.autosaves
*.tmp

# Logs
logs/
*.log

# OS files
.DS_Store
Thumbs.db

# Blender backups
*.blend1
*.blend2

# Meshy files
*.glb
*.obj

# Cursor's working folders
.cursor
```

**Reason:** You don't want to store raw Roblox place files or local temp files.

---

## 🚫 Files You Should .cursorignore

Cursor should not attempt to parse binary/asset files.

In `.cursorignore`:

```gitignore
assets/**
tools/**
docs/**
*.blend
*.fbx
*.png
*.jpg
*.jpeg
*.psd
*.obj
```

**Why:** Cursor will then focus ONLY on:
- Lua scripts
- ModuleScripts
- UI code
- Config files
- Readable text

This massively improves Cursor's ability to assist.

---

---

## 📁 Complete Repository Structure

```
cosmo-cats/
│
├── 📄 README.md                          # Main project overview
├── 📄 LICENSE                            # MIT License
├── 📄 .gitignore                         # Git ignore rules
├── 📄 .cursorignore                      # Cursor ignore rules
│
├── 📁 studio-project/                    # All Roblox files (primary game)
│   ├── README.md                         # Studio project documentation
│   ├── default.project.json              # Rojo project config
│   └── src/                              # Mirrors Roblox Studio Explorer
│   │
│   ├── 📁 ReplicatedStorage/             # Shared code & assets
│   │   ├── 📁 CosmoCatsModels/           # Species models
│   │   │   ├── GALAXY_KITTEN/
│   │   │   │   ├── Model.rbxm
│   │   │   │   ├── icon.png (optional)
│   │   │   │   └── thumbnail.png (optional)
│   │   │   └── README.md
│   │   │
│   │   ├── 📁 CosmoCatsAnimations/       # Species animation overrides
│   │   │   ├── BLACK_HOLE_CAT/
│   │   │   │   ├── Idle.anim
│   │   │   │   └── Float.anim
│   │   │   └── README.md
│   │   │
│   │   ├── 📁 CosmoCatsAccessories/      # Accessory models
│   │   │   ├── STAR_COLLAR/
│   │   │   │   └── MeshPart.rbxm
│   │   │   └── README.md
│   │   │
│   │   ├── 📁 CosmoCatsEffects/           # Particle effects
│   │   │   ├── NebulaAura.rbxm
│   │   │   ├── StarTrail.rbxm
│   │   │   └── README.md
│   │   │
│   │   ├── 📁 SharedAnimations/          # Shared animations
│   │   │   ├── Idle.anim
│   │   │   ├── Walk.anim
│   │   │   ├── Run.anim
│   │   │   ├── Sit.anim
│   │   │   ├── Lay.anim
│   │   │   ├── Loaf.anim
│   │   │   ├── Groom.anim
│   │   │   ├── TailFlick.anim
│   │   │   └── README.md
│   │   │
│   │   ├── 📁 Modules/                   # Shared modules
│   │   │   ├── 📁 Species/
│   │   │   │   ├── SpeciesController.lua
│   │   │   │   ├── SpeciesData.lua
│   │   │   │   ├── DefaultSpeciesConfig.lua
│   │   │   │   └── ScaleHelper.lua
│   │   │   │
│   │   │   ├── 📁 Emotes/
│   │   │   │   ├── EmoteController.lua
│   │   │   │   └── EmoteList.lua
│   │   │   │
│   │   │   ├── 📁 Currency/
│   │   │   │   ├── CurrencyController.lua
│   │   │   │   └── StardustRewards.lua
│   │   │   │
│   │   │   ├── 📁 Character/
│   │   │   │   ├── CharacterCreator.lua
│   │   │   │   ├── PatternLibrary.lua
│   │   │   │   ├── AccessoriesLibrary.lua
│   │   │   │   └── EffectsLibrary.lua
│   │   │   │
│   │   │   ├── 📁 Clans/
│   │   │   │   ├── ClanController.lua
│   │   │   │   ├── ClanRoles.lua
│   │   │   │   └── ClanPermissions.lua
│   │   │   │
│   │   │   ├── 📁 Beds/
│   │   │   │   ├── BedController.lua
│   │   │   │   └── BedTypes.lua
│   │   │   │
│   │   │   ├── 📁 Utility/
│   │   │   │   ├── Signal.lua
│   │   │   │   ├── DataValidation.lua
│   │   │   │   └── TableUtils.lua
│   │   │   │
│   │   │   └── 📁 Config/
│   │   │       ├── GameConfig.lua
│   │   │       ├── VIPConfig.lua
│   │   │       └── UnlockablesConfig.lua
│   │   │
│   │   ├── 📁 Shared/                    # Shared utilities
│   │   │   ├── 📁 Events/
│   │   │   │   ├── EventSystem.lua
│   │   │   │   ├── EconomyEvents.lua
│   │   │   │   ├── ShopEvents.lua
│   │   │   │   ├── InventoryEvents.lua
│   │   │   │   ├── ProgressionEvents.lua
│   │   │   │   └── PlayerDataEvents.lua
│   │   │   │
│   │   │   ├── 📁 Config/
│   │   │   │   ├── EconomyConfig.lua
│   │   │   │   └── ShopConfig.lua
│   │   │   │
│   │   │   ├── 📁 Types/
│   │   │   │   └── PlayerData.lua
│   │   │   │
│   │   │   ├── 📁 Utils/
│   │   │   │   ├── MathUtils.lua
│   │   │   │   └── StringUtils.lua
│   │   │   │
│   │   │   └── 📁 Managers/
│   │   │       └── README.md
│   │   │
│   │   ├── 📁 Remotes/                   # RemoteEvents & RemoteFunctions
│   │   │   ├── 📁 PlayerDataRemotes/
│   │   │   ├── 📁 ShopRemotes/
│   │   │   ├── 📁 InventoryRemotes/
│   │   │   ├── 📁 SpeciesRemotes/
│   │   │   ├── 📁 ClanRemotes/
│   │   │   ├── 📁 CharacterRemotes/
│   │   │   ├── 📁 EmoteRemotes/
│   │   │   ├── 📁 BedRemotes/
│   │   │   └── README.md
│   │   │
│   │   ├── 📁 Assets/                    # Other assets
│   │   │   └── README.md
│   │   │
│   │   └── README.md
│   │
│   ├── 📁 ServerScriptService/           # Server-side scripts
│   │   ├── Main.server.lua               # Main server entry point
│   │   ├── 📁 Systems/
│   │   │   ├── DataStoreManager.server.lua
│   │   │   ├── PlayerDataManager.server.lua
│   │   │   ├── EconomyManager.server.lua
│   │   │   └── ShopManager.server.lua
│   │   │
│   │   ├── SpeciesServer.lua
│   │   ├── EmoteServer.lua
│   │   ├── CurrencyServer.lua
│   │   ├── ClanServer.lua
│   │   ├── BedServer.lua
│   │   ├── DataServer.lua
│   │   └── VIPServer.lua
│   │
│   ├── 📁 ServerStorage/                 # Server-only storage
│   │   ├── 📁 DataStores/
│   │   │   ├── PlayerDataStore.lua
│   │   │   └── ClanDataStore.lua
│   │   │
│   │   ├── 📁 InternalConfigs/
│   │   │   └── ServerConfig.lua
│   │   │
│   │   └── 📁 BackendModules/
│   │       ├── SaveSystem.lua
│   │       └── AutoBackup.lua
│   │
│   ├── 📁 StarterPlayer/                 # Client-side scripts
│   │   ├── 📁 StarterPlayerScripts/
│   │   │   ├── PlayerLoader.client.lua
│   │   │   ├── SpeciesClient.client.lua
│   │   │   ├── EmoteClient.client.lua
│   │   │   ├── CharacterCreatorClient.client.lua
│   │   │   ├── ClanClient.client.lua
│   │   │   ├── CurrencyClient.client.lua
│   │   │   └── BedClient.client.lua
│   │   │
│   │   ├── 📁 StarterCharacterScripts/
│   │   │   ├── AnimationController.lua
│   │   │   └── ZeroGravityController.lua
│   │   │
│   │   └── README.md
│   │
│   ├── 📁 StarterGui/                    # UI systems
│   │   ├── 📁 MainMenuGui/
│   │   │   ├── MainMenuScreenGui
│   │   │   └── 📁 Scripts/
│   │   │       └── MainMenu.client.lua
│   │   │
│   │   ├── 📁 SpeciesSelectorGui/
│   │   │   ├── SpeciesSelectorScreenGui
│   │   │   └── 📁 Scripts/
│   │   │       └── SpeciesSelector.client.lua
│   │   │
│   │   ├── 📁 CharacterCreatorGui/
│   │   │   ├── CharacterCreatorScreenGui
│   │   │   └── 📁 Scripts/
│   │   │       └── CharacterCreator.client.lua
│   │   │
│   │   ├── 📁 EmoteBarGui/
│   │   │   ├── EmoteBarScreenGui
│   │   │   └── 📁 Scripts/
│   │   │       └── EmoteBar.client.lua
│   │   │
│   │   ├── 📁 ClanGui/
│   │   │   ├── ClanScreenGui
│   │   │   └── 📁 Scripts/
│   │   │       └── ClanGui.client.lua
│   │   │
│   │   ├── 📁 CurrencyGui/
│   │   │   ├── StardustGui
│   │   │   └── 📁 Scripts/
│   │   │       └── Stardust.client.lua
│   │   │
│   │   └── README.md
│   │
│   ├── 📁 Workspace/                     # Game world
│   │   ├── 📁 Map/
│   │   │   ├── 📁 NebulaForest/
│   │   │   ├── 📁 LunarCaverns/
│   │   │   ├── 📁 StarfallDesert/
│   │   │   ├── 📁 CometShores/
│   │   │   └── 📁 VoidTemple/
│   │   │
│   │   ├── 📁 SpawnPoints/
│   │   │   ├── ForestSpawn
│   │   │   ├── CavernSpawn
│   │   │   ├── DesertSpawn
│   │   │   ├── ShoresSpawn
│   │   │   └── TempleSpawn
│   │   │
│   │   ├── 📁 Beds/
│   │   │   ├── BlanketBed.model
│   │   │   ├── BoxBed.model
│   │   │   ├── MoonRockBed.model
│   │   │   ├── NebulaHammock.model
│   │   │   └── StarCradle.model
│   │   │
│   │   ├── 📁 InteractableItems/
│   │   │   ├── StardustCrystal.model
│   │   │   ├── CosmicBerry.model
│   │   │   └── CrystalFragment.model
│   │   │
│   │   └── README.md
│   │
│   └── 📁 Lighting/                      # Lighting & atmosphere
│       ├── DayNightController.lua
│       ├── NebulaSkybox
│       └── 📁 Effects/
│           ├── SpaceFog
│           ├── StarParticles
│           └── AuroraBeams
│
├── 📁 assets/                            # External assets (not in Roblox)
│   └── 📁 avatars/
│       └── README.md
│
├── 📁 AI Docs/                           # AI-generated assets & docs
│   ├── 📁 Assets/
│   │   ├── 📁 CatBox/
│   │   ├── 📁 CatLitter/
│   │   ├── 📁 CatNip/
│   │   ├── 📁 CatPoop/
│   │   ├── 📁 CatTreat/
│   │   ├── 📁 Fish/
│   │   └── 📁 FurBall/
│   │
│   ├── 📁 Avatars/
│   │   └── 📁 Cosmo Kitten/
│   │
│   └── 📁 Ideas_Plans_Systems/
│
└── 📁 scripts/                           # Build & utility scripts
    └── start-rojo.sh                     # Rojo startup script
```

---

## 📂 What Each Top-Level Folder Is For

### 📁 studio-project/

This mirrors the Roblox Explorer window exactly using FolderSync tools.

**Inside it:**
```
studio-project/src/
    ReplicatedStorage/
    StarterPlayer/
    StarterGui/
    ServerScriptService/
    ServerStorage/
    Workspace/
    Lighting/
```

**Why this works:**
- Cursor can generate real Roblox code
- You sync only `.lua` and `.rbxm` files to GitHub, not the `.rbxl` binary
- Clean, version-controlled codebase

### 📁 assets/

All 3D content generated via Meshy AI or Blender.

**Structure:**
```
assets/
├── models/              # Species models
│   ├── GALAXY_KITTEN/
│   │   └── Model.fbx or Model.rbxm
│   ├── COSMO_SHORTHAIR/
│   └── LUNAR_LYNX/
│
├── animations/          # Animation files
│   ├── Idle.fbx
│   ├── Walk.fbx
│   └── Sit.fbx
│
├── textures/            # Texture files
│   ├── species/
│   ├── patterns/
│   └── eyes/
│
└── effects/             # Particle effects
    ├── star_aura/
    ├── nebula_swirl/
    └── black_hole/
```

### 📁 docs/

Game design documentation for yourself or Claude.

**Structure:**
```
docs/
├── species/             # Species documentation
├── pipeline/            # Pipeline documentation
│   └── CHARACTER_PIPELINE.md
└── ui/                  # UI documentation
```

### 📁 tools/

Utility scripts for exporters, converters, and mesh cleanup.

**Structure:**
```
tools/
├── exporters/           # Export scripts
├── converters/          # Format converters
└── mesh-cleanup-scripts/ # Mesh cleanup tools
```

### 📁 tests/

Automated tests that Cursor can generate.

**Structure:**
```
tests/
├── unit/                # Unit tests
├── integration/         # Integration tests
└── validation/         # Validation tests
```

---

## 🎯 Best Practices

### 1. File Naming Conventions

**Scripts:**
- Server scripts: `*.server.lua`
- Client scripts: `*.client.lua`
- Module scripts: `*.lua` (no suffix)
- Use PascalCase for module names: `SpeciesController.lua`

**Models:**
- Species models: `Model.rbxm` (inside species folder)
- Accessories: `MeshPart.rbxm` (inside accessory folder)
- Effects: `[EffectName].rbxm` (PascalCase)
- Animations: `[AnimationName].anim` (PascalCase)

**Folders:**
- Use PascalCase for folder names: `CosmoCatsModels/`
- Species folders: UPPERCASE with underscores: `GALAXY_KITTEN/`
- Accessory folders: UPPERCASE with underscores: `STAR_COLLAR/`

### 2. Code Organization

**Module Structure:**
```lua
-- ModuleName.lua
-- Brief description of what this module does.

local ModuleName = {}

--[[
    Public API:
    ModuleName.FunctionName(param) -> returnType
]]

-- Private functions
local function privateFunction()
    -- Implementation
end

-- Public functions
function ModuleName.PublicFunction()
    -- Implementation
end

return ModuleName
```

**Header Comments:**
- Every file should have a header comment describing its purpose
- Include usage examples for complex modules
- Document public API in comments

### 3. Git Workflow & Branching Strategy

**Branching:**
- `main` - Production-ready code
- `dev` - Development branch
- `feature/[feature-name]` - Feature branches
  - Example: `feature/species-black-hole-cat`
  - Example: `feature/clan-system`
  - Example: `feature/character-creator`
- `hotfix/[bug-name]` - Hotfix branches
  - Example: `hotfix/animation-controller`

**How to Work:**
1. Do your coding in Cursor
2. Commit changes to `dev`
3. Merge into `main` only when stable

**Claude Code Pro is excellent for:**
- Reviewing PRs
- Cleaning up code
- Refactoring across many files
- Finding unused modules/variables

**Commits:**
- Use clear, descriptive commit messages
- Reference issues/PRs when applicable
- Group related changes together

**Ignore Files:**
- `.gitignore` - Standard Roblox ignores (see Section 3 below)
- `.cursorignore` - Large assets, build files, temp files (see Section 4 below)

### 4. Documentation Standards

**README Files:**
- Every major folder should have a `README.md`
- Document purpose, structure, and usage
- Include code examples where helpful

**Inline Documentation:**
- Comment complex logic
- Document function parameters and return types
- Explain "why" not just "what"

### 5. Asset Management & Versioning

**Meshy Models:**
- Follow CHARACTER_PIPELINE.md checklist
- Validate before importing
- Use consistent naming conventions
- Store in appropriate folders

**Versioning Strategy:**
For each species:
```
assets/models/GALAXY_KITTEN/
    v1_Model.fbx
    v2_Model.fbx
    Model.rbxm          # exported to Roblox
```

**Only `Model.rbxm` is synced into `studio-project/src/...`**

This lets you:
- Rebuild species later
- Roll back versions
- Create variants (Aurora, Solar)

**Animations:**
- Shared animations in `SharedAnimations/`
- Species overrides in `CosmoCatsAnimations/[SPECIES_ID]/`
- Use fallback system

**Textures:**
- Store in Roblox as assets
- Reference via asset IDs in PatternLibrary
- Use consistent naming

### 6. Testing & Validation

**Pre-Import Checklist:**
- See CHARACTER_PIPELINE.md Section 15
- Validate all Meshy models before importing
- Test animations work correctly
- Verify scale is correct

**In-Game Testing:**
- Test species selector
- Verify character creator
- Check animations
- Validate accessories/effects attach correctly

### 7. Cursor Integration & Automatic Script Generation

**Multi-File Generation:**
- Cursor can generate entire systems at once
- Use consistent patterns across files
- Follow established module structure

**Code Generation:**
- Use header comments to guide Cursor
- Include TODO comments for future work
- Document expected behavior

**Using Cursor:**
To generate new controllers, modules, or UI:
1. Open `/studio-project/src`
2. Use the curated prompts inside `/docs/prompts`
3. Cursor will create files inside the matching folder structure

**Cursor focuses ONLY on:**
- Lua scripts
- ModuleScripts
- UI code
- Config files
- Readable text

(Not binary files - see `.cursorignore`)

### 8. Claude Code Pro Integration & Long-Term Maintenance

**Large Refactors:**
- Claude can refactor across multiple files
- Maintain consistent patterns
- Update documentation when refactoring

**Documentation:**
- Claude maintains CHARACTER_PIPELINE.md
- Updates species documentation
- Refactors large modules

**Claude is ideal for:**
- ✔ Auditing code for memory leaks
- ✔ Ensuring consistent naming
- ✔ Updating documentation
- ✔ Rewriting entire modules based on new pipeline rules
- ✔ Reviewing complex species changes
- ✔ Batch-editing animation IDs across 100 files
- ✔ Fixing circular dependencies
- ✔ Creating a full technical spec doc automatically
- ✔ Reviewing PRs
- ✔ Cleaning up code
- ✔ Finding unused modules/variables

### 9. Roblox Studio Workflow

**Rojo Integration:**
- Use `default.project.json` for Rojo
- Sync code from filesystem to Studio
- Keep code in `src/` folder

**Asset Import:**
- Import models into appropriate folders
- Follow folder structure exactly
- Use consistent naming

### 10. Scalability

**Adding New Species:**
- Follow 2-minute workflow (CHARACTER_PIPELINE.md Section 13)
- Use standardized pipeline
- Validate before committing

**Adding New Systems:**
- Follow established patterns
- Update documentation
- Maintain consistency

---

## 🔧 Development Tools

### Required Tools

1. **Roblox Studio** - Game development environment
2. **Rojo** - File sync tool
3. **Cursor** - Primary coding environment
4. **Claude Code Pro** - Multi-file refactoring
5. **Meshy AI** - 3D model generation
6. **Git** - Version control

### Setup Process

1. Clone repository
2. Install Rojo
3. Configure `default.project.json`
4. Open Roblox Studio
5. Connect Rojo
6. Start developing!

---

## 📚 Key Documentation Files

- **README.md** - Project overview
- **docs/CHARACTER_PIPELINE.md** - Complete character pipeline guide
- **docs/ARCHITECTURE.md** - System architecture
- **docs/GETTING_STARTED.md** - Setup instructions
- **GITHUB_STRUCTURE.md** - This file

---

## 🚀 Quick Start

1. Read `docs/GETTING_STARTED.md`
2. Review `docs/CHARACTER_PIPELINE.md`
3. Set up Rojo connection
4. Start with species creation workflow
5. Test in Roblox Studio

---

## 📝 Notes

- This structure mirrors real game studio workflows
- Optimized for AI-assisted development
- Designed for long-term maintainability
- Scales to dozens of species easily
- Follows Roblox best practices

---

**Last Updated:** Repository structure documentation  
**Status:** Ready for development ✅

