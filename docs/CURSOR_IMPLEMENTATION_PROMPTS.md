# 🌌 Cosmo Cats — Cursor Implementation Prompts

**Version:** 1.0  
**Last Updated:** Cursor Implementation Guide  
**Status:** Complete Implementation Prompts ✅

---

## 📋 Table of Contents

1. [T1 — Create the Full Folder Structure](#t1--create-the-full-folder-structure)
2. [T2 — Build the Core Script Architecture](#t2--build-the-core-script-architecture)
3. [T3 — Create Species System Framework](#t3--create-species-system-framework)
4. [T4 — Generate Customization System](#t4--generate-customization-system)
5. [T5 — Implement Interaction Tools](#t5--implement-interaction-tools)
6. [T6 — Create Emote Wheel](#t6--create-emote-wheel)
7. [T7 — Build Global Event Manager](#t7--build-global-event-manager)
8. [T8 — Design Clan System](#t8--design-clan-system)
9. [T9 — NPC & Lore System](#t9--npc--lore-system)
10. [T10 — DataStore Implementation](#t10--datastore-implementation)
11. [T11 — FX & VFX Framework](#t11--fx--vfx-framework)
12. [T12 — UI Framework](#t12--ui-framework)
13. [T13 — Implement Camera System](#t13--implement-camera-system)
14. [T14 — Asset Loader (Meshy / Model Import Framework)](#t14--asset-loader-meshy--model-import-framework)
15. [T15 — Full Gameplay "Hello World" Integration](#t15--full-gameplay-hello-world-integration)
16. [T16 — Code Clean-Up, Documentation, and Comments](#t16--code-clean-up-documentation-and-comments)

---

## ⭐ T1 — Create the Full Folder Structure

**Copy/paste this into Cursor:**

```
Create the full folder structure for the Roblox project "Cosmo Cats" using the following hierarchy:

ReplicatedStorage/
    CosmoCats/
        SpeciesData/
        PatternLibrary/
        EffectsLibrary/
        BedsLibrary/
        Accessories/
        Animations/
        Sounds/
        NPCModules/
        InteractionEvents/
        EventDefinitions/
        ClanData/
        LoreFragments/
        UIAssets/
        Remotes/
            Species/
            Currency/
            Clans/
            Events/
            Interactions/
            NPCs/
        Modules/
            Species/
            Currency/
            Clans/
            Character/
            Beds/
            Config/
            Utility/
        SharedAnimations/

ServerScriptService/
    SpeciesService.lua
    DataService.lua
    EventManager.lua
    NPCManager.lua
    ClanManager.lua
    ShrineManager.lua
    CurrencyServer.lua
    SaveSystem.lua

ServerStorage/
    BackendModules/
        SaveSystem.lua
        AutoBackup.lua
    DataStores/
        PlayerDataStore.lua
        ClanDataStore.lua
    InternalConfigs/
        ServerConfig.lua

StarterPlayer/
    StarterPlayerScripts/
        InputController.lua
        EmoteController.lua
        InteractionController.lua
        UIController.lua
        CameraController.lua
        FXController.lua
        SpeciesClient.client.lua
        CurrencyClient.client.lua
        ClanClient.client.lua
        BedClient.client.lua
    StarterCharacterScripts/
        AnimationController.lua
        ZeroGravityController.lua

StarterGui/
    UI/
        MainHUD/
        CustomizerUI/
        EmoteWheel/
        InventoryUI/
        ClanUI/
        ShrineUI/
        MapUI/
        SpeciesSelectorGui/
        CharacterCreatorGui/
        CurrencyGui/
        SettingsGui/
        MainMenuGui/

Workspace/
    Biomes/
        NebulaForest/
        LunarCaverns/
        StarfallDesert/
        CometShores/
        VoidTemple/
        OuterRim/
    NPCs/
        Spirits/
        Guardians/
        LoreCats/
    Beds/
    InteractableItems/
    SpawnPoints/

Lighting/
    DayNightController.lua
    Effects/

Also scaffold placeholder scripts in each folder as needed. Create README.md files in major folders explaining their purpose.
```

**This generates your entire project skeleton.**

---

## ⭐ T2 — Build the Core Script Architecture

**Copy/paste this into Cursor:**

```
Generate stub implementations for the following main systems in Lua (Roblox):

1. DataService (profile loading/saving)
2. SpeciesService (handles species unlocks, switching, visual updates)
3. EventManager (global event triggers and handlers)
4. NPCManager (spawn/despawn logic, AI behavior)
5. ClanManager (clan creation, roles, membership, XP)
6. ShrineManager (lore fragments, memory sequences)
7. Interaction system (beds, dens, shrines, items)
8. FXController (client-side VFX loader)
9. UIController (main UI framework)
10. EmoteController (emote wheel, pose triggers)
11. InputController (controls and shortcuts)
12. CameraController (orbit camera + photo mode)

Each script should:
- Use ModuleScript OOP pattern
- Stub out all functions with TODO comments
- Include documentation blocks
- Reference parent directories correctly
- Prepare for later expansion
- Follow Roblox best practices
- Include error handling stubs
- Use type hints where appropriate (Luau)

Place files in their correct locations:
- Server scripts in ServerScriptService/
- Client scripts in StarterPlayer/StarterPlayerScripts/
- Modules in ReplicatedStorage/CosmoCats/Modules/
```

**This builds all your main backend & client systems.**

---

## ⭐ T3 — Create Species System Framework

**Copy/paste this into Cursor:**

```
Create a "SpeciesSystem" inside ReplicatedStorage/CosmoCats/SpeciesData.

Tasks:
- Implement a SpeciesRegistry module with functions:
    RegisterSpecies()
    GetSpeciesData()
    GetAllSpecies()
    CanPlayerUseSpecies(player, speciesId)
    GetDefaultSpecies()

- Add placeholder species: GalaxyKitten, LunarLynx, SolarTiger, VoidSentinel, CometCat.

- For each species include:
    DisplayName
    Description
    Category (Starter, Unlockable, Premium)
    BaseStats (unused but future-proof)
    DefaultColors (primary, secondary, glow)
    GlowPattern
    Animations (idle, walk, run, sit, lay, groom, stretch)
    UnlockRequirements (XP, Prestige, or GamePass ID)
    ModelFolder (name in ReplicatedStorage/CosmoCatsModels/)
    DefaultScale
    MovementProfile
    AllowedEmotes
    Abilities

- Create a SpeciesController script in StarterPlayerScripts to:
    ChangeSpecies(speciesId)
    ApplyAppearance(appearanceData)
    LoadAnimations(speciesId)
    AttachGlowEffects(speciesId)
    GetCurrentSpecies()

- Create SpeciesServer.lua in ServerScriptService to:
    Handle species unlock validation
    Spawn species models
    Save species selection
    Validate species access

- Create RemoteEvents in ReplicatedStorage/CosmoCats/Remotes/Species/:
    RequestSetSpecies (RemoteEvent)
    ConfirmSpecies (RemoteEvent)
    GetPlayerSpecies (RemoteFunction)

Include TODOs where needed. Reference the Species System documentation for complete specifications.
```

**Now Cursor generates the full species backend.**

---

## ⭐ T4 — Generate Customization System

**Copy/paste this into Cursor:**

```
Build a full Cosmetic Customizer system consisting of:

UI: CustomizerUI (StarterGui/UI/CustomizerUI)
Modules: 
    AppearanceService (ReplicatedStorage/CosmoCats/Modules/Character/)
    PatternLibrary (ReplicatedStorage/CosmoCats/PatternLibrary/)
    ColorUtilities (ReplicatedStorage/CosmoCats/Modules/Utility/)
    AccessoriesLibrary (ReplicatedStorage/CosmoCats/Accessories/)

Functionality:
- Choose base color, secondary, glow color (with color picker)
- Pattern selection (with thumbnails)
- Accessory toggles (collars, crystals, halos, etc.)
- Glow slider intensity (0-100%)
- Randomize button (generates random appearance)
- Save/Load appearance presets (DataService integration)
- Preview model (3D preview in UI)
- Apply to player button

UI Structure:
- Main Frame with tabs (Colors, Patterns, Accessories, Effects)
- Color picker panel (hue, saturation, brightness sliders)
- Pattern grid (scrollable, with thumbnails)
- Accessory list (checkboxes, with icons)
- Glow intensity slider
- Preview area (ViewportFrame)
- Save/Load preset buttons
- Randomize button
- Apply button

Use a clean UILayout (UIListLayout, UIGridLayout), mobile-friendly (scales properly).

Implement controllers:
- UpdateModelPreview(appearanceData)
- ApplyAppearanceToPlayer(player, appearanceData)
- SaveAppearance(presetName, appearanceData)
- LoadAppearance(presetId)
- RandomizeAppearance()
- ValidateAppearanceData(data)

Stub out actual UI elements but structure the code. Reference CharacterCreator documentation.
```

**This gives you a working character creator.**

---

## ⭐ T5 — Implement Interaction Tools

**Copy/paste this into Cursor:**

```
Implement InteractionController and InteractionEvents.

Interactions:
- Sit
- Lay
- Sleep Curl
- Loaf
- Groom
- Stretch
- Pounce
- Hover (Outer Rim only)
- Shrine Meditation
- Nuzzle (player-to-player)
- Cuddle (player-to-player)
- Carry (player-to-player)
- Follow (player-to-player)
- Group Sit (multiple players)

Each interaction should:
- Trigger a corresponding animation
- Apply temporary FX if needed
- Snap the player to an interaction point (bed, shrine, etc.)
- Support a cancel key (Escape or E)
- Validate interaction location (can sit here? can lay here?)
- Handle interaction duration (some are infinite, some timed)

Use ProximityPrompt where appropriate (beds, shrines, NPCs).

Create RemoteEvents in ReplicatedStorage/CosmoCats/Remotes/Interactions/:
    RequestInteraction (RemoteEvent)
    CancelInteraction (RemoteEvent)
    PlayerInteraction (RemoteEvent) - for player-to-player

InteractionController (client) should:
- Detect interaction points (beds, shrines, etc.)
- Show ProximityPrompts
- Handle input (E key, etc.)
- Trigger animations
- Apply effects

InteractionServer (server) should:
- Validate interactions
- Sync to other players
- Handle player-to-player interactions
- Manage interaction states

Reference Interaction Systems Bible for complete specifications.
```

**Now you have full RP system functionality.**

---

## ⭐ T6 — Create Emote Wheel

**Copy/paste this into Cursor:**

```
Build an Emote Wheel UI with:

- Radial layout (circular menu)
- Emote icons (8-12 emotes visible)
- Hover preview (shows emote name)
- Click to trigger animation
- Press 'R' to open wheel (or customizable key)
- Smooth fade in/out animations
- Category tabs (Basic, Social, Premium) if needed

Emote List:
- Sit
- Lay
- Loaf
- Groom
- Stretch
- Roll
- Meow
- Tail Flick
- Pounce
- Sleep Curl
- Hover (if in Outer Rim)
- Shrine Meditation

Include Controller functions:
    OpenWheel()
    CloseWheel()
    TriggerEmote(emoteId)
    GetAvailableEmotes(player)
    CheckEmoteUnlock(player, emoteId)

Connect to AnimationController for actual emotes.

UI Structure:
- Main Frame (ScreenGui)
- Radial Container (Frame with circular layout)
- Emote Buttons (ImageButtons with icons)
- Center Cancel Button
- Category Tabs (if multiple categories)

Use TweenService for smooth animations. Make it mobile-friendly (touch support).

Create EmoteController module in ReplicatedStorage/CosmoCats/Modules/Emotes/:
    PlayEmote(emoteId)
    StopCurrentEmote()
    GetEmoteList()
    IsEmoteUnlocked(player, emoteId)

Reference Animation Bible for emote specifications.
```

**Boom — emotes system ready.**

---

## ⭐ T7 — Build Global Event Manager

**Copy/paste this into Cursor:**

```
Implement EventManager with support for:

Event Types:
- Tier1 (NebulaBloom, CrystalResonance, DuneWhispers, TidalChorus)
- Tier2 (Starfall, AuroraDance, NebulaDrift, CrystalStorm)
- Tier3 (LunarConvergence, VoidEclipse, OrbitalAlignment)
- UltraRare (CosmicBloom, SolarAscension, VoidSingularity)

Each event should have:
    Duration (seconds)
    Cooldown (seconds)
    Trigger (time-based, player-count, random, etc.)
    SkyboxChanges (skybox ID, rotation, color)
    LightingTweens (brightness, ambient, fog, etc.)
    VFX sequences (particle effects, glows, etc.)
    Sound effects (ambient, SFX)
    Reward (XP, Stardust, Prestige chance)
    Optional NPC spawns (guardians, spirits)
    ClientReplication via RemoteEvents
    Server announcement (optional text)

Create event definitions in ReplicatedStorage/CosmoCats/EventDefinitions/:
    Starfall.lua
    AuroraDance.lua
    NebulaBloom.lua
    CrystalResonance.lua
    DuneWhispers.lua
    TidalChorus.lua
    NebulaDrift.lua
    CrystalStorm.lua
    LunarConvergence.lua
    VoidEclipse.lua
    OrbitalAlignment.lua
    CosmicBloom.lua
    SolarAscension.lua
    VoidSingularity.lua

EventManager (server) should:
    CheckEventTriggers()
    StartEvent(eventId)
    EndEvent(eventId)
    GetActiveEvents()
    FireEventToClients(eventId, eventData)

EventClient (client) should:
    ReceiveEventStart(eventId, eventData)
    ApplyVisualChanges(eventData)
    PlayEventVFX(eventData)
    PlayEventSounds(eventData)
    ReceiveEventEnd(eventId)

Create RemoteEvents in ReplicatedStorage/CosmoCats/Remotes/Events/:
    EventStarted (RemoteEvent)
    EventEnded (RemoteEvent)
    EventAnnouncement (RemoteEvent)

Stub event definitions inside EventDefinitions/. Reference Global Events System Bible for complete specifications.
```

**This sets up your full environmental event engine.**

---

## ⭐ T8 — Design Clan System

**Copy/paste this into Cursor:**

```
Implement ClanManager and ClanUI.

Features:
- CreateClan(name, color, symbol) - requires Lv20+ & 500 Stardust
- JoinClan(clanId)
- LeaveClan()
- InvitePlayer(playerId)
- KickPlayer(playerId) - requires permission
- ClanRoles (Leader, Officer, Member, Initiate)
- ClanXP and ClanLevel (1-20)
- ClanTerritorySpawn (custom spawn point)
- ClanChat integration
- Clan rituals (placeholder functions)
- Clan customization (banner, colors, symbol)
- Clan achievements

Create data structures in ClanData/:
    ClanRoles.lua (role definitions)
    ClanPermissions.lua (permission system)
    ClanConfig.lua (clan settings)

ClanManager (server) should:
    CreateClan(leader, name, color, symbol)
    JoinClan(player, clanId)
    LeaveClan(player)
    InvitePlayer(inviter, invitee, clanId)
    KickPlayer(kicker, target, clanId)
    SetClanRole(clanId, playerId, role)
    AddClanXP(clanId, amount)
    GetClanLevel(clanId)
    GetClanData(clanId)
    SaveClanData(clanId, data)

ClanUI (client) should:
    ShowClanMenu()
    ShowClanList()
    ShowClanMembers(clanId)
    ShowClanSettings(clanId) - if leader/officer
    ShowCreateClanUI()
    ShowInviteUI()

Create RemoteEvents in ReplicatedStorage/CosmoCats/Remotes/Clans/:
    RequestCreateClan (RemoteEvent)
    RequestJoinClan (RemoteEvent)
    RequestLeaveClan (RemoteEvent)
    RequestInvitePlayer (RemoteEvent)
    RequestKickPlayer (RemoteEvent)
    RequestSetRole (RemoteEvent)
    GetClanData (RemoteFunction)
    ClanUpdated (RemoteEvent)

Reference Clans & Social System Bible for complete specifications.
```

**Clan structure → done.**

---

## ⭐ T9 — NPC & Lore System

**Copy/paste this into Cursor:**

```
Create NPCManager with modules for:

1. WanderingSpirits
2. GuardianNPCs
3. LoreNPCs

Behaviors:
- Wandering patrols (PathfindingService)
- Hover/floating (TweenService)
- Dialogue lines (DialogueService)
- Shrine interactions (ProximityPrompt)
- Guardian appearance triggers (rare spawns)
- NPC animations (idle, float, drift, etc.)

NPC Types:
- Nebula Wisp (Forest)
- Crystal Echo Spirit (Caverns)
- Sandstar Ghost (Desert)
- Comet Guide (Shores)
- Void Echo (Temple)
- Orbit Spirits (Outer Rim)
- Moon Lynx Guardian (Caverns - rare)
- Solar Tiger Guardian (Desert - rare)
- Dream Leviathan (Outer Rim - ultra rare)
- Void Sentinel (Temple - prestige)

Implement LoreFragments folder with placeholder lore files:
    CosmicOrigin.lua
    NebulaForest.lua
    LunarCaverns.lua
    StarfallDesert.lua
    CometShores.lua
    VoidTemple.lua
    OuterRim.lua

Create ShrineManager to:
    Detect fragment count
    Trigger memory sequences
    Activate shrine effects
    Spawn shrine NPCs
    Handle shrine rituals

NPCManager (server) should:
    SpawnNPC(npcType, location)
    DespawnNPC(npcId)
    HandleNPCDialogue(npcId, player)
    TriggerGuardianSpawn(guardianType, biome)
    CheckGuardianSpawnConditions(biome)

DialogueService (shared) should:
    GetDialogue(npcId, dialogueId)
    ShowDialogue(player, npcId, text)
    HandleDialogueBranches(npcId, playerChoice)

Create RemoteEvents in ReplicatedStorage/CosmoCats/Remotes/NPCs/:
    NPCDialogue (RemoteEvent)
    GuardianSpawned (RemoteEvent)
    LoreFragmentCollected (RemoteEvent)

Reference NPCs, World Lore & Spirits System Bible for complete specifications.
```

**NPC system scaffolding → ready.**

---

## ⭐ T10 — DataStore Implementation

**Copy/paste this into Cursor:**

```
Implement DataService using ProfileService or standard DataStore:

Save/Load:
- XP
- Level
- Stardust
- PrestigePoints
- PrestigeLevel
- SpeciesUnlocked (table)
- Appearance (table with all customization data)
- EmotesUnlocked (table)
- EffectsUnlocked (table)
- PatternsUnlocked (table)
- AccessoriesUnlocked (table)
- BedsUnlocked (table)
- Clan (clanId, role)
- Discoveries (table)
- Quests (daily, weekly, completed)
- PetsUnlocked (table)
- LoreFragments (table)
- SeenMemorySequences (table)
- Settings (music volume, SFX volume, etc.)

Include:
- Versioned data (DataStoreVersion)
- Automatic backups (AutoBackup module)
- Error recovery (retry logic, fallbacks)
- PlayerAdded/Removing integration
- Auto-save intervals (every 60 seconds)
- Manual save triggers
- Data validation
- Default data structure
- Data migration (if version changes)

Create SaveSystem.lua in ServerStorage/BackendModules/:
    LoadPlayerData(player)
    SavePlayerData(player, data)
    QueueSave(player, data)
    GetDefaultPlayerData()
    ValidatePlayerData(data)
    MigratePlayerData(data, oldVersion, newVersion)

Create PlayerDataStore.lua in ServerStorage/DataStores/:
    DataStore configuration
    Key naming conventions
    Version management

Use proper error handling, retry logic (3 attempts), and rate limiting.

Reference existing SaveSystem implementation for structure.
```

**Critical for your game's persistence.**

---

## ⭐ T11 — FX & VFX Framework

**Copy/paste this into Cursor:**

```
Create FXController (client-side) with:

- LoadAura(catModel, auraId) - attaches aura particle effect
- LoadTrail(catModel, trailId) - attaches trail effect
- ApplyGlow(catModel, color, intensity) - applies glow to model
- PlayEventVFX(eventType) - plays event-specific VFX
- AttachParticlesToBones(catModel, effectId) - attaches particles to specific bones
- RemoveEffect(catModel, effectId) - removes specific effect
- ClearAllEffects(catModel) - removes all effects from model

Generate an EffectsLibrary module in ReplicatedStorage/CosmoCats/EffectsLibrary/ with placeholder effects:
    NebulaAura
    VoidAura
    SolarFlare
    StarfallTrail
    CrystalSparkles
    CometFollower
    FloatingRings
    CosmicGlow

Each effect should have:
    EffectId
    DisplayName
    ParticleSystem (or Attachment setup)
    BoneAttachment (which bone to attach to)
    Duration (if temporary, nil if permanent)
    Color
    Intensity

FXController should:
    Manage effect instances
    Handle effect cleanup
    Optimize performance (reuse particles where possible)
    Support multiple effects per model
    Handle model removal (cleanup)

Create effect templates in ReplicatedStorage/CosmoCats/Effects/:
    NebulaAura.rbxm
    VoidAura.rbxm
    (etc. - placeholder models)

Reference Asset Style Guide for VFX specifications.
```

**VFX now centralized.**

---

## ⭐ T12 — UI Framework

**Copy/paste this into Cursor:**

```
Create UIController with:

- OpenMenu(menuName)
- CloseMenu()
- ToggleMenu(menuName)
- FadeIn/Out transitions (TweenService)
- Blur effect management (BlurEffect)
- Mobile scaling (UIScale, responsive layouts)
- Menu stack management (can have multiple menus open)
- Input blocking (disable input when menu open)

Include UI modules:
    CustomizerUI
    EmoteWheel
    InventoryUI
    ClanUI
    ShrineUI
    MapUI
    MainHUD
    SpeciesSelectorGui
    CharacterCreatorGui
    CurrencyGui
    SettingsGui
    MainMenuGui

Each UI should:
    Have a main Frame (ScreenGui)
    Use UILayout (UIListLayout, UIGridLayout)
    Support mobile (scales properly)
    Have fade animations
    Be accessible via UIController

UIController should:
    Track open menus
    Handle menu transitions
    Manage input blocking
    Handle mobile vs desktop layouts
    Support keyboard shortcuts (ESC to close, etc.)

Create UI templates in StarterGui/UI/ with:
    Basic frame structure
    Button templates
    Label templates
    Slider templates
    Color picker templates

Reference GUI Architecture documentation for complete UI specifications.
```

**This creates a robust UI architecture.**

---

## ⭐ T13 — Implement Camera System

**Copy/paste this into Cursor:**

```
Implement CameraController with:

- Orbit camera (default) - follows player, can orbit around
- Follow camera (toggle) - simple follow, no orbit
- Photo Mode camera (freecam) - unlocked camera movement
- Zoom smoothing (TweenService)
- Focus tracking on player model
- Depth of field integration (future - stub)
- Disable during emotes/interactions (respects interaction state)
- Camera shake (for events, impacts)
- Smooth transitions between modes

CameraController should:
    InitializeCamera()
    SetCameraMode(mode) - Orbit, Follow, Photo
    EnablePhotoMode() - unlocks camera, shows UI
    DisablePhotoMode() - returns to normal
    ZoomIn() / ZoomOut()
    SetFocus(target) - focus on specific object
    ShakeCamera(intensity, duration) - for events
    HandleCameraInput() - mouse/touch controls

Use TweenService for smooth transitions.

Photo Mode features (if Game Pass owned):
    Free camera movement
    Filters (cosmic, void, solar, etc.)
    Bloom control
    Pose freeze
    Screenshot tools

Create RemoteEvents if needed for server-side camera control (unlikely, but stub if needed).

Reference CameraController documentation for complete specifications.
```

**Now you have professionally handled camera logic.**

---

## ⭐ T14 — Asset Loader (Meshy / Model Import Framework)

**Copy/paste this into Cursor:**

```
Create a ModelLoader module to:

- Load Meshy AI FBX / MeshPart models into correct folders
- Auto-scale to 1m humanoid height (or species default scale)
- Apply species folder naming conventions (GALAXY_KITTEN, LUNAR_LYNX, etc.)
- Attach bones to standard rig structure (R15 hierarchy)
- Validate rigs before applying animations
- Check for required bones (HumanoidRootPart, Head, etc.)
- Handle SkinnedMesh models
- Apply default materials/textures
- Set up attachments for accessories

ModelLoader should:
    LoadModel(modelPath, speciesId)
    ValidateRig(model) - checks for R15 compatibility
    ApplyScale(model, scale) - uses Humanoid:ApplyDescriptionScale()
    SetupAttachments(model) - for accessories
    ApplyDefaultMaterials(model)
    SaveToReplicatedStorage(model, speciesId)

Create folder structure:
    ReplicatedStorage/CosmoCatsModels/
        GALAXY_KITTEN/
            Model.rbxm
            icon.png (optional)
            metadata.json (optional)
        LUNAR_LYNX/
            Model.rbxm
        (etc.)

Include validation checks:
    - T-pose verification (optional, manual)
    - Bone name validation
    - Scale verification
    - Mesh quality checks

Include TODOs for exact Meshy pipeline once models are ready.

Reference Character Pipeline documentation for complete specifications.
```

**This future-proofs your characters.**

---

## ⭐ T15 — Full Gameplay "Hello World" Integration

**Copy/paste this into Cursor:**

```
Integrate all systems into a simple test:

- Spawn player in NebulaForest (Workspace/Biomes/NebulaForest/)
- Load default species (GalaxyKitten)
- Apply placeholder appearance (default colors, no patterns)
- Enable camera (CameraController initialized)
- Enable emote wheel (R key opens wheel)
- Enable interactions with a test bed (Workspace/Beds/)
- Trigger NebulaBloom event at join (first event experience)
- Show UI HUD (MainHUD visible)
- Enable Stardust earning (CurrencyServer active)
- Show currency display (CurrencyGui visible)

Purpose: ensure all systems work together at least in minimal form.

Create a MainInit.lua script in ServerScriptService that:
    Initializes all server systems in order
    Sets up player spawn logic
    Triggers first event for new players

Create a ClientInit.lua script in StarterPlayerScripts that:
    Initializes all client systems in order
    Sets up UI
    Connects to server systems
    Handles player character loading

Test checklist:
    [ ] Player spawns correctly
    [ ] Species loads and displays
    [ ] Camera works
    [ ] Emote wheel opens/closes
    [ ] Can interact with bed
    [ ] Event triggers and displays
    [ ] UI displays correctly
    [ ] Currency updates
    [ ] No errors in console
    [ ] Performance is acceptable

This makes the game actually run.
```

---

## ⭐ T16 — Code Clean-Up, Documentation, and Comments

**Copy/paste this into Cursor:**

```
Generate a documentation pass:

- Add headers to every script with:
    - File name
    - Purpose description
    - Author/version info
    - Last updated date

- Add docstrings to all module functions:
    - Function description
    - Parameters (with types)
    - Return values (with types)
    - Example usage (if complex)

- Ensure consistent naming:
    - camelCase for variables
    - PascalCase for modules/classes
    - UPPER_CASE for constants
    - Descriptive names (no abbreviations)

- Organize requires/imports:
    - Group by type (Services, Modules, Remotes)
    - Alphabetical order
    - Clear comments for each group

- Remove unused stubs:
    - Delete placeholder functions that won't be used
    - Remove commented-out code
    - Clean up TODOs that are complete

- Reformat codebase:
    - Consistent indentation (tabs or spaces, be consistent)
    - Consistent spacing
    - Consistent bracket style
    - Line length limits (80-100 chars)

- Add type hints (Luau):
    - Function parameters
    - Return types
    - Variable types (where helpful)

- Generate README.md files:
    - Root README.md with:
        - Installation instructions
        - Folder structure overview
        - Pipeline overview
        - Dev workflow
        - Quick start guide
    - README.md in major folders explaining purpose

- Create API documentation:
    - List all public functions
    - Document RemoteEvents/RemoteFunctions
    - Document data structures
    - Document configuration files

This makes your repo professional-grade.
```

---

## 🎯 Implementation Order Recommendation

**Suggested implementation sequence:**

1. **T1** - Create folder structure (foundation)
2. **T2** - Build core architecture (skeleton)
3. **T10** - DataStore implementation (critical for persistence)
4. **T3** - Species system (core gameplay)
5. **T4** - Customization system (player expression)
6. **T12** - UI framework (player interface)
7. **T6** - Emote wheel (social interaction)
8. **T5** - Interaction tools (RP depth)
9. **T11** - FX & VFX framework (visual polish)
10. **T13** - Camera system (player experience)
11. **T7** - Event manager (world dynamism)
12. **T9** - NPC & Lore system (world depth)
13. **T8** - Clan system (social structure)
14. **T14** - Asset loader (content pipeline)
15. **T15** - Full integration (make it work)
16. **T16** - Code clean-up (professional finish)

---

## 📚 Related Documentation

- **Master Game Architecture**: `docs/MASTER_GAME_ARCHITECTURE.md`
- **Character Pipeline**: `docs/pipeline/CHARACTER_PIPELINE.md`
- **Technical Architecture**: `docs/GITHUB_STRUCTURE.md`
- **All System Bibles**: `docs/*_BIBLE.md`

---

**Last Updated:** Cursor Implementation Prompts - Complete Edition  
**Version:** 1.0 - Final Complete Edition  
**Status:** Ready for Cursor Implementation ✅

**These prompts are optimized for Cursor's multi-file generation capabilities and will create a professional, modular Roblox codebase.**
