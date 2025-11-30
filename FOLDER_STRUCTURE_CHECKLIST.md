# 📁 Cosmo Cats — Folder Structure Checklist

**Use this checklist to verify all folders are created in Roblox Studio.**

---

## ✅ ReplicatedStorage Structure

### Main CosmoCats Folder
- [ ] `ReplicatedStorage/CosmoCats/`

### Data & Libraries
- [ ] `ReplicatedStorage/CosmoCats/SpeciesData/`
- [ ] `ReplicatedStorage/CosmoCats/PatternLibrary/`
- [ ] `ReplicatedStorage/CosmoCats/EffectsLibrary/`
- [ ] `ReplicatedStorage/CosmoCats/BedsLibrary/`
- [ ] `ReplicatedStorage/CosmoCats/Accessories/`
- [ ] `ReplicatedStorage/CosmoCats/Animations/`
- [ ] `ReplicatedStorage/CosmoCats/Sounds/`

### Systems
- [ ] `ReplicatedStorage/CosmoCats/NPCModules/`
- [ ] `ReplicatedStorage/CosmoCats/InteractionEvents/`
- [ ] `ReplicatedStorage/CosmoCats/EventDefinitions/`
- [ ] `ReplicatedStorage/CosmoCats/ClanData/`
- [ ] `ReplicatedStorage/CosmoCats/LoreFragments/`
- [ ] `ReplicatedStorage/CosmoCats/UIAssets/`

### Remotes
- [ ] `ReplicatedStorage/CosmoCats/Remotes/`
- [ ] `ReplicatedStorage/CosmoCats/Remotes/Species/`
- [ ] `ReplicatedStorage/CosmoCats/Remotes/Currency/`
- [ ] `ReplicatedStorage/CosmoCats/Remotes/Clans/`
- [ ] `ReplicatedStorage/CosmoCats/Remotes/Events/`
- [ ] `ReplicatedStorage/CosmoCats/Remotes/Interactions/`
- [ ] `ReplicatedStorage/CosmoCats/Remotes/NPCs/`

### Modules
- [ ] `ReplicatedStorage/CosmoCats/Modules/`
- [ ] `ReplicatedStorage/CosmoCats/Modules/Species/`
- [ ] `ReplicatedStorage/CosmoCats/Modules/Currency/`
- [ ] `ReplicatedStorage/CosmoCats/Modules/Clans/`
- [ ] `ReplicatedStorage/CosmoCats/Modules/Character/`
- [ ] `ReplicatedStorage/CosmoCats/Modules/Beds/`
- [ ] `ReplicatedStorage/CosmoCats/Modules/Config/`
- [ ] `ReplicatedStorage/CosmoCats/Modules/Utility/`

### Assets
- [ ] `ReplicatedStorage/CosmoCats/SharedAnimations/`
- [ ] `ReplicatedStorage/CosmoCatsModels/`
- [ ] `ReplicatedStorage/CosmoCatsAnimations/`
- [ ] `ReplicatedStorage/CosmoCatsAccessories/`
- [ ] `ReplicatedStorage/CosmoCatsEffects/`

---

## ✅ ServerScriptService Structure

- [ ] `ServerScriptService/SpeciesService.lua` (will be created via Rojo)
- [ ] `ServerScriptService/DataService.lua` (will be created via Rojo)
- [ ] `ServerScriptService/EventManager.lua` (will be created via Rojo)
- [ ] `ServerScriptService/NPCManager.lua` (will be created via Rojo)
- [ ] `ServerScriptService/ClanManager.lua` (will be created via Rojo)
- [ ] `ServerScriptService/ShrineManager.lua` (will be created via Rojo)
- [ ] `ServerScriptService/CurrencyServer.lua` (will be created via Rojo)
- [ ] `ServerScriptService/SaveSystem.lua` (will be created via Rojo)

**Note:** Scripts are created via Rojo/Cursor, folders are empty for now.

---

## ✅ ServerStorage Structure

