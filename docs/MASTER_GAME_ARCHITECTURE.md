# 🌌 Cosmo Cats — A–Z Master Game Architecture Document

**Version:** 1.0  
**Last Updated:** Complete Game Architecture  
**Status:** Master Design Document ✅

---

## 📋 Table of Contents

1. [High Concept Summary](#1-high-concept-summary)
2. [Core Pillars](#2-core-pillars)
3. [World Architecture (Map A–Z)](#3-world-architecture-map-a-z)
4. [Species System (Characters)](#4-species-system-characters)
5. [Customization System](#5-customization-system)
6. [Animation System](#6-animation-system)
7. [Interaction System (Social)](#7-interaction-system-social)
8. [NPC & Lore System](#8-npc--lore-system)
9. [Clan System](#9-clan-system)
10. [Progression System](#10-progression-system)
11. [Event System (Global)](#11-event-system-global)
12. [Monetization System (Ethical)](#12-monetization-system-ethical)
13. [Audio System](#13-audio-system)
14. [Visual Style](#14-visual-style)
15. [UI & UX](#15-ui--ux)
16. [Technical Architecture (Cursor-Friendly)](#16-technical-architecture-cursor-friendly)
17. [Data Design](#17-data-design)
18. [Development Roadmap](#18-development-roadmap)
19. [The Cosmo Cats Experience — Summary](#19-the-cosmo-cats-experience--summary)
20. [Document Index (All Detailed Bibles)](#20-document-index-all-detailed-bibles)

---

## ⭐ 1. HIGH CONCEPT SUMMARY

### 1.1 Game Identity

**GAME NAME:**
Cosmo Cats: Nebula Realms

**GENRE:**
Roleplay (RP) • Fantasy • Exploration • Social

**CORE PITCH:**
A beautiful, atmospheric, cosmic RP world where players become magical space cats, explore glowing biomes, unlock new species, interact socially, discover lore fragments, and experience stunning celestial events — all in a peaceful, welcoming universe.

**TARGET AUDIENCE:**
- Kids (8-12)
- Teens (13-17)
- RP players
- OC creators
- Screenshot fans
- Cozy gamers
- Lore lovers
- Creative communities

### 1.2 Core Experience

Players enter a mystical cosmic realm where they:
- **Become** magical space cats
- **Explore** six glowing biomes
- **Unlock** new species and cosmetics
- **Interact** socially with other players
- **Discover** lore fragments and stories
- **Experience** stunning celestial events
- **Join** clans and build communities
- **Express** themselves through customization

**All in a peaceful, welcoming universe.**

---

## ⭐ 2. CORE PILLARS

Cosmo Cats is built on **four foundational pillars**:

### 2.1 Identity
Players define who they are through:
- Species selection
- Colors and patterns
- Effects and auras
- Poses and animations
- Accessories and cosmetics

### 2.2 Expression
Players express themselves through:
- Emotes and animations
- Social interactions
- Accessories and effects
- Photos and screenshots
- Clan participation
- Custom appearances

### 2.3 Exploration
Players explore:
- Six glowing cosmic biomes
- Hidden secrets and lore
- Shrines and rituals
- NPCs and spirits
- Memory sequences
- Discovery quests

### 2.4 Awe & Atmosphere
Players experience:
- Global events
- Ambient music
- Floating spirits
- Celestial landmarks
- Beautiful visuals
- Mystical moments

**Everything — from visuals to NPCs — supports these pillars.**

---

## ⭐ 3. WORLD ARCHITECTURE (MAP A–Z)

The world consists of **six major biomes, two secret subzones, and a sky biome**.

### 3.1 Primary Biomes

**🌲 Nebula Forest (Starter)**
- Purple/blue fog
- Glowing plants
- Petals, floating particles
- RP-friendly landmarks (pond, log den)
- Beginner-friendly area

**🪨 Lunar Caverns**
- Blue crystals
- Reflective pools
- Resonant soundscape
- Hidden tunnels
- Memory reflections

**🏜️ Starfall Desert**
- Golden dunes
- Meteor craters
- Shooting stars
- Heat shimmer visuals
- Solar energy themes

**🌊 Comet Shores**
- Glowing tides
- Bioluminescent pools
- Floating rocks
- Comet fragments
- Tidal energy

**🛕 Void Temple (Prestige Area)**
- Ancient runes
- Purple fire
- Prestige shrines
- Ritual circles
- Void mysteries

**🛸 Outer Rim (Sky/Zero-G)**
- Floating islands
- Zero gravity
- Orbital platforms
- Skybox dominance
- Ascendant themes

### 3.2 Hidden Subzones

**❄️ Aurora Tundra**
- Northern lights
- Ice crystals
- Cold atmosphere
- Aurora spirits

**🌀 Rift Fragment Dimension**
- Dimensional rifts
- Reality distortion
- Secret area
- Rare access

### 3.3 World Map Structure

**Full ASCII world map and detailed biome documentation:**
- See `docs/WORLD_DESIGN.md` for complete map layout
- See `docs/biomes/*_VISUAL_REFERENCE.md` for each biome's visual guide
- See `docs/TRAVEL_NETWORK.md` for biome connections

---

## ⭐ 4. SPECIES SYSTEM (CHARACTERS)

Players select from a growing roster of cats, sorted into categories:

### 4.1 Species Categories

**A. Natural Cosmic Cats**
- Galaxy Kitten (Starter)
- Astro Cat (Starter)
- Cosmo Shorthair (Starter)
- Nebula Tabby (Unlockable)

**B. Elemental Space Cats**
- Lunar Lynx (Unlockable)
- Solar Tiger (Premium)
- Starfall Panther (Unlockable)
- Comet Coon (Unlockable)

**C. Arcane / Void Cats**
- Void Sentinel (Premium)
- Rift Walker (Premium)
- Shadow Nebula (Unlockable)

**D. Ascendant / Prestige Cats**
- Celestial Oracle (Prestige)
- Cosmic Guardian (Prestige)
- Dream Leviathan (Ultimate Prestige)

### 4.2 Species Features

Each species has:
- **Base colors** - Unique color palette
- **Glow pattern** - Species-specific glow
- **Species animations** - Unique idle variations
- **Unique idle variations** - Multiple poses
- **Lore origin** - Connected to specific biomes

### 4.3 Species System Details

**Full documentation:**
- See `docs/pipeline/CHARACTER_PIPELINE.md` for species creation pipeline
- See `studio-project/src/ReplicatedStorage/Modules/Species/` for implementation

---

## ⭐ 5. CUSTOMIZATION SYSTEM

Full character creator includes:

### 5.1 Customization Options

**Body Colors:**
- Primary color (hue, saturation, brightness)
- Secondary color
- Underbelly color
- Detail color

**Patterns:**
- Pattern overlays
- Pattern opacity
- Pattern blending
- Multiple layers (with Creator Kit Pass)

**Glow:**
- Glow intensity
- Glow color
- Glow pattern

**Eyes:**
- Eye shape
- Eye color
- Eye glow

**Accessories:**
- Collars
- Crystals
- Halos
- Necklaces
- Ear crystals
- Tail rings
- Wings (cosmetic)

**Effects:**
- Auras
- Trails
- Orbiting particles
- Particle effects

**Advanced (with Game Passes):**
- Tail shape (if modular)
- Ear type (optional future update)
- Unlimited color picker
- Advanced pattern blending

### 5.2 Preset System

Players can save presets:
- **Free players:** 3 presets
- **Cosmic Wardrobe Pass:** Unlimited presets
- Quick outfit switching
- Shareable outfit codes

---

## ⭐ 6. ANIMATION SYSTEM

All cats share the **Core Animation Set**:

### 6.1 Core Animations

**Basic:**
- Idle (multiple variants)
- Walk
- Run
- Sit
- Lay
- Loaf

**Social:**
- Groom
- Stretch
- Roll
- Meow
- Tail Flick

**Advanced:**
- Pounce
- Sleep Curl
- Hover (Outer Rim)
- Zero-G Walk (Outer Rim)
- Teleport animation
- Shrine meditation pose

**Premium:**
- Species-specific premium animations
- Premium emote animations
- Guardian animations

### 6.2 Animation Style

Animations are:
- **Soft** - Gentle, smooth
- **Elegant** - Graceful movements
- **Floaty** - Ethereal, weightless
- **Cosmic** - Fits space theme

### 6.3 Animation Documentation

**Full documentation:**
- See `docs/ANIMATION_BIBLE.md` for complete animation specifications
- See `docs/ASSET_STYLE_GUIDE.md` for animation style guidelines

---

## ⭐ 7. INTERACTION SYSTEM (SOCIAL)

Cosmo Cats prioritizes **social RP depth**:

### 7.1 Self Interactions (Emote Wheel)

**Basic Emotes:**
- Sit
- Lay
- Loaf
- Groom
- Roll
- Stretch
- Pounce
- Hover
- Meow
- Tail Flick

**Premium Emotes (with Astral Emote Wheel Pass):**
- Elegant bow
- Magical spin
- Astral meditation
- Cosmic float pose
- Guardian stance
- Void ritual
- Solar salute
- Lunar dance

### 7.2 Player ↔ Player Interactions

**Physical:**
- Nuzzle
- Cuddle
- Carry
- Back Ride (optional)
- Follow

**Group:**
- Group Sit
- Huddle
- Line Formation (if clan-linked)
- Clan formations

### 7.3 Player ↔ Environment

**Places:**
- Beds
- Dens
- Perches
- Shrines
- Ritual areas

**Objects:**
- Crystal/highlight interactions
- Secret passages
- Lore fragments
- Memory sequences

### 7.4 Biome Energy Interactions

**Special Interactions:**
- Nebula Blessing (Forest)
- Lunar Reflection (Caverns)
- Starfall Empowerment (Desert)
- Void Ritual (Temple)
- Orbital Levitation (Outer Rim)

### 7.5 Interaction Documentation

**Full documentation:**
- See `docs/INTERACTION_SYSTEMS_BIBLE.md` for complete interaction system

---

## ⭐ 8. NPC & LORE SYSTEM

### 8.1 NPC Types

**Wandering Spirits:**
- Guides and wisps
- Friendly ghost-like beings
- Give small rewards
- Whisper hints

**Ancient Guardians:**
- Rare, majestic lore givers
- Moon Lynx, Solar Tiger, Dream Leviathan, Void Sentinel
- Major lore revelations
- Spectacular appearances

**Lore NPCs:**
- Stationary storytellers
- Provide world-building
- Give lore fragments
- Environmental guides

**Collectible Spirits:**
- Pet companions
- Following spirits
- Cosmetic only
- Beautiful additions

### 8.2 Lore System

**Lore Components:**
- Lore fragments (collectible)
- Shrine memory sequences
- Guardian appearances
- Environmental storytelling
- Poetic, minimalist dialogue

**Core Lore Theme:**
The universe fractured into six cosmic energies. Cats are the living echoes of celestial beings.

### 8.3 NPC & Lore Documentation

**Full documentation:**
- See `docs/NPCS_WORLD_LORE_SPIRITS_BIBLE.md` for complete NPC and lore system

---

## ⭐ 9. CLAN SYSTEM

### 9.1 Clan Features

**Creation:**
- Create clan (Lv20+ & 500 Stardust)
- Clan names, colors, symbols
- Clan halls in territories

**Progression:**
- Clan XP → Clan Levels (1–20)
- Clan rituals (Temple, Tundra, Outer Rim)
- Clan achievements

**Social:**
- Clan emotes, poses, auras
- Clan feed & chat
- Clan customization
- Clan territories

### 9.2 Clan Roles

**Hierarchy:**
- Leader
- Officers
- Members
- Initiates

### 9.3 Clan Documentation

**Full documentation:**
- See `docs/CLANS_SOCIAL_SYSTEM_BIBLE.md` for complete clan system

---

## ⭐ 10. PROGRESSION SYSTEM

### 10.1 Currencies

**XP:**
- Earned through gameplay
- Levels up player
- Unlocks content

**Stardust (Soft Currency):**
- Earned over time
- Purchases cosmetics
- Can be bought (optional)

**Prestige Points (Rare, Long-Term):**
- Earned through rare events
- Prestige progression
- Ultimate unlocks

### 10.2 Leveling

**Level System:**
- Lv 1 → 100
- Titles: "Starlit Rookie" up to "Eternal Cosmo Cat"
- XP from all activities

**Rewards:**
- Species unlocks
- Effects
- Patterns
- Accessories
- Beds
- Titles
- Lore pages

### 10.3 Quests

**Quest Types:**
- Daily quests
- Weekly quests
- Discovery-based quests
- Lore quests

### 10.4 Prestige System

**Prestige Levels:**
- Prestige 1 → 10
- Unlocks prestige cats & effects
- Ultimate progression

### 10.5 Progression Documentation

**Full documentation:**
- See `docs/PROGRESSION_SYSTEM_BIBLE.md` for complete progression system

---

## ⭐ 11. EVENT SYSTEM (GLOBAL)

### 11.1 Tiered Event Structure

**Tier 1 (Frequent):**
- Nebula Bloom
- Crystal Resonance
- Dune Whispers
- Tidal Chorus
- Every 10-30 minutes

**Tier 2 (Rare Daily):**
- Starfall
- Aurora Dance
- Nebula Drift
- Crystal Storm
- 1-3 per day

**Tier 3 (Big Server Events):**
- Lunar Convergence
- Void Eclipse
- Orbital Alignment
- Every 2-4 hours

**Ultra-Rare:**
- Cosmic Bloom
- Solar Ascension
- Void Singularity
- 1-2 per day

### 11.2 Event Effects

Events include:
- Skybox changes
- VFX bursts
- Shrine activations
- Special NPC spawns
- Rewards (Stardust, XP, Prestige)

### 11.3 Event Documentation

**Full documentation:**
- See `docs/GLOBAL_EVENTS_SYSTEM_BIBLE.md` for complete event system

---

## ⭐ 12. MONETIZATION SYSTEM (ETHICAL)

All monetization is **cosmetic-only**:

### 12.1 Game Passes

**One-Time Upgrades:**
- Unlimited Color Picker (149 R$)
- Creator Kit (199 R$)
- Photo Mode (149 R$)
- Astral Emote Wheel (129 R$)
- Cosmic Wardrobe (249 R$)

### 12.2 Developer Products

**Repeatable Purchases:**
- Stardust Packs (15-399 R$)
- Event Passes (299 R$)
- Prestige Boost (49 R$) - chance increase only

### 12.3 Cosmetic Purchases

**Premium Content:**
- Premium species (199-399 R$)
- Effects / Auras (49-249 R$)
- Accessories (25-199 R$)
- Pattern packs (20-179 R$)
- Bed packs (49-199 R$)
- Pet companion spirits (149-299 R$)
- Name tag frames (49-99 R$)

### 12.4 Optional Subscription

**Cosmo Club (450 R$/month):**
- 600 Stardust per month
- One exclusive cosmetic monthly
- +1 pet companion slot
- Gold name tag border
- Exclusive monthly spirit companion
- Early access to new cosmetics

### 12.5 Monetization Documentation

**Full documentation:**
- See `docs/MONETIZATION_SYSTEM_BIBLE.md` for complete monetization system

---

## ⭐ 13. AUDIO SYSTEM

### 13.1 Sound Identity

**Core Sound Characteristics:**
- Soft pads
- Sparkles
- Ambient atmospheres
- Crystal chimes
- Cosmic wind
- Non-intrusive
- Cozy, celestial

### 13.2 Biome Ambience

Each biome has unique ambience:
- Nebula Forest: Gentle cosmic pads
- Lunar Caverns: Crystal resonance
- Starfall Desert: Warm desert chords
- Comet Shores: Tidal chimes
- Void Temple: Deep void echoes
- Outer Rim: Space ethereal

### 13.3 Event Audio

Events temporarily override ambience with:
- Event-specific music
- Sound effects
- Atmospheric shifts

### 13.4 Audio Documentation

**Full documentation:**
- See `docs/AUDIO_STYLE_GUIDE.md` for complete audio system

---

## ⭐ 14. VISUAL STYLE

### 14.1 Core Visual Principles

**From the Style Guide:**
- Soft gradients
- Glowing accents
- Bioluminescent effects
- Elegance & calm
- Cosmic palettes: purples, blues, pinks, golds
- Particle-based visual identity
- No realism, no grit

### 14.2 Visual Categories

**Species Visual Categories:**
- A: Natural Cosmic Cats
- B: Elemental Space Cats
- C: Arcane/Void Cats
- D: Astral Guardians/Prestige Cats

### 14.3 Visual Documentation

**Full documentation:**
- See `docs/ASSET_STYLE_GUIDE.md` for complete visual style guide
- See `docs/biomes/*_VISUAL_REFERENCE.md` for biome visuals

---

## ⭐ 15. UI & UX

### 15.1 UI Style

UI is:
- **Soft** - Rounded, gentle
- **Rounded** - Smooth edges
- **Glowing edges** - Cosmic theme
- **Particle overlays** - Atmospheric
- **Minimalistic** - Clean, serene
- **Mobile-friendly** - Responsive design

### 15.2 Major UI Panels

**Core UI:**
- Species Selector
- Customizer
- Emote Wheel
- RP Tools
- Inventory
- Clan Menu
- Shrine Lore Viewer
- Map
- Event Alerts

### 15.3 UI Documentation

**Full documentation:**
- See `studio-project/src/StarterGui/GUI_ARCHITECTURE.md` for complete UI system

---

## ⭐ 16. TECHNICAL ARCHITECTURE (CURSOR-FRIENDLY)

### 16.1 Main Folder Structure

**ReplicatedStorage:**
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
```

**ServerScriptService:**
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

**StarterPlayer:**
```
StarterPlayer/
    StarterPlayerScripts/
        InputController.lua
        EmoteController.lua
        InteractionController.lua
        UIController.lua
        CameraController.lua
        FXController.lua
```

### 16.2 Technical Documentation

**Implementation guides:**
- See `studio-project/README.md` for folder structure
- See `docs/GITHUB_STRUCTURE.md` for repository organization

---

## ⭐ 17. DATA DESIGN

### 17.1 PlayerData Structure

```lua
PlayerData = {
    Level = number,
    XP = number,
    Stardust = number,
    PrestigePoints = number,
    PrestigeLevel = number,
    UnlockedSpecies = {},
    UnlockedEffects = {},
    UnlockedBeds = {},
    UnlockedPatterns = {},
    UnlockedAccessories = {},
    Appearance = {
        Species = string,
        PrimaryColor = Color3,
        SecondaryColor = Color3,
        Pattern = string,
        GlowIntensity = number,
        Effects = {},
        Accessories = {},
    },
    Clan = {
        Id = string,
        Role = string,
    },
    Discoveries = {},
    Quests = {
        Daily = {},
        Weekly = {},
        Completed = {},
    },
    LoreFragments = {},
    SeenMemorySequences = {},
    Settings = {
        MusicVolume = number,
        SFXVolume = number,
        CameraSensitivity = number,
    },
}
```

### 17.2 Data Persistence

**DataStore System:**
- Automatic saving
- Retry logic
- Version control
- Error handling

**Full documentation:**
- See `studio-project/src/ServerStorage/BackendModules/SaveSystem.lua` for implementation

---

## ⭐ 18. DEVELOPMENT ROADMAP

### 18.1 Phase 1: Core Systems (Days 1–20)

**Foundation:**
- DataStore system
- Player data management
- Species system
- Currency system
- Basic UI

### 18.2 Phase 2: Content Production (Days 21–45)

**Content:**
- Biome creation
- NPC implementation
- Lore system
- Event system
- Clan system

### 18.3 Phase 3: Polish & Pre-Launch (Days 46–60)

**Polish:**
- Visual polish
- Audio integration
- Bug fixes
- Performance optimization
- Beta testing

### 18.4 Post-Launch

**Ongoing:**
- New species
- New biomes
- Seasonal events
- Community content
- Regular updates

---

## ⭐ 19. THE COSMO CATS EXPERIENCE — SUMMARY

Cosmo Cats is:

- **Beautiful** - Stunning visuals, atmospheric design
- **Mystical** - Cosmic themes, lore, spirits
- **Social** - RP-focused, clan system, interactions
- **Serene** - Peaceful, calming, no stress
- **Customizable** - Full character creator, cosmetics
- **Story-rich** - Lore fragments, NPCs, memory sequences
- **Event-driven** - Global events, community moments
- **Clan-supported** - Social groups, territories
- **Wonder-filled** - Awe-inspiring moments
- **Cosmetic-first** - Identity and expression
- **Ethical** - Fair monetization, free-friendly
- **Comforting** - Safe, welcoming space
- **Eternally expandable** - Growing content

---

## ⭐ 20. DOCUMENT INDEX (All Detailed Bibles)

This Master Document provides the high-level overview. For detailed implementation, see:

### 20.1 Core Systems

- **Character Pipeline**: `docs/pipeline/CHARACTER_PIPELINE.md`
- **Species System**: `studio-project/src/ReplicatedStorage/Modules/Species/`
- **Currency System**: `studio-project/src/ServerScriptService/CurrencyServer.lua`

### 20.2 World & Environment

- **World Design**: `docs/WORLD_DESIGN.md`
- **Biome Visual References**: `docs/biomes/*_VISUAL_REFERENCE.md`
- **Travel Network**: `docs/TRAVEL_NETWORK.md`
- **Biome Implementation**: `docs/CURSOR_BIOME_IMPLEMENTATION.md`

### 20.3 Systems Bibles

- **Interaction Systems**: `docs/INTERACTION_SYSTEMS_BIBLE.md`
- **Progression System**: `docs/PROGRESSION_SYSTEM_BIBLE.md`
- **Clans & Social System**: `docs/CLANS_SOCIAL_SYSTEM_BIBLE.md`
- **NPCs, World Lore & Spirits**: `docs/NPCS_WORLD_LORE_SPIRITS_BIBLE.md`
- **Global Events System**: `docs/GLOBAL_EVENTS_SYSTEM_BIBLE.md`
- **Monetization System**: `docs/MONETIZATION_SYSTEM_BIBLE.md`

### 20.4 Style Guides

- **Asset Style Guide**: `docs/ASSET_STYLE_GUIDE.md`
- **Audio Style Guide**: `docs/AUDIO_STYLE_GUIDE.md`
- **Animation Bible**: `docs/ANIMATION_BIBLE.md`

### 20.5 Technical Documentation

- **GitHub Structure**: `docs/GITHUB_STRUCTURE.md`
- **GUI Architecture**: `studio-project/src/StarterGui/GUI_ARCHITECTURE.md`
- **ReplicatedStorage Structure**: `src/ReplicatedStorage/README.md`

### 20.6 Implementation Guides

- **Getting Started**: `GETTING_STARTED.md`
- **Testing Guide**: `TESTING_GUIDE.md`
- **Debugging Guide**: `DEBUGGING_GUIDE.md`

---

## 🎯 Success Metrics

**Cosmo Cats is successful when:**
- Players feel a sense of wonder and belonging
- Free players have a complete, satisfying experience
- Paid players feel value in their purchases
- Community is active and positive
- Events create memorable moments
- Lore system engages players
- Clans foster social connections
- Monetization is ethical and sustainable
- Game grows through content updates
- Players return regularly

---

## 📚 Quick Reference

**For Developers:**
- Start with `GETTING_STARTED.md`
- Reference this Master Document for overview
- Use detailed Bibles for implementation
- Follow Technical Architecture for structure

**For Artists:**
- See `ASSET_STYLE_GUIDE.md` for visual guidelines
- See `AUDIO_STYLE_GUIDE.md` for sound guidelines
- See `ANIMATION_BIBLE.md` for animation specs
- See biome visual references for environment art

**For Designers:**
- See system Bibles for feature specifications
- See `MONETIZATION_SYSTEM_BIBLE.md` for monetization
- See `GUI_ARCHITECTURE.md` for UI design
- See this Master Document for overall vision

---

**Last Updated:** Master Game Architecture Document - Complete Edition  
**Version:** 1.0 - Final Complete Edition  
**Status:** Ready for Implementation ✅

**This GDD defines the entire Cosmo Cats experience, ready for Cursor, Claude Code Pro, Meshy, Blender (optional), and Roblox Studio implementation.**
