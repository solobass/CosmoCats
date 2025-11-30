# Cosmo Cats - Complete GUI System Architecture

This document provides the complete GUI hierarchy, wireframes, and specifications for Cursor to generate all GUIs.

## 📁 Full GUI System Overview

```
StarterGui/
│
├── MainMenuGui/
├── SpeciesSelectorGui/
├── CharacterCreatorGui/
├── EmoteBarGui/
├── CurrencyGui/
├── ClanGui/
└── SettingsGui/
```

Every GUI element exists and is scriptable via Cursor.

---

## 1. MAIN MENU GUI

**Purpose:** Entry point when players join. Leads them to species selection or character creator presets.

### 📁 Folder Structure

```
StarterGui/
   MainMenuGui/
      MainMenuScreenGui
      └── Frame_MainMenu
             ├── TitleLabel
             ├── PlayButton
             ├── CharacterCreatorButton
             ├── ClansButton
             ├── SettingsButton
             └── VersionLabel
      Scripts/
        └── MainMenu.client.lua
```

### Wireframe (ASCII mockup)

```
 -----------------------------------------------------
|                    COSMO CATS                      |
|               ★ Space Feline Adventure ★           |
|                                                     |
|                 [ PLAY ]                            |
|        [ CHARACTER CREATOR ]                        |
|                [ CLANS ]                             |
|               [ SETTINGS ]                           |
|                                                     |
|                              v1.0.0                 |
 -----------------------------------------------------
```

### Behavior Specs

- **Clicking PLAY** → open Species Selector
- **Clicking CHARACTER CREATOR** → open saved presets (future)
- **Clicking CLANS** → open Clan GUI
- **Clicking SETTINGS** → open Settings GUI

---

## 2. SPECIES SELECTOR GUI

**Purpose:** Let the player choose which cat species to spawn as.

### 📁 Folder Structure

```
StarterGui/
  SpeciesSelectorGui/
     SpeciesSelectorScreenGui
        └── Frame_SpeciesList
               ├── SpeciesButton_Template
               ├── ScrollList (UIListLayout)
               ├── ConfirmButton
               └── CloseButton
     Scripts/
        └── SpeciesSelector.client.lua
```

### Wireframe

```
 -----------------------------------------------------
|                  SELECT YOUR SPECIES               |
| --------------------------------------------------- |
| [Galaxy Kitten]     [Cosmo Shorthair]               |
| [Lunar Lynx]         (locked - cost: 250 Stardust)   |
| [Nebula Panther]     (locked - cost: 500)            |
| [Solar Tiger]        (premium)                       |
|                                                         |
|                    [ CONFIRM ]                        |
|                     [ CLOSE ]                         |
 ---------------------------------------------------------
```

### Icons/Images

Icons come from:
```
ReplicatedStorage/CosmoCatsModels/SPECIES_ID/icon.png
```

### Behavior

- **Click species** → highlight
- **If locked** → purchase popup (handled by Currency system)
- **Clicking CONFIRM** → calls:
  ```lua
  RequestSetSpecies:FireServer(selectedSpeciesId)
  ```

---

## 3. CHARACTER CREATOR GUI

**Purpose:** Apply colors, patterns, effects, and cosmetics.

### 📁 Folder Structure

```
StarterGui/
  CharacterCreatorGui/
     CharacterCreatorScreenGui
        ├── TabBar
        │     ├── Tab_Colors
        │     ├── Tab_Patterns
        │     ├── Tab_Accessories
        │     ├── Tab_Effects
        │     └── Tab_Info
        └── ContentFrame
             ├── Frame_Colors
             ├── Frame_Patterns
             ├── Frame_Accessories
             ├── Frame_Effects
             ├── Frame_Info
             └── PreviewViewportFrame
     Scripts/
        └── CharacterCreator.client.lua
```

### Wireframe

```
 ---------------------------------------------------------
|   COLORS | PATTERNS | ACCESSORIES | EFFECTS | INFO     |
| ------------------------------------------------------- |
|   • Primary Color Picker                                 |
|   • Secondary Color Picker                               |
|   • Detail Color Picker                                  |
|                                                         |
|                         [ 3D PREVIEW ]                   |
|                                                         |
|                 [ APPLY ]   [ CLOSE ]                    |
 -----------------------------------------------------------
```

### Behavior

- **Tabs toggle visibility**
- **Cursor writes color** → model preview using:
  ```lua
  CharacterCreator.ApplyAppearance(previewModel, tempData)
  ```
- **APPLY button** fires RemoteEvent to save:
  ```lua
  AppearanceUpdated:FireServer(appearanceData)
  ```

---