- [ ] `ServerStorage/BackendModules/` (folder
- [ ] `ServerStorage/DataStores/` (folder)
- [ ] `ServerStorage/InternalConfigs/` (folder)

**Scripts created via Rojo:**
- `ServerStorage/BackendModules/SaveSystem.lua`
- `ServerStorage/BackendModules/AutoBackup.lua`
- `ServerStorage/DataStores/PlayerDataStore.lua`
- `ServerStorage/DataStores/ClanDataStore.lua`
- `ServerStorage/InternalConfigs/ServerConfig.lua`

---

## ✅ StarterPlayer Structure

- [ ] `StarterPlayer/StarterPlayerScripts/` (folder)
- [ ] `StarterPlayer/StarterCharacterScripts/` (folder)

**Scripts created via Rojo:**
- `StarterPlayer/StarterPlayerScripts/InputController.lua`
- `StarterPlayer/StarterPlayerScripts/EmoteController.lua`
- `StarterPlayer/StarterPlayerScripts/InteractionController.lua`
- `StarterPlayer/StarterPlayerScripts/UIController.lua`
- `StarterPlayer/StarterPlayerScripts/CameraController.lua`
- `StarterPlayer/StarterPlayerScripts/FXController.lua`
- `StarterPlayer/StarterPlayerScripts/SpeciesClient.client.lua`
- `StarterPlayer/StarterPlayerScripts/CurrencyClient.client.lua`
- `StarterPlayer/StarterPlayerScripts/ClanClient.client.lua`
- `StarterPlayer/StarterPlayerScripts/BedClient.client.lua`
- `StarterPlayer/StarterCharacterScripts/AnimationController.lua`
- `StarterPlayer/StarterCharacterScripts/ZeroGravityController.lua`

---

## ✅ StarterGui Structure

- [ ] `StarterGui/UI/` (main folder)
- [ ] `StarterGui/UI/MainHUD/`
- [ ] `StarterGui/UI/CustomizerUI/`
- [ ] `StarterGui/UI/EmoteWheel/`
- [ ] `StarterGui/UI/InventoryUI/`
- [ ] `StarterGui/UI/ClanUI/`
- [ ] `StarterGui/UI/ShrineUI/`
- [ ] `StarterGui/UI/MapUI/`
- [ ] `StarterGui/UI/SpeciesSelectorGui/`
- [ ] `StarterGui/UI/CharacterCreatorGui/`
- [ ] `StarterGui/UI/CurrencyGui/`
- [ ] `StarterGui/UI/SettingsGui/`
- [ ] `StarterGui/UI/MainMenuGui/`

**Note:** UI elements created via Rojo/Cursor.

---

## ✅ Workspace Structure

### Biomes
- [ ] `Workspace/Biomes/` (folder)
- [ ] `Workspace/Biomes/NebulaForest/`
- [ ] `Workspace/Biomes/LunarCaverns/`
- [ ] `Workspace/Biomes/StarfallDesert/`
- [ ] `Workspace/Biomes/CometShores/`
- [ ] `Workspace/Biomes/VoidTemple/`
- [ ] `Workspace/Biomes/OuterRim/`

### NPCs
- [ ] `Workspace/NPCs/` (folder)
- [ ] `Workspace/NPCs/Spirits/`
- [ ] `Workspace/NPCs/Guardians/`
- [ ] `Workspace/NPCs/LoreCats/`

### Interactables
- [ ] `Workspace/Beds/`
- [ ] `Workspace/InteractableItems/`
- [ ] `Workspace/SpawnPoints/`

---

## ✅ Lighting Structure

- [ ] `Lighting/` (folder in Lighting service)
- [ ] `Lighting/Effects/` (folder)
- [ ] `Lighting/DayNightController.lua` (script, created via Rojo)

**Note:** DayNightController.lua is a script in the Lighting service.

---

## 📝 Creation Tips

**In Roblox Studio:**

1. **Right-click** on service (ReplicatedStorage, etc.)
2. **Insert → Folder**
3. **Name it exactly** as shown
4. **Create nested folders** by right-clicking parent → Insert → Folder

**Quick Method:**
- Create main folders first (CosmoCats, Biomes, etc.)
- Then create subfolders
- Use this checklist to verify

---

## ✅ Verification

**After creating all folders:**

1. Count total folders (should be ~60+ folders)
2. Verify no typos in folder names
3. Check nested structure is correct
4. Verify all services have their folders

**Then proceed to:**
- Start Rojo server
- Use Cursor T1 prompt to generate scripts
- Test sync in Roblox Studio

---

**Last Updated:** Folder Structure Checklist  
**Version:** 1.0  
**Status:** Ready for Verification ✅
