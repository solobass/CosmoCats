# 🌌 Cosmo Cats — Complete Progression System Bible

**Version:** 1.0  
**Last Updated:** Progression System Design  
**Status:** Complete Design Document ✅

---

## 📋 Table of Contents

1. [Goals of the Progression System](#1-goals-of-the-progression-system)
2. [The Three Currencies & Progression Types](#2-the-three-currencies--progression-types)
3. [Player Level System (Cosmic Leveling)](#3-player-level-system-cosmic-leveling)
4. [How XP is Earned](#4-how-xp-is-earned)
5. [Stardust Economy (Soft Currency)](#5-stardust-economy-soft-currency)
6. [Prestige Points (Hard Currency)](#6-prestige-points-hard-currency)
7. [Unlock System Breakdown](#7-unlock-system-breakdown)
8. [Quests (Daily + Weekly + Discovery)](#8-quests-daily--weekly--discovery)
9. [Prestige System Reward Tiers](#9-prestige-system-reward-tiers)
10. [Clan Progression (Light Social RPG)](#10-clan-progression-light-social-rpg)
11. [DataStore Structure (Cursor Implementation)](#11-datastore-structure-cursor-implementation)
12. [Progression Loop Diagram](#12-progression-loop-diagram)
13. [Retention Mechanics](#13-retention-mechanics)
14. [Player XP Boost (Fair, Non-P2W)](#14-player-xp-boost-fair-non-p2w)
15. [Progression Feel Checklist](#15-progression-feel-checklist)

---

## ⭐ 1. GOALS OF THE PROGRESSION SYSTEM

Cosmo Cats is an **RP-first game**.

So progression must feel:

- ✔ **Fun** - Engaging and enjoyable
- ✔ **Expressive** - Rewards creativity and identity
- ✔ **Cosmic** - Themed around space and magic
- ✔ **Non-grindy** - No repetitive farming
- ✔ **Non-P2W** - Fair for all players
- ✔ **Story-driven** - Feels like a journey, not a checklist

**Core Philosophy:**
Progression must reward **identity and creativity**, not combat or grinding.

**Key Principle:**
Short-term rewards + long-term goals = sustained engagement without burnout.

---

## ⭐ 2. THE THREE CURRENCIES & PROGRESSION TYPES

Cosmo Cats uses three progression units:

### 2.1 XP (Experience Levels)

**Represents:** Your "Cosmic Growth"

**Earned from:**
- Playing naturally
- Interacting with players
- Exploring the world
- Completing quests

**Purpose:**
- Level up (1-100)
- Unlock level-based titles
- Access prestige system
- Show progression status

### 2.2 Stardust (Soft Currency)

**Represents:** Cosmic energy for customization

**Used to unlock:**
- Species (common, rare, elemental)
- Effects (auras, trails, glows)
- Beds (various types)
- Accessories (collars, crystals, etc.)
- Patterns (fur patterns)
- Color palettes
- Emotes (additional emotes)

**Earned from:**
- Passive gameplay
- Daily activities
- Quests
- Environmental interactions

### 2.3 Prestige Points (Hard Currency)

**Represents:** Long-term achievement and mastery

**Used for:**
- Prestige species (legendary cats)
- Temple unlocks
- Void / Solar cats
- Legendary effects
- Cosmetic halos / sigils
- Exclusive animations

**Important:** Prestige Points are **NOT monetized**. They're earned through:
- Discoveries
- Rituals
- World events
- Level milestones
- Long-term achievements

---

## ⭐ 3. PLAYER LEVEL SYSTEM (Cosmic Leveling)

### 3.1 Level Range

Players progress through:

**Level 1 → Level 100**

This is a long-term progression. Level 100 is a satisfying cap that represents true mastery.

**Leveling Curve:**
- **Levels 1-20**: Fast progression (new player experience)
- **Levels 21-50**: Steady progression (engagement phase)
- **Levels 51-80**: Slower progression (commitment phase)
- **Levels 81-100**: Slow progression (mastery phase)

### 3.2 Level Titles

Each level group has a cosmic title that appears under the player's nametag:

| Level Range | Title             | Description                    |
|-------------|-------------------|--------------------------------|
| 1–5         | Starlit Rookie    | New to the cosmos              |
| 6–10        | Nebula Kitten     | Learning the ways              |
| 11–20       | Ascending Cat     | Rising through the stars       |
| 21–40       | Cosmic Wanderer   | Exploring the universe         |
| 41–60       | Celestial Feline  | Master of the cosmos           |
| 61–80       | Stellar Mystic    | Keeper of cosmic secrets       |
| 81–95       | Astral Guardian   | Protector of the void          |
| 96–100      | Eternal Cosmo Cat | Legendary cosmic being         |

**Title Display:**
- Appears under player name tag
- Color-coded by tier (soft glow effect)
- Can be toggled on/off in settings

### 3.3 Level Rewards

**Milestone Rewards:**
- **Level 10**: Unlock first rare species discount
- **Level 25**: Unlock first elemental species discount
- **Level 50**: Unlock prestige quest access
- **Level 75**: Unlock temple rituals
- **Level 100**: Unlock prestige system

**Reward Structure:**
- Every 5 levels: Small Stardust bonus (50-100)
- Every 10 levels: Medium Stardust bonus (200-300)
- Every 25 levels: Large Stardust bonus (500-750)
- Every 50 levels: Prestige Point (1-2)

---

## ⭐ 4. HOW XP IS EARNED

XP must feel **passive and satisfying**, not grindy.

### 4.1 XP Sources

| Action                                        | XP         | Cooldown/Notes                    |
|-----------------------------------------------|------------|-----------------------------------|
| Walking around (per minute)                   | 3–6 XP     | Passive, anti-AFK (movement req)  |
| Using emotes (cooldown)                       | 5 XP       | 30-second cooldown per emote      |
| Interacting with players                      | 10–30 XP   | Nuzzle, cuddle, group sit         |
| Using beds                                    | 10 XP      | Per bed use, 5-minute cooldown    |
| Exploring new biomes                          | 100 XP     | One-time per biome                |
| Discovering secrets                           | 200 XP     | One-time per secret               |
| Completing daily quests                       | 300–500 XP | Per quest completion              |
| Prestige rituals                              | 500 XP     | Void Temple rituals               |
| Attending group gatherings                    | 100 XP     | Temple/Outer Rim events           |
| Daily login                                   | 50 XP      | First login of the day            |
| Weekly quest completion                       | 400–600 XP | Per weekly quest                  |

### 4.2 Anti-AFK System

**AFK Detection:**
- No movement for 2+ minutes = AFK
- AFK players earn only **20% XP**
- Movement required for full XP rewards

**Movement Detection:**
- HumanoidRootPart velocity > 0.5 studs/second
- Character position changes
- Emote usage counts as activity

### 4.3 XP Boost System

**XP Boosts:**
- **Daily Login Streak**: +10% XP per day (max +50%)
- **XP Boost Tokens**: +20% XP for 24 hours
- **Event Bonuses**: Temporary +30-50% XP during events

**Boost Stacking:**
- Maximum boost: +100% XP (2x)
- Boosts are additive, not multiplicative
- Visual indicator shows active boosts

---

## ⭐ 5. STARDUST ECONOMY (Soft Currency)

Stardust is the core currency for customization.

### 5.1 How to Earn Stardust

| Action                                 | Stardust             | Notes                              |
|----------------------------------------|----------------------|------------------------------------|
| Walking (per interval)                 | +1 every 90 seconds  | Anti-AFK (movement required)       |
| Using emotes                           | +1 per cooldown      | 30-second cooldown                 |
| Environmental interactions             | +3–10                | Crystal nodes, flowers, etc.        |
| Discoveries                            | +30                  | One-time per discovery             |
| Daily quests                           | +40–80               | Per quest completion               |
| Weekly quests                          | +150                 | Per weekly quest                   |
| Events (meteor showers, aurora nights) | +100–300             | Seasonal/rare events               |
| Daily login rewards                    | +20–200              | Streak-based rewards               |
| Level milestones                       | +50–750              | Every 5/10/25/50 levels            |

### 5.2 Stardust Pricing

**Species:**
- **Common**: 200–500 Stardust
  - Examples: Galaxy Kitten, Astro Cat, Cosmo Shorthair
- **Rare**: 700–1500 Stardust
  - Examples: Lunar Lynx, Comet Coon, Nebula Panther
- **Elemental**: 2000–2500 Stardust
  - Examples: Solar Tiger, Starfall Panther, Aurora Coon

**Effects:**
- **Simple Glows**: 200–500 Stardust
  - Basic particle effects, simple auras
- **Trails**: 800–1500 Stardust
  - Star trails, comet trails, nebula trails
- **Auras**: 1500–2500 Stardust
  - Complex auras, halo effects, sigils

**Beds:**
- **Blanket**: Free (starter)
- **Box**: 100 Stardust
- **Moon Rock Bed**: 300 Stardust
- **Nebula Hammock**: 400 Stardust
- **Star Cradle**: Prestige Points only

**Accessories:**
- **Basic**: 50–200 Stardust
  - Simple collars, basic crystals
- **Rare**: 300–500 Stardust
  - Nebula scarves, floating rings, ear crystals

**Patterns:**
- **Common Patterns**: 50–150 Stardust
- **Rare Patterns**: 200–300 Stardust

**Note:**
Nothing is overpriced — RP players are children & teens. We must keep the economy friendly and accessible.

### 5.3 Stardust Earning Balance

**Daily Earning Potential:**
- **Passive (walking)**: ~100-200 Stardust/hour (with movement)
- **Active (interactions)**: ~50-100 Stardust/hour
- **Quests**: ~120-240 Stardust/day (3 daily quests)
- **Total Daily**: ~500-800 Stardust for active players

**Unlock Timeline:**
- **Common Species**: 1-2 days of play
- **Rare Species**: 3-5 days of play
- **Elemental Species**: 7-10 days of play
- **Effects**: 1-3 days per effect
- **Beds**: 1-2 days per bed

---

## ⭐ 6. PRESTIGE POINTS (Hard Currency)

Prestige = **LONG-TERM PROGRESSION**.

### 6.1 How to Earn Prestige Points

| Action                             | Prestige Points | Notes                          |
|------------------------------------|-----------------|--------------------------------|
| Completing level milestones        | 1–5             | Every 25 levels (1), 50 (2), 100 (5) |
| Discovering all secrets in a biome | 10              | One-time per biome             |
| Participating in temple rituals    | 5               | Void Temple rituals            |
| Outer Rim orbit event              | 10              | Special events                 |
| Seasonal events (rare)             | 10–30           | Limited-time events            |
| Prestiging (Level 100 → 1)         | 5–10            | Per prestige level             |
| Completing prestige quests         | 2–5             | Special long-term quests       |

**Prestige Points are VERY rare** — that's the point. They represent true dedication and mastery.

### 6.2 Prestige Point Pricing

**Prestige Species:**
- **Void Sentinel**: 15 Prestige Points
- **Celestial Oracle Cat**: 20 Prestige Points
- **Black Hole Cat**: 25 Prestige Points
- **Solar Eclipse Cat**: 30 Prestige Points
- **Cosmic Guardian**: 40 Prestige Points

**Prestige Effects:**
- **Celestial Halo**: 5 Prestige Points
- **Void Markings**: 8 Prestige Points
- **Floating Sigils**: 10 Prestige Points
- **Black Hole Abilities**: 15 Prestige Points

**Prestige Beds:**
- **Star Cradle**: 10 Prestige Points

**Prestige Accessories:**
- **Cosmic Crown**: 5 Prestige Points
- **Astral Wings**: 12 Prestige Points

### 6.3 Prestige Point Earning Timeline

**Realistic Timeline:**
- **First Prestige Point**: ~2-3 weeks of play (level 25 milestone)
- **10 Prestige Points**: ~2-3 months (discoveries + milestones)
- **40 Prestige Points**: ~6-12 months (full prestige species)

This ensures prestige items feel truly special and rare.

---

## ⭐ 7. UNLOCK SYSTEM BREAKDOWN

### 7.1 Species Unlocks

Each species belongs to a rarity class:

| Rarity    | Cost                  | Examples                            | Unlock Animation        |
|-----------|-----------------------|-------------------------------------|------------------------|
| Common    | 200–400 Stardust      | Galaxy Kitten, Astro Cat            | Cosmic burst + bell    |
| Rare      | 700–1500 Stardust     | Lunar Lynx, Comet Coon              | Enhanced burst + chime |
| Elemental | 2000–2500 Stardust    | Solar Tiger, Starfall Panther       | Epic burst + fanfare   |
| Prestige  | 10–40 Prestige Points | Void Sentinel, Celestial Oracle Cat | Legendary burst + epic sound |

**Unlock Display:**
- Cosmic burst animation
- Bell chime sound
- UI notification
- Species preview
- "Unlocked!" celebration

### 7.2 Effects Unlocks

**Effect Categories:**

**Auras:**
- Nebula Aura (500 Stardust)
- Solar Aura (800 Stardust)
- Void Aura (1500 Stardust)
- Celestial Halo (5 Prestige Points)

**Trails:**
- Star Trail (800 Stardust)
- Comet Trail (1200 Stardust)
- Nebula Trail (1500 Stardust)

**Glows:**
- Eye Glow (300 Stardust)
- Tail Glow (400 Stardust)
- Full Body Glow (1000 Stardust)

**Sigils:**
- Floating Sigils (10 Prestige Points)
- Void Markings (8 Prestige Points)

**Pricing:** 200–2500 Stardust (common), 1–10 Prestige Points (prestige)

### 7.3 Accessories Unlocks

**Categories:**

**Collars:**
- Star Collar (100 Stardust)
- Nebula Collar (200 Stardust)
- Cosmic Collar (400 Stardust)

**Ear Crystals:**
- Basic Crystals (150 Stardust)
- Glowing Crystals (300 Stardust)
- Prestige Crystals (5 Prestige Points)

**Necklaces:**
- Comet Necklace (200 Stardust)
- Star Necklace (350 Stardust)

**Floating Rings:**
- Orbital Rings (500 Stardust)
- Cosmic Rings (8 Prestige Points)

**Nebula Scarves:**
- Basic Scarf (250 Stardust)
- Glowing Scarf (450 Stardust)

**Special:**
- Cosmic "Baby Carrier" (cosmic equivalent of Feather Family carriers) (800 Stardust)

### 7.4 Beds Unlocks

Beds upgrade visually and functionally:

| Bed            | Cost              | Benefit                    | Visual Upgrade          |
|----------------|-------------------|----------------------------|------------------------|
| Blanket        | Free (starter)    | Basic sleep pose           | Simple blanket         |
| Box            | 100 Stardust      | Cute "box pose"            | Cardboard box          |
| Moon Rock Bed  | 300 Stardust      | Glowing pillow effect      | Glowing moon rock      |
| Nebula Hammock | 400 Stardust      | Floating hammock           | Nebula fabric          |
| Star Cradle    | 10 Prestige Points | Animated star halo         | Prestige star cradle   |

**Bed Benefits:**
- Different sleep animations
- Unique VFX
- Comfort bonuses (slight XP boost while resting)
- RP value (better screenshots)

### 7.5 Pattern Unlocks

**Pattern Categories:**

**Common Patterns:**
- Starfield (100 Stardust)
- Nebula Swirl (150 Stardust)
- Comet Tabs (120 Stardust)

**Rare Patterns:**
- Solar Flare (250 Stardust)
- Void Rift (300 Stardust)
- Aurora Waves (280 Stardust)

**Prestige Patterns:**
- Celestial Mandala (5 Prestige Points)
- Cosmic Weave (8 Prestige Points)

---

## ⭐ 8. QUESTS (DAILY + WEEKLY + DISCOVERY)

Questing gives purpose to RP without feeling like chores.

### 8.1 Daily Quests

**System:**
- 3 random daily quests from pool
- Reset every 24 hours
- Can complete all 3 for full rewards

**Quest Pool:**

| Quest                                  | Reward        | Difficulty |
|----------------------------------------|---------------|------------|
| Sit at 5 different beds                | 300 XP, 50 Stardust | Easy       |
| Visit 3 biomes                         | 400 XP, 60 Stardust | Easy       |
| Use 10 different emotes                | 350 XP, 55 Stardust | Easy       |
| Interact with 2 players                 | 400 XP, 70 Stardust | Medium     |
| Perform 3 group sits                   | 450 XP, 75 Stardust | Medium     |
| Find the hidden creature in Nebula Forest | 500 XP, 80 Stardust | Hard       |
| Collect 5 comet fragments              | 400 XP, 65 Stardust | Medium     |
| Discover a secret area                 | 500 XP, 80 Stardust | Hard       |
| Use 5 different beds                   | 300 XP, 50 Stardust | Easy       |
| Attend a group gathering              | 450 XP, 75 Stardust | Medium     |

**Total Daily Potential:**
- **XP**: 900-1500 XP
- **Stardust**: 150-240 Stardust

### 8.2 Weekly Quests

**System:**
- 1 weekly quest per week
- More challenging objectives
- Better rewards

**Weekly Quest Examples:**

| Quest                                  | Reward            | Difficulty |
|----------------------------------------|-------------------|------------|
| Discover all secrets in one biome      | 600 XP, 150 Stardust | Hard       |
| Perform a Temple Ritual                | 700 XP, 180 Stardust | Hard       |
| Take part in an Outer Rim orbit event  | 800 XP, 200 Stardust | Very Hard  |
| Unlock a new pattern                   | 500 XP, 150 Stardust | Medium     |
| Reach level milestone (25/50/75)       | 1000 XP, 200 Stardust | Hard       |
| Complete 10 daily quests               | 600 XP, 150 Stardust | Medium     |

**Weekly Quest Rewards:**
- **XP**: 500-1000 XP
- **Stardust**: 150-200 Stardust
- **Bonus**: Sometimes includes Prestige Point (1)

### 8.3 Discovery Quests

**System:**
- Hidden objectives
- Discovered through exploration
- One-time rewards

**Discovery Examples:**

| Discovery                              | Reward            | Location           |
|----------------------------------------|-------------------|--------------------|
| Secret tunnel                          | 200 XP, 30 Stardust | Nebula Forest      |
| Temple sub-room                        | 300 XP, 50 Stardust | Void Temple        |
| Meteor interior                        | 250 XP, 40 Stardust | Starfall Desert    |
| Aurora Tundra's ice cave               | 300 XP, 50 Stardust | Aurora Tundra      |
| Rift Fragment dimension                | 500 XP, 100 Stardust, 1 Prestige | Rift Fragment |

**Discovery Rewards:**
- **XP**: 200-500 XP
- **Stardust**: 30-100 Stardust
- **Prestige Points**: Some give 1-5 Prestige Points

**Discovery Mechanics:**
- Hidden until found
- No quest markers
- Exploration-based
- One-time only

---

## ⭐ 9. PRESTIGE SYSTEM REWARD TIERS

When reaching Level 100, player can **Prestige**.

### 9.1 Prestige Mechanics

**What Happens:**
- Reset to Level 1
- Keep all species + unlocks
- Gain Prestige Points (5-10)
- Gain title "Cosmic Ascendant"
- New Void Temple animation
- Access to Prestige-only effects
- Prestige counter increases

**Prestige Levels:**
- **Prestige 1 → Prestige 10**
- Each prestige gives:
  - 5-10 Prestige Points
  - New title tier
  - Exclusive cosmetics
  - Special animations

### 9.2 Prestige Titles

| Prestige Level | Title                    | Prestige Points Earned |
|----------------|--------------------------|------------------------|
| Prestige 1     | Cosmic Ascendant         | 5                      |
| Prestige 2     | Stellar Master           | 6                      |
| Prestige 3     | Void Walker              | 7                      |
| Prestige 4     | Celestial Sage           | 8                      |
| Prestige 5     | Astral Sovereign         | 9                      |
| Prestige 6+    | Eternal Cosmo Guardian   | 10                     |

### 9.3 Prestige Rewards

**Per Prestige:**
- Prestige Points (5-10)
- Exclusive title
- Prestige-only effects unlock
- Special animations
- Void Temple access upgrades

**Long-term Goal:**
- Prestige 10 = Ultimate achievement
- Unlocks all prestige content
- Legendary status in game

---

## ⭐ 10. CLAN PROGRESSION (Light Social RPG)

Clan progression adds social depth without complexity.

### 10.1 Clan XP System

**Clan XP Sources:**
- Members completing quests (10% to clan)
- Members leveling up (5% to clan)
- Clan gatherings (50-100 XP per gathering)
- Clan events (200-500 XP per event)

### 10.2 Clan Levels

**Clan Level Range:** 1-20

**Level Benefits:**
- **Level 1-5**: Basic clan features
- **Level 6-10**: Clan hall decorations unlock
- **Level 11-15**: Clan aura effects
- **Level 16-20**: Prestige clan features

**Clan Level Rewards:**
- **Level 5**: Unlock clan hall
- **Level 10**: Unlock clan colors
- **Level 15**: Unlock clan aura
- **Level 20**: Prestige clan badge

### 10.3 Clan Features

**Clan Hall Decorations:**
- Cosmic banners
- Clan symbol displays
- Member showcase
- Achievement displays

**Clan Badges:**
- Visual badge above name tag
- Clan-specific design
- Shows clan level

**Clan Aura:**
- Small VFX around clan members
- Color matches clan colors
- Subtle, not overwhelming

**Clan Leader Unlocks:**
- Clan colors (customization)
- Clan effects (aura styles)
- Clan poses (exclusive poses)
- Clan hall management

---

## ⭐ 11. DATASTORE STRUCTURE (Cursor Implementation)

Your save file includes comprehensive progression data:

```lua
PlayerData = {
    -- Currency
    Stardust = number,
    PrestigePoints = number,
    
    -- Progression
    Level = number,
    XP = number,
    TotalXP = number, -- Lifetime XP (for prestige)
    PrestigeLevel = number, -- 0-10
    
    -- Unlocks
    UnlockedSpecies = {
        [speciesId] = true,
    },
    UnlockedEffects = {
        [effectId] = true,
    },
    UnlockedBeds = {
        [bedId] = true,
    },
    UnlockedAccessories = {
        [accessoryId] = true,
    },
    UnlockedPatterns = {
        [patternId] = true,
    },
    UnlockedEmotes = {
        [emoteId] = true,
    },
    
    -- Appearance
    Appearance = {
        SpeciesId = string,
        PrimaryColor = Color3,
        SecondaryColor = Color3,
        PatternId = string,
        EffectIds = {string},
        AccessoryIds = {string},
    },
    
    -- Clan
    ClanData = {
        ClanId = string?,
        ClanRole = string?, -- "Leader", "Member", etc.
        ClanXP = number,
    },
    
    -- Discoveries
    Discoveries = {
        [discoveryId] = {
            discovered = true,
            discoveredAt = timestamp,
        },
    },
    
    -- Quests
    Quests = {
        DailyQuests = {
            [questId] = {
                completed = boolean,
                completedAt = timestamp?,
            },
        },
        WeeklyQuests = {
            [questId] = {
                completed = boolean,
                completedAt = timestamp?,
            },
        },
        DiscoveryQuests = {
            [questId] = {
                completed = boolean,
                completedAt = timestamp?,
            },
        },
    },
    
    -- Retention
    DailyLogin = {
        currentStreak = number,
        lastLoginDate = string, -- YYYY-MM-DD
        totalLogins = number,
    },
    
    -- Statistics
    Stats = {
        TotalPlayTime = number, -- seconds
        TotalInteractions = number,
        TotalDiscoveries = number,
        TotalQuestsCompleted = number,
    },
    
    -- Data version
    DataVersion = number, -- For migrations
}
```

**Cursor Implementation:**
- Auto-generate this structure in SaveSystem
- Validate all fields on load
- Provide default values for new players
- Handle data migrations

---

## ⭐ 12. PROGRESSION LOOP DIAGRAM

A simple visual loop that keeps players engaged:

```
Play → Earn XP/Stardust → Unlock Cosmetic → More RP Fun →
More Exploration → More Secrets → More XP/Stardust →
More Unlocks → Better Species/Effects → Prestiging →
Repeat
```

**Detailed Flow:**

1. **Play** - Player joins and plays naturally
2. **Earn** - XP and Stardust earned passively
3. **Unlock** - Player unlocks new cosmetic (species, effect, etc.)
4. **Express** - Player uses new unlock in RP
5. **Explore** - Player explores to find more secrets
6. **Discover** - Player finds hidden areas/secrets
7. **Reward** - Discovery gives XP/Stardust/Prestige
8. **Progress** - Player levels up, unlocks more
9. **Prestige** - At level 100, player prestiges
10. **Repeat** - Cycle continues with new goals

**Key:** This loop keeps the game "sticky" without grinding.

---

## ⭐ 13. RETENTION MECHANICS

### 13.1 Daily Login Rewards

**System:**
- Rewards increase with streak
- Resets if missed day
- Visual calendar UI

**Reward Schedule:**

| Day | Stardust | XP    | Bonus                    |
|-----|----------|-------|--------------------------|
| 1   | 20       | 50    | Welcome back!            |
| 2   | 40       | 75    | Streak building          |
| 3   | 60       | 100   | XP Boost token (24h)     |
| 4   | 80       | 125   | Keep it up!                |
| 5   | 100      | 150   | Random pattern           |
| 6   | 120      | 175   | Streak bonus              |
| 7   | 200      | 300   | Random effect OR species discount |

**Streak Bonuses:**
- **7-day streak**: +50% bonus on day 7
- **14-day streak**: +100% bonus on day 14
- **30-day streak**: Prestige Point + special reward

### 13.2 Rotating Shop

**System:**
- New patterns, effects rotate every 3-4 days
- Limited-time discounts (20-30% off)
- "Featured" section highlights new items

**Rotation Schedule:**
- **Monday**: New patterns
- **Thursday**: New effects
- **Sunday**: Special discounts

**Benefits:**
- Creates FOMO (fear of missing out)
- Encourages daily check-ins
- Keeps shop feeling fresh

### 13.3 Event System

**Seasonal Events:**
- **Meteor Showers**: Bonus Stardust + XP
- **Aurora Nights**: Special effects unlockable
- **Cosmic Celebrations**: Prestige Point opportunities

**Event Rewards:**
- 100-300 Stardust
- 200-500 XP
- Sometimes Prestige Points (1-5)
- Exclusive event cosmetics

---

## ⭐ 14. PLAYER XP BOOST (Fair, Non-P2W)

XP boosts give engagement without pay-to-win.

### 14.1 XP Boost Mechanics

**Boost Effect:**
- **+20% XP** for 24 hours
- No effect on Stardust or Prestige Points
- Visual indicator shows active boost

**How to Get:**
- Daily login rewards (day 3)
- Quest rewards (occasionally)
- Event rewards
- Level milestones (every 25 levels)

**Important:** XP boosts are **NOT monetized**. They're earned through gameplay only.

### 14.2 Boost Stacking

**Maximum Boost:**
- **+100% XP** (2x total)
- Achieved through:
  - XP Boost token: +20%
  - Daily login streak: +10-50%
  - Event bonus: +30-50%

**Boost Display:**
- UI indicator shows active boosts
- Timer shows remaining time
- Clear visual feedback

---

## ⭐ 15. PROGRESSION FEEL CHECKLIST

Every system must be:

### 15.1 Pleasant
- [ ] Rewards feel satisfying
- [ ] No frustrating grind walls
- [ ] Progress is visible and clear
- [ ] Unlocks feel meaningful

### 15.2 Short-Session Friendly
- [ ] Can make progress in 10-15 minutes
- [ ] Daily quests are quick to complete
- [ ] Login rewards are instant
- [ ] No long-term commitments required

### 15.3 Rewarding
- [ ] Frequent small rewards
- [ ] Occasional large rewards
- [ ] Surprise discoveries feel special
- [ ] Milestones are celebrated

### 15.4 No Grind Walls
- [ ] No repetitive farming required
- [ ] Passive progression works
- [ ] Quests are varied and interesting
- [ ] Exploration is rewarded

### 15.5 Cosmetic Only (Not Competitive)
- [ ] No PvP advantages
- [ ] All unlocks are cosmetic
- [ ] Progression doesn't create power gaps
- [ ] Fair for all players

### 15.6 Kid & Teen Friendly
- [ ] Prices are affordable
- [ ] No gambling mechanics
- [ ] Clear, simple systems
- [ ] Positive, encouraging tone

### 15.7 Cosmic + Magical
- [ ] Theming matches cosmic aesthetic
- [ ] Rewards feel magical
- [ ] Animations are ethereal
- [ ] Sound effects are cosmic

**If any system feels grindy → rewrite it.**

---

## 📊 Implementation Priority

### Phase 1: Core Progression (MVP)
1. ✅ XP System (basic earning)
2. ✅ Level System (1-100)
3. ✅ Stardust Economy (basic earning)
4. ✅ Species Unlocks (Stardust-based)
5. ✅ Basic Daily Quests

### Phase 2: Advanced Progression
6. ✅ Effect/Accessory Unlocks
7. ✅ Weekly Quests
8. ✅ Discovery System
9. ✅ Daily Login Rewards
10. ✅ Level Titles

### Phase 3: Long-Term Progression
11. ✅ Prestige Points System
12. ✅ Prestige System (Level 100 → 1)
13. ✅ Prestige Species/Effects
14. ✅ Clan Progression

### Phase 4: Polish & Retention
15. ✅ Rotating Shop
16. ✅ Event System
17. ✅ XP Boost System
18. ✅ Statistics Tracking

---

## 🎯 Success Metrics

**Progression System is successful when:**
- Players return daily (60%+ daily return rate)
- Average session length: 30+ minutes
- Players reach level 25+ within first month
- 40%+ of players unlock at least one rare species
- Players complete 70%+ of daily quests
- Prestige system has active participants (5%+ of players)

---

## 📚 Related Documentation

- **Interaction Systems Bible**: `docs/INTERACTION_SYSTEMS_BIBLE.md`
- **Currency System**: `studio-project/src/ServerScriptService/CurrencyServer.lua`
- **SaveSystem**: `studio-project/src/src/ServerStorage/BackendModules/SaveSystem.lua`
- **UnlockablesConfig**: `studio-project/src/ReplicatedStorage/Modules/Config/UnlockablesConfig.lua`

---

**Last Updated:** Progression System Bible - Complete Edition  
**Version:** 1.0 - Final Complete Edition  
**Status:** Ready for Implementation ✅