## 4. EMOTE BAR GUI

**Purpose:** Let players express themselves with animations.

### 📁 Folder Structure

```
StarterGui/
  EmoteBarGui/
     EmoteBarScreenGui
        └── Frame_EmoteButtons
              ├── EmoteButton_Template
              ├── Emote1
              ├── Emote2
              ├── Emote3
              ├── ...
              └── Emote9
     Scripts/
        └── EmoteBar.client.lua
```

### Wireframe

```
 -----------------------------------------------------------
| SIT | LAY | LOAF | GROOM | MEOW | TAIL | ROLL | STRETCH |
 -----------------------------------------------------------
```

### Behavior

Each button does:
```lua
EmoteController.PlayEmote("SIT")
```

**Number keys 1–9** map to the first 9 emotes.

---

## 5. STARDUST CURRENCY GUI

**Purpose:** Always visible Stardust counter (top right corner).

### 📁 Folder Structure

```
StarterGui/
   CurrencyGui/
     StardustGui
        └── Frame
             └── StardustLabel
     Scripts/
        └── Stardust.client.lua
```

### Wireframe

```
 ---------------------
| ★ Stardust: 312     |
 ---------------------
```

Star icon optional.

### Behavior

Uses:
- `CurrencyController.OnUpdated`
- `CurrencyController.RequestBalance()`

---

## 6. CLAN GUI

**Purpose:** Manage clan membership, roles, invites, home teleport, and clan settings.

### 📁 Folder Structure

```
StarterGui/
  ClanGui/
     ClanScreenGui
        ├── Frame_ClanHome
        │      ├── ClanNameLabel
        │      ├── MemberList (ScrollingFrame)
        │      ├── InviteButton
        │      ├── LeaveClanButton
        │      └── TeleportHomeButton
        │
        └── Frame_NoClan
               ├── CreateClanButton
               ├── JoinClanButton
               └── ClanInfoLabel
     Scripts/
        └── ClanGui.client.lua
```

### Wireframe

```
 -----------------------------------------------------------
| CLAN: STARFALL PRIDE                                      |
| --------------------------------------------------------- |
| MEMBERS                                                    |
|  - LunaLynx (Leader)                                       |
|  - NebulaPanther                                           |
|  - GalaxyKitty                                             |
|                                                           |
| [ INVITE ]    [ TELEPORT HOME ]    [ LEAVE CLAN ]          |
 -----------------------------------------------------------
```

### Behavior

- **CreateClanButton** → opens a small popup
- **Invite** → opens player list
- **Teleport Home** → remote call (server validates)

---

## 7. SETTINGS GUI (Optional but recommended)

### 📁 Folder Structure

```
StarterGui/
  SettingsGui/
     SettingsScreenGui
        ├── Toggle_Particles
        ├── Toggle_Nametags
        ├── Toggle_Music
        └── CloseButton
```

### Behavior

Toggles stored locally. Visual preferences applied client-side only.

---

## 9. CURSOR COMMAND TO AUTO-GENERATE GUIS

Paste this into Cursor if needed:

**"Create all GUI folders and ScreenGuis exactly as listed under the Cosmo Cats GUI Architecture, and populate each with empty Frames, TextLabels, Buttons, and templates to match the wireframes. Include placeholder scripts."**

Cursor will handle layout and object creation.

---

## Integration Hooks

### Species System
- Species Selector → `RequestSetSpecies` RemoteEvent
- Species icons from `CosmoCatsModels/[SPECIES_ID]/icon.png`

### Currency System
- Stardust GUI → `CurrencyController.OnUpdated`
- Purchase popups → `CurrencyController.RequestPurchase()`

### Character Creator
- Appearance updates → `AppearanceUpdated` RemoteEvent
- Preview → `CharacterCreator.ApplyAppearance()`

### Emote System
- Emote buttons → `EmoteController.PlayEmote()`
- Number keys 1-9 → Map to first 9 emotes

### Clan System
- Clan actions → Clan RemoteEvents
- Member list → Clan data from server

---

## Naming Conventions

- **ScreenGuis**: `[Name]ScreenGui`
- **Frames**: `Frame_[Purpose]`
- **Buttons**: `[Action]Button`
- **Labels**: `[Purpose]Label`
- **Templates**: `[Type]_Template`

---

## Required RemoteEvents

- `RequestSetSpecies` (Species)
- `AppearanceUpdated` (Character Creator)
- `CurrencyUpdated` (Currency)
- `RequestPurchaseUnlock` (Currency)
- Clan RemoteEvents (Clan system)

---

**Last Updated:** Complete GUI Architecture  
**Status:** Ready for Cursor generation ✅


