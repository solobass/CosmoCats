# 🌌 Cosmo Cats — Global Events System Bible

**Version:** 1.0  
**Last Updated:** Global Events System Design  
**Status:** Complete Design Document ✅

---

## 📋 Table of Contents

1. [What Are Global Events?](#1-what-are-global-events)
2. [Event Structure (Universal Template)](#2-event-structure-universal-template)
3. [Tier 1 Events (Frequent Local Events)](#3-tier-1-events-frequent-local-events)
4. [Tier 2 Events (Daily Rare Events)](#4-tier-2-events-daily-rare-events)
5. [Tier 3 Events (Server-Defining Events)](#5-tier-3-events-server-defining-events)
6. [Ultra-Rare Events (Legendary Server Moments)](#6-ultra-rare-events-legendary-server-moments)
7. [Server Announcements (Atmospheric, Minimal)](#7-server-announcements-atmospheric-minimal)
8. [VFX & Sound Required for Events](#8-vfx--sound-required-for-events)
9. [Event Rewards Summary](#9-event-rewards-summary)
10. [Cursor Implementation](#10-cursor-implementation)
11. [Design Principles](#11-design-principles)

---

## ⭐ 1. WHAT ARE GLOBAL EVENTS?

Global Events are worldwide, real-time phenomena that every player in the server experiences simultaneously.

They are:

- ✔ **Beautiful** - Visually stunning
- ✔ **Atmospheric** - Enhance world immersion
- ✔ **Non-combat** - Peaceful, no conflict
- ✔ **Non-disruptive** - Don't interrupt gameplay
- ✔ **Optional** - Players can ignore or participate
- ✔ **Rewarding** - Give meaningful rewards
- ✔ **Perfect for RP** - Create roleplay moments

Events should feel like:

**"The world is alive… and we're here to witness it."**

### 1.1 Event Purpose

Events create:

- **Community moments** - Shared experiences
- **Screenshots** - Beautiful, shareable moments
- **Shared awe** - Collective wonder
- **Social bonding** - Players gather together
- **Massive retention** - Reasons to return
- **Emotional magic** - Memorable experiences

### 1.2 Cosmo Cats Event Philosophy

Cosmo Cats is the **PERFECT** game for cosmic, environmental, mystical events.

The game's aesthetic naturally supports:
- Cosmic phenomena
- Environmental transformations
- Mystical occurrences
- Beautiful visual effects
- Atmospheric soundscapes

---

## ⭐ 2. EVENT STRUCTURE (Universal Template)

Every event has a consistent structure that Cursor can implement.

### 2.1 Universal Event Template

```lua
EventName = {
    Trigger = "ServerTime: Night",  -- When event occurs
    Duration = 120,                 -- How long (seconds)
    Frequency = "1/hour",           -- How often
    Visuals = {...},               -- Visual effects
    Sounds = {...},                -- Sound effects
    Rewards = {...},               -- What players get
    SpecialNPCs = {...},           -- NPCs that appear
    ShrineEffect = {...}            -- Shrine interactions
}
```

### 2.2 Event Components

**Trigger Type:**
- Server time (day/night)
- Player count threshold
- Random chance
- Player action (collecting items)
- Cooldown-based
- Combination of above

**Visual Transformation:**
- Skybox changes
- Fog color shifts
- Particle effects
- Lighting changes
- Biome transformations
- NPC appearances

**Soundscape Change:**
- Ambient music shift
- Sound effects
- Atmospheric audio
- Cosmic themes

**NPC Behavior Change:**
- Rare NPC spawns
- Guardian appearances
- Spirit behaviors
- Lore NPC interactions

**Special Interaction:**
- Shrine activations
- Hidden area reveals
- Collectible spawns
- Memory sequences

**Reward (Stardust / XP / Prestige):**
- Stardust amounts
- XP bonuses
- Prestige Points (rare)
- Titles (ultra-rare)
- Cosmetics (ultra-rare)

**Duration:**
- Short: 30-60 seconds
- Medium: 1-3 minutes
- Long: 3-5 minutes

**Cooldown:**
- Prevents event spam
- Ensures rarity
- Maintains special feeling

---

## ⭐ 3. TIER 1 EVENTS (Frequent Local Events)

Small, frequent, gentle environmental events.

**Occur every 10–30 minutes.**

### 3.1 🌿 Nebula Bloom (Forest)

**Trigger:** Anytime, 1–3x per hour

**Visual:**
- Floating petals throughout forest
- Soft purple fog intensifies
- Light rays intensify
- Trees glow softly

**Sound:**
- Shimmering bell pads
- Gentle cosmic chimes
- Soft ambient swell

**Effect:**
- Beds glow with nebula light
- Small Stardust drops appear (floating)
- Forest spirits become more active

**Reward:** +10 Stardust

**Duration:** 60 seconds

**Cooldown:** 10 minutes

### 3.2 💎 Crystal Resonance (Caverns)

**Trigger:** Player gathers 3 crystal fragments

**Visual:**
- All crystals pulse in unison
- Cavern sparkles with light
- Crystal beams cross paths
- Echoing light reflections

**Sound:**
- Echoing crystal chime
- Resonant tones
- Harmonic crystal sounds

**Effect:**
- Reveals one hidden tunnel temporarily
- Crystals drop small fragments
- Crystal minnows become active

**Reward:** 20 XP

**Duration:** 45 seconds

**Cooldown:** 5 minutes (per player trigger)

### 3.3 🌬️ Dune Whispers (Desert)

**Trigger:** Random, every 15-30 minutes

**Visual:**
- Soft golden wind particles
- Star particles drift
- Sand glows gently
- Heat shimmer effect

**Sound:**
- Warm desert chords
- Gentle wind sounds
- Distant starfall echoes

**Effect:**
- Meteor craters glow
- Small Stardust crystals appear
- Desert spirits become visible

**Reward:** 15 Stardust

**Duration:** 30 seconds

**Cooldown:** 15 minutes

### 3.4 🌊 Tidal Chorus (Shores)

**Trigger:** Time of day = morning (6:00-8:00 AM game time)

**Visual:**
- Bioluminescent waves
- Comet fragments glow
- Water sparkles
- Shore lights up

**Sound:**
- Gentle ocean hum
- Tidal chimes
- Water ethereal sounds

**Effect:**
- Comet fragments float to shore
- Water spirits appear
- Shore glows with bioluminescence

**Reward:** 10 XP

**Duration:** 40 seconds

**Cooldown:** 1 hour (morning only)

---

## ⭐ 4. TIER 2 EVENTS (Daily Rare Events)

These occur **1–3 times per day per server**.

They feel **special and magical**.

### 4.1 🌠 Starfall (Desert)

**Trigger:** 1/hour, night only (game time)

**Visual:**
- Shooting stars across sky
- Meteor glow trails
- Desert sky turns deep violet
- Meteor craters illuminate
- Star particles fall

**Sound:**
- Celestial streak sounds
- Distant meteor impacts
- Cosmic wind
- Starfall chimes

**Effect:**
- Meteor craters drop Stardust crystals
- Shrine activates (if in desert)
- Desert glows with star energy
- Players get temporary star aura

**Reward:**
- 50 Stardust
- 50 XP

**Duration:** 2 minutes

**Cooldown:** 1 hour

**NPC:**
- Solar Tiger Guardian may appear (10% chance)

### 4.2 ❄️ Aurora Dance (Tundra)

**Trigger:** Random, night only

**Visual:**
- Massive auroras across sky
- Green-blue-purple light waves
- Snow glows with aurora light
- Players glow with aurora energy

**Sound:**
- Cold, crystalline pads
- Ethereal aurora sounds
- Wind through ice
- Harmonic resonance

**Effect:**
- Aurora feathers appear (rare collectible)
- Body glows brighten
- Tundra spirits become active
- Hidden areas reveal

**Reward:**
- 20 Stardust
- 1 Prestige Point (5% chance)

**Duration:** 2–4 minutes

**Cooldown:** 2 hours

**NPC:**
- Aurora Spirit appears

### 4.3 🌌 Nebula Drift (Forest)

**Trigger:** Player count ≥ 7 in Forest

**Visual:**
- Entire forest fills with drifting nebula clouds
- Purple-blue fog intensifies
- Light rays pierce through
- Forest becomes ethereal

**Sound:**
- Gentle cosmic chorus
- Nebula hum
- Soft bell tones
- Atmospheric pads

**Effect:**
- Hidden NPC appears (Nebula Elder)
- Lore fragments spawn
- Forest spirits gather
- Beds glow intensely

**Reward:** 100 XP

**Duration:** 90 seconds

**Cooldown:** 30 minutes

### 4.4 🪨 Crystal Storm (Caverns)

**Trigger:** Random, every 2-3 hours

**Visual:**
- Crystals brighten dramatically
- Beams shoot from walls
- Light patterns dance
- Cavern becomes luminous

**Sound:**
- Resonant crystal ringing
- Harmonic chimes
- Echoing tones
- Crystal resonance

**Effect:**
- Opens secret chamber temporarily
- Crystal fragments spawn
- Crystal minnows become active
- Hidden paths reveal

**Reward:**
- 40 XP
- Lore fragment

**Duration:** 1 minute

**Cooldown:** 2 hours

---

## ⭐ 5. TIER 3 EVENTS (Server-Defining Events)

These are **big, beautiful events** that feel like festivals.

**Trigger once every 2–4 hours.**

### 5.1 🌕 Lunar Convergence (Temple → Caverns)

**Trigger:** Server clock, once per 2 hours

**Visual:**
- Moonlight streams fill the Temple
- Light spreads into Caverns
- Crystals reflect moonlight
- Temple glows with lunar energy
- Sky shows full moon

**Sound:**
- Deep, mystical hum
- Lunar resonance
- Crystal echoes
- Cosmic harmony

**Effect:**
- Shrine activates a memory sequence
- Temple and Caverns connect visually
- Lunar energy flows between biomes
- Players get lunar aura

**Reward:**
- 150 XP
- 50 Stardust

**Duration:** 3 minutes

**Cooldown:** 2 hours

**NPC:**
- Moon Lynx Guardian appears and speaks a single cryptic line

### 5.2 🔮 Void Eclipse (Temple)

**Trigger:** Rare (once every 3+ hours)

**Visual:**
- Sky darkens dramatically
- Temple runes ignite
- Void flames rise
- Purple-black energy swirls
- Reality distorts slightly

**Sound:**
- Lowered ambient hum
- Deep echo pulses
- Void resonance
- Mystical chants

**Effect:**
- Players float for 5 seconds
- Void energy flows through temple
- Shrine activates void ritual
- Players get void aura temporarily

**Reward:**
- 1 Prestige Point (20% chance)
- 200 XP

**Duration:** 2 minutes

**Cooldown:** 3 hours

**NPC:**
- Void Sentinel ascends from shrine

### 5.3 🌐 Orbital Alignment (Outer Rim)

**Trigger:** Rare (long cooldown, 4+ hours)

**Visual:**
- Floating islands align perfectly
- Rings rotate in sync
- Stars swirl in unison
- Cosmic patterns form
- Space becomes luminous

**Sound:**
- Cosmic choir swell
- Harmonic resonance
- Space ethereal sounds
- Ascendant tones

**Effect:**
- Zero gravity intensifies
- Players drift in orbit
- Cosmic energy flows
- All platforms align

**Reward:**
- 300 XP
- 100 Stardust
- 2 Prestige Points (guaranteed)

**Duration:** 3 minutes

**Cooldown:** 4 hours

**NPC:**
- Dream Leviathan circles the sky

---

## ⭐ 6. ULTRA-RARE EVENTS (Legendary Server Moments)

These are **extremely rare (1–2 per day)** and become social phenomena, generating screenshots, TikToks, YouTube posts, etc.

### 6.1 🌟 Cosmic Bloom (All Biomes)

**Trigger:** 0.5% per hour

**Visual:**
- Entire world briefly glows
- Petals & stars fall across all biomes
- Sky turns bright violet
- All biomes synchronize
- Cosmic energy flows everywhere

**Sound:**
- Massive but soft cosmic chord
- Harmonic resonance across world
- Cosmic choir
- Universal harmony

**Effect:**
- Lore fragments appear everywhere
- NPC spirits wander all biomes
- All shrines activate
- Players get cosmic aura
- World becomes magical

**Reward:**
- 2 Prestige Points
- 200 Stardust
- Unique title ("Cosmic Witness")

**Duration:** 2–5 minutes

**Cooldown:** 12 hours (server-wide)

**NPC:**
- All guardians may appear
- Spirits become active everywhere

### 6.2 ☀️ Solar Ascension (Desert)

**Trigger:** Daytime, very rare (0.3% per hour during day)

**Visual:**
- Huge solar flare beams
- Desert becomes glowing gold
- Sky fills with solar energy
- Heat waves intensify
- Everything glows golden

**Sound:**
- Warm, powerful choral swell
- Solar resonance
- Energy hum
- Ascendant tones

**Effect:**
- Solar Tiger Guardian roars
- All players get solar aura for 10 minutes
- Desert transforms
- Meteor craters glow intensely

**Reward:**
- 500 XP
- Lore fragment
- Solar aura effect (10 minutes)

**Duration:** 60 seconds (event), 10 minutes (aura)

**Cooldown:** 6 hours

**NPC:**
- Solar Tiger Guardian appears and performs

### 6.3 🌑 Void Singularity (Temple)

**Trigger:** Only if a player with max Prestige enters Temple

**Visual:**
- Central altar cracks open
- Purple-black vortex expands
- Reality distorts
- Void energy explodes
- Temple becomes void portal

**Sound:**
- Deep cosmic bass
- Void resonance
- Reality distortion sounds
- Mystical chants

**Effect:**
- All players briefly levitate
- A glitch aura appears on all cats
- Void energy flows
- Temple transforms

**Reward:**
- Exclusive Void Sigil effect
- 3 Prestige Points
- Void title

**Duration:** 45 seconds

**Cooldown:** 24 hours (server-wide)

**NPC:**
- Void Sentinel appears and performs ritual

---

## ⭐ 7. SERVER ANNOUNCEMENTS (Atmospheric, Minimal)

**No big UI banners.**

Just:

**Soft text at top center:**

- "The sky shifts… something stirs."
- "Nebula petals begin to fall…"
- "A guardian awakens in the Temple…"
- "The Outer Rim vibrates with cosmic energy…"
- "Crystals resonate in the depths…"
- "The desert remembers the stars…"
- "Tides bring cosmic whispers…"

**Announcement Rules:**
- **Poetic** - Beautiful, evocative
- **Minimal** - Short, one line
- **Atmospheric** - Fits cosmic theme
- **Non-intrusive** - Doesn't block view
- **Fade in/out** - Gentle appearance
- **No spam** - Only for significant events

**Events should inspire awe — not spam.**

### 7.1 Announcement Timing

**Tier 1 Events:**
- No announcement (too frequent)
- Visual/audio cues only

**Tier 2 Events:**
- Soft announcement
- Fade in/out over 3 seconds
- Stays for 5 seconds

**Tier 3 Events:**
- Clear announcement
- Fade in/out over 4 seconds
- Stays for 8 seconds

**Ultra-Rare Events:**
- Dramatic announcement
- Fade in/out over 5 seconds
- Stays for 10 seconds
- Slight glow effect

---

## ⭐ 8. VFX & SOUND REQUIRED FOR EVENTS

Each event needs comprehensive visual and audio transformation.

### 8.1 Visual Requirements

**Unique Skybox or Tint:**
- Skybox rotation
- Skybox color shifts
- Atmospheric tint
- Color correction

**Fog Color Change:**
- Fog color shifts
- Fog density changes
- Fog distance adjustments
- Biome-specific fog

**Particle Bursts:**
- Particle systems
- Emitters
- Trails
- Glows

**Area Glows:**
- Point lights
- Spot lights
- Ambient glow
- Bloom effects

**Lighting Intensities:**
- Brightness changes
- Ambient adjustments
- Outdoor ambient shifts
- Shadow adjustments

### 8.2 Sound Requirements

**Ambient Sound Shift:**
- Background music changes
- Ambient loops
- Atmospheric pads
- Environmental sounds

**Event-Specific Sounds:**
- Unique sound effects
- Cosmic themes
- Harmonic resonance
- Ethereal tones

**Volume Management:**
- Smooth transitions
- No sudden changes
- Layered audio
- 3D positioning

### 8.3 Cursor Implementation

Cursor can dynamically tween:

- **Fog** - Color, density, distance
- **OutdoorAmbient** - Brightness, color
- **Bloom/ColorCorrection** - Intensity, saturation
- **Skybox** - Rotation, color
- **Lighting** - Brightness, ambient
- **Particles** - Emission, size, color
- **Sounds** - Volume, pitch

**Tween Settings:**
- Duration: Match event duration
- Easing: Smooth, gentle curves
- Style: Quad, Sine, or Exponential
- Direction: InOut for smooth transitions

---

## ⭐ 9. EVENT REWARDS SUMMARY

### 9.1 XP Rewards

**Tier 1 Events:**
- 10-20 XP
- Small bonus
- Frequent rewards

**Tier 2 Events:**
- 40-100 XP
- Medium bonus
- Daily rewards

**Tier 3 Events:**
- 150-300 XP
- Large bonus
- Rare rewards

**Ultra-Rare Events:**
- 200-500 XP
- Massive bonus
- Legendary rewards

### 9.2 Stardust Rewards

**Tier 1 Events:**
- 10-15 Stardust
- Small amounts
- Frequent drops

**Tier 2 Events:**
- 20-50 Stardust
- Medium amounts
- Daily drops

**Tier 3 Events:**
- 50-100 Stardust
- Large amounts
- Rare drops

**Ultra-Rare Events:**
- 100-200 Stardust
- Massive amounts
- Legendary drops

### 9.3 Prestige Points

**Tier 1 Events:**
- None (too frequent)

**Tier 2 Events:**
- 1 Prestige Point (5-20% chance)
- Rare but possible

**Tier 3 Events:**
- 1-2 Prestige Points (guaranteed or high chance)
- Significant rewards

**Ultra-Rare Events:**
- 2-3 Prestige Points (guaranteed)
- Legendary rewards

### 9.4 Titles & Cosmetics

**Event-Based Titles:**
- "Cosmic Witness" - Cosmic Bloom
- "Aurora-Born" - Aurora Dance
- "Starfall Survivor" - Starfall
- "Void Touched" - Void Eclipse
- "Orbital Ascendant" - Orbital Alignment
- "Solar Blessed" - Solar Ascension
- "Void Singularity" - Void Singularity

**Event-Based Effects:**
- Solar aura (10 minutes)
- Void sigil (permanent)
- Cosmic glow (temporary)
- Lunar energy (temporary)
- Aurora feathers (collectible)

---

## ⭐ 10. CURSOR IMPLEMENTATION

### 10.1 Event Framework Structure

**ServerScriptService:**
```
ServerScriptService/
    EventManager.lua          -- Main event controller
    EventScheduler.lua        -- Event timing system
    EventRewards.lua          -- Reward distribution
```

**ReplicatedStorage:**
```
ReplicatedStorage/
    EventDefinitions/
        Starfall.lua          -- Starfall event config
        Aurora.lua            -- Aurora event config
        VoidEclipse.lua       -- Void Eclipse config
        NebulaBloom.lua       -- Nebula Bloom config
        CrystalResonance.lua -- Crystal Resonance config
        DuneWhispers.lua      -- Dune Whispers config
        TidalChorus.lua       -- Tidal Chorus config
        NebulaDrift.lua       -- Nebula Drift config
        CrystalStorm.lua      -- Crystal Storm config
        LunarConvergence.lua  -- Lunar Convergence config
        OrbitalAlignment.lua  -- Orbital Alignment config
        CosmicBloom.lua       -- Cosmic Bloom config
        SolarAscension.lua    -- Solar Ascension config
        VoidSingularity.lua  -- Void Singularity config
    EventRemotes/
        EventStarted          -- RemoteEvent
        EventEnded            -- RemoteEvent
        EventAnnouncement     -- RemoteEvent
```

**StarterPlayer/StarterPlayerScripts:**
```
StarterPlayer/
    StarterPlayerScripts/
        EventClient.lua       -- Client event handler
        EventVFX.lua           -- Visual effects
        EventSFX.lua           -- Sound effects
```

### 10.2 Event Flow

**1. EventManager picks eligible event:**
```lua
-- Check triggers
-- Check cooldowns
-- Check conditions
-- Select event
```

**2. Fires RemoteEvent to all clients:**
```lua
EventStarted:FireAllClients(eventName, eventData)
```

**3. Clients play VFX and SFX:**
```lua
-- Tween lighting
-- Spawn particles
-- Play sounds
-- Update skybox
```

**4. Server spawns NPCs:**
```lua
-- Check event NPC requirements
-- Spawn guardians/spirits
-- Set NPC behaviors
```

**5. Server gives rewards:**
```lua
-- Calculate rewards
-- Distribute to players
-- Save to DataStore
```

**6. Cleanup after duration:**
```lua
-- End event
-- Clean up NPCs
-- Reset environment
-- Fire EventEnded
```

### 10.3 Event Definition Example

```lua
-- Starfall.lua
local Starfall = {
    Name = "Starfall",
    Tier = 2,
    Trigger = {
        Type = "TimeBased",
        Condition = "Night",
        Frequency = "1/hour",
        Cooldown = 3600, -- 1 hour
    },
    Duration = 120, -- 2 minutes
    Visuals = {
        Skybox = "DeepViolet",
        FogColor = Color3.fromRGB(50, 20, 80),
        Particles = "ShootingStars",
        Lighting = {
            Brightness = 0.8,
            Ambient = Color3.fromRGB(100, 80, 120),
        },
    },
    Sounds = {
        Ambient = "StarfallAmbient",
        Effects = {"CelestialStreak", "MeteorImpact"},
    },
    Rewards = {
        Stardust = 50,
        XP = 50,
        PrestigeChance = 0,
    },
    SpecialNPCs = {
        SolarTiger = {
            SpawnChance = 0.1,
            Location = "Desert",
        },
    },
    ShrineEffect = {
        Activate = true,
        Biome = "Desert",
    },
}
return Starfall
```

### 10.4 EventManager Structure

```lua
-- EventManager.lua
local EventManager = {}

local activeEvents = {}
local eventCooldowns = {}

function EventManager.StartEvent(eventName)
    -- Load event definition
    -- Check conditions
    -- Fire to clients
    -- Spawn NPCs
    -- Start rewards
    -- Schedule cleanup
end

function EventManager.EndEvent(eventName)
    -- Clean up
    -- Reset environment
    -- Fire EventEnded
    -- Update cooldowns
end

function EventManager.CheckTriggers()
    -- Check all event triggers
    -- Select eligible events
    -- Start if conditions met
end

return EventManager
```

---

## ⭐ 11. DESIGN PRINCIPLES

### 11.1 Core Principles

All events must be:

- ✔ **Beautiful** - Visually stunning
- ✔ **Non-disruptive** - Don't interrupt gameplay
- ✔ **Optional** - Players can ignore
- ✔ **Good for screenshots** - Shareable moments
- ✔ **Memorable** - Create lasting impressions
- ✔ **Fitting the cosmic aesthetic** - Match game theme

### 11.2 What Events Should NOT Be

**No chaos:**
- Events should be organized
- Predictable patterns
- Smooth transitions

**No combat:**
- Peaceful only
- No enemies
- No danger

**No stress:**
- Relaxing experiences
- No time pressure
- No failure states

### 11.3 Cosmo Cats Event Philosophy

**Cosmo Cats is a calm cosmic experience.**

Events should:
- Enhance the peaceful atmosphere
- Create wonder and awe
- Bring players together
- Generate beautiful moments
- Support roleplay
- Reward exploration
- Maintain the cosmic aesthetic

### 11.4 Event Frequency Balance

**Too Frequent:**
- Events lose special feeling
- Become background noise
- Overwhelm players

**Too Rare:**
- Players miss events
- Feel unlucky
- Don't experience content

**Perfect Balance:**
- Tier 1: Every 10-30 minutes (gentle)
- Tier 2: 1-3 per day (special)
- Tier 3: Every 2-4 hours (festival)
- Ultra-Rare: 1-2 per day (legendary)

### 11.5 Event Quality Checklist

Before implementing an event, ensure:

- [ ] Visually beautiful
- [ ] Fits cosmic aesthetic
- [ ] Non-disruptive
- [ ] Appropriate rewards
- [ ] Clear trigger conditions
- [ ] Proper cooldown
- [ ] Sound design complete
- [ ] VFX polished
- [ ] NPC interactions (if applicable)
- [ ] Shrine effects (if applicable)
- [ ] Server announcement (if tier 2+)
- [ ] Performance optimized

---

## 🎯 Success Metrics

**Global Events System is successful when:**
- 80%+ of players witness at least one event per session
- 50%+ of players participate in events
- Events generate screenshots/social media posts
- Players return to experience rare events
- Events create memorable community moments
- Event frequency feels balanced (not too rare, not too common)
- Events enhance rather than disrupt gameplay

---

## 📚 Related Documentation

- **World Design**: `docs/WORLD_DESIGN.md`
- **NPCs, World Lore & Spirits System**: `docs/NPCS_WORLD_LORE_SPIRITS_BIBLE.md`
- **Biome Visual References**: `docs/biomes/*_VISUAL_REFERENCE.md`
- **Interaction Systems Bible**: `docs/INTERACTION_SYSTEMS_BIBLE.md`
- **Progression System Bible**: `docs/PROGRESSION_SYSTEM_BIBLE.md`

---

**Last Updated:** Global Events System Bible - Complete Edition  
**Version:** 1.0 - Final Complete Edition  
**Status:** Ready for Implementation ✅
