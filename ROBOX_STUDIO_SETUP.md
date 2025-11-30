# 🎮 Roblox Studio Setup Guide for Cosmo Cats

**Version:** 1.0  
**Last Updated:** Initial Setup  
**Status:** Complete Setup Instructions ✅

---

## 📋 Table of Contents

1. [Initial Project Setup](#1-initial-project-setup)
2. [Required Settings](#2-required-settings)
3. [Folder Structure Creation](#3-folder-structure-creation)
4. [Rojo Configuration](#4-rojo-configuration)
5. [Verification Checklist](#5-verification-checklist)

---

## ⭐ 1. INITIAL PROJECT SETUP

### 1.1 Create the Base Roblox Project

**Steps:**
1. Open **Roblox Studio**
2. Click **"Baseplate"** (cleanest starting point)
3. Go to **File → Save As**
4. Name it: **`CosmoCats_MainPlace`**
5. Save to your local project folder

**Note:** This will create a `.rbxl` file. We'll use Rojo to sync code files.

### 1.2 Project Location

**Recommended location:**
```
/Users/allanschenkel/Documents/Roblox Projects/CosmoCat/studio-project/
```

**File structure:**
- `CosmoCats_MainPlace.rbxl` - Main place file
- `default.project.json` - Rojo configuration
- `src/` - Source code (synced via Rojo)

---

## ⭐ 2. REQUIRED SETTINGS

### 2.1 Game Settings

**Path:** Home → Game Settings → Security

**Enable:**
- ✔ **Enable Studio Access to API Services**
- ✔ **Allow HTTP Requests** (for future API integrations)

### 2.2 Lighting Settings

**Path:** Explorer → Lighting

**Technology:**
- Set **Technology** → **Future**

**Shadows:**
- Enable **GlobalShadows**

**Performance:**
- **Disable Ambient Occlusion** if too heavy (optional, test first)

**Visual Effects:**
- Add **ColorCorrection** (for event color shifts)
- Add **Bloom** (for glow effects)
- Add **DepthOfField** (for photo mode, optional)

**Lighting Properties:**
- **Brightness:** 1.5 (default, adjust per biome)
- **Ambient:** Color3.fromRGB(100, 100, 120)
- **OutdoorAmbient:** Color3.fromRGB(150, 150, 180)
- **FogColor:** Color3.fromRGB(180, 200, 220)
- **FogEnd:** 1000

### 2.3 Workspace Settings

**Path:** Explorer → Workspace

**Properties:**
- **Gravity:** 0 (for Outer Rim zero-gravity)
- **StreamingEnabled:** true (for large world)
- **StreamingTargetRadius:** 200 (adjust as needed)

**Note:** Gravity will be controlled per-biome via scripts.

---

## ⭐ 3. FOLDER STRUCTURE CREATION

### 3.1 Create All Service Folders Manually

**Match the Cursor structure EXACTLY:**

#### ReplicatedStorage Structure

```
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
        CosmoCatsModels/
        CosmoCatsAnimations/
        CosmoCatsAccessories/
        CosmoCatsEffects/
```

#### ServerScriptService Structure

```
ServerScriptService/
    SpeciesService.lua
    DataService.lua
    EventManager.lua
    NPCManager.lua
    ClanManager.lua
    ShrineManager.lua
    CurrencyServer.lua
    SaveSystem.lua
```

#### ServerStorage Structure

```
ServerStorage/
    BackendModules/
        SaveSystem.lua
        AutoBackup.lua
    DataStores/
        PlayerDataStore.lua
        ClanDataStore.lua
    InternalConfigs/
        ServerConfig.lua
```

#### StarterPlayer Structure

```
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
```

#### StarterGui Structure

```
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
```

#### Workspace Structure

```
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
```

#### Lighting Structure

```
Lighting/
    DayNightController.lua
    Effects/
        SpaceFog/
        StarParticles/
        AuroraBeams/
```

### 3.2 Manual Creation Steps

**In Roblox Studio:**

1. **Open Explorer** (View → Explorer)
2. **Right-click on each service** (ReplicatedStorage, ServerScriptService, etc.)
3. **Insert → Folder** for each folder in the structure
4. **Name folders exactly** as shown above
5. **Create nested folders** by right-clicking parent folder → Insert → Folder

**Tip:** Create folders in this order:
1. ReplicatedStorage/CosmoCats/ (and all subfolders)
2. ServerScriptService/ (empty for now, scripts added via Rojo)
3. ServerStorage/ (and all subfolders)
4. StarterPlayer/ (and all subfolders)
5. StarterGui/UI/ (and all subfolders)
6. Workspace/ (and all subfolders)
7. Lighting/ (and all subfolders)

### 3.3 Folder Creation Checklist

**Use this checklist to verify all folders exist:**

- [ ] ReplicatedStorage/CosmoCats/ (main folder)
- [ ] ReplicatedStorage/CosmoCats/SpeciesData/
- [ ] ReplicatedStorage/CosmoCats/PatternLibrary/
- [ ] ReplicatedStorage/CosmoCats/EffectsLibrary/
- [ ] ReplicatedStorage/CosmoCats/BedsLibrary/
- [ ] ReplicatedStorage/CosmoCats/Accessories/
- [ ] ReplicatedStorage/CosmoCats/Animations/
- [ ] ReplicatedStorage/CosmoCats/Sounds/
- [ ] ReplicatedStorage/CosmoCats/NPCModules/
- [ ] ReplicatedStorage/CosmoCats/InteractionEvents/
- [ ] ReplicatedStorage/CosmoCats/EventDefinitions/
- [ ] ReplicatedStorage/CosmoCats/ClanData/
- [ ] ReplicatedStorage/CosmoCats/LoreFragments/
- [ ] ReplicatedStorage/CosmoCats/UIAssets/
- [ ] ReplicatedStorage/CosmoCats/Remotes/Species/
- [ ] ReplicatedStorage/CosmoCats/Remotes/Currency/
- [ ] ReplicatedStorage/CosmoCats/Remotes/Clans/
- [ ] ReplicatedStorage/CosmoCats/Remotes/Events/
- [ ] ReplicatedStorage/CosmoCats/Remotes/Interactions/
- [ ] ReplicatedStorage/CosmoCats/Remotes/NPCs/
- [ ] ReplicatedStorage/CosmoCats/Modules/Species/
- [ ] ReplicatedStorage/CosmoCats/Modules/Currency/
- [ ] ReplicatedStorage/CosmoCats/Modules/Clans/
- [ ] ReplicatedStorage/CosmoCats/Modules/Character/
- [ ] ReplicatedStorage/CosmoCats/Modules/Beds/
- [ ] ReplicatedStorage/CosmoCats/Modules/Config/
- [ ] ReplicatedStorage/CosmoCats/Modules/Utility/
- [ ] ReplicatedStorage/CosmoCats/SharedAnimations/
- [ ] ReplicatedStorage/CosmoCatsModels/
- [ ] ReplicatedStorage/CosmoCatsAnimations/
- [ ] ReplicatedStorage/CosmoCatsAccessories/
- [ ] ReplicatedStorage/CosmoCatsEffects/
- [ ] ServerScriptService/ (empty, scripts via Rojo)
- [ ] ServerStorage/BackendModules/
- [ ] ServerStorage/DataStores/
- [ ] ServerStorage/InternalConfigs/
- [ ] StarterPlayer/StarterPlayerScripts/
- [ ] StarterPlayer/StarterCharacterScripts/
- [ ] StarterGui/UI/MainHUD/
- [ ] StarterGui/UI/CustomizerUI/
- [ ] StarterGui/UI/EmoteWheel/
- [ ] StarterGui/UI/InventoryUI/
- [ ] StarterGui/UI/ClanUI/
- [ ] StarterGui/UI/ShrineUI/
- [ ] StarterGui/UI/MapUI/
- [ ] StarterGui/UI/SpeciesSelectorGui/
- [ ] StarterGui/UI/CharacterCreatorGui/
- [ ] StarterGui/UI/CurrencyGui/
- [ ] StarterGui/UI/SettingsGui/
- [ ] StarterGui/UI/MainMenuGui/
- [ ] Workspace/Biomes/NebulaForest/
- [ ] Workspace/Biomes/LunarCaverns/
- [ ] Workspace/Biomes/StarfallDesert/
- [ ] Workspace/Biomes/CometShores/
- [ ] Workspace/Biomes/VoidTemple/
- [ ] Workspace/Biomes/OuterRim/
- [ ] Workspace/NPCs/Spirits/
- [ ] Workspace/NPCs/Guardians/
- [ ] Workspace/NPCs/LoreCats/
- [ ] Workspace/Beds/
- [ ] Workspace/InteractableItems/
- [ ] Workspace/SpawnPoints/
- [ ] Lighting/Effects/

---

## ⭐ 4. ROJO CONFIGURATION

### 4.1 Verify Rojo Project File

**Location:** `studio-project/default.project.json`

**The file should exist and be configured correctly.**

### 4.2 Rojo Setup Steps

1. **Install Rojo** (if not already installed):
   ```bash
   npm install -g rojo
   ```

2. **Start Rojo server:**
   ```bash
   cd studio-project
   rojo serve
   ```

3. **In Roblox Studio:**
   - Install **Rojo Plugin** from Roblox
   - Click **Rojo → Connect**
   - Default port: **34872**

4. **Sync files:**
   - Files in `src/` will sync to Roblox Studio
   - Changes in Studio will NOT sync back (one-way sync)

### 4.3 Rojo Workflow

**Development workflow:**
1. Edit files in `studio-project/src/` (using Cursor/VS Code)
2. Rojo automatically syncs to Roblox Studio
3. Test in Roblox Studio
4. Iterate

**Important:**
- Don't edit scripts directly in Roblox Studio (they'll be overwritten)
- Always edit in `studio-project/src/`
- Use Rojo to sync changes

---

## ⭐ 5. VERIFICATION CHECKLIST

### 5.1 Project Setup

- [ ] Roblox Studio project created and saved
- [ ] Project named "CosmoCats_MainPlace"
- [ ] Project saved in correct location

### 5.2 Settings

- [ ] Studio Access to API Services enabled
- [ ] HTTP Requests allowed
- [ ] Lighting Technology set to Future
- [ ] GlobalShadows enabled
- [ ] ColorCorrection added
- [ ] Bloom added
- [ ] DepthOfField added (optional)

### 5.3 Folder Structure

- [ ] All ReplicatedStorage folders created
- [ ] All ServerScriptService folders created
- [ ] All ServerStorage folders created
- [ ] All StarterPlayer folders created
- [ ] All StarterGui folders created
- [ ] All Workspace folders created
- [ ] All Lighting folders created

### 5.4 Rojo Setup

- [ ] Rojo installed
- [ ] `default.project.json` exists
- [ ] Rojo plugin installed in Studio
- [ ] Rojo server running
- [ ] Rojo connected in Studio
- [ ] Test sync works (create test file, verify it appears)

### 5.5 Next Steps

Once verified:
1. ✅ Proceed to **T1** in Cursor Implementation Prompts
2. ✅ Use Cursor to generate all scripts
3. ✅ Test in Roblox Studio
4. ✅ Iterate and refine

---

## 🎯 Quick Start Commands

**Start Rojo server:**
```bash
cd "/Users/allanschenkel/Documents/Roblox Projects/CosmoCat/studio-project"
rojo serve
```

**Verify Rojo connection:**
- In Roblox Studio: Rojo → Connect
- Should show "Connected" status

**Test sync:**
- Create a test file in `studio-project/src/ReplicatedStorage/Test.lua`
- Should appear in Roblox Studio Explorer

---

## 📚 Related Documentation

- **Cursor Implementation Prompts**: `docs/CURSOR_IMPLEMENTATION_PROMPTS.md`
- **Master Game Architecture**: `docs/MASTER_GAME_ARCHITECTURE.md`
- **Rojo Documentation**: https://rojo.space/docs/

---

**Last Updated:** Roblox Studio Setup Guide  
**Version:** 1.0  
**Status:** Ready for Setup ✅

**Follow this guide step-by-step to set up your Roblox Studio project for Cosmo Cats.**
