# SharedAnimations

Common animations used across all Cosmo Cats species.

## Animation Set

All species use these shared animations by default:

- `Idle.anim` - Idle animation when standing still
- `Walk.anim` - Walking animation
- `Run.anim` - Running animation
- `Sit.anim` - Sitting animation
- `Lay.anim` - Laying down animation
- `Loaf.anim` - Loafing (cat loaf pose) animation
- `Groom.anim` - Grooming animation
- `TailFlick.anim` - Tail flicking animation

## Animation Override System

Premium species may have custom animations in `ReplicatedStorage/CosmoCatsAnimations/[SPECIES_ID]/`.

**Fallback Logic:**
1. Check species-specific: `CosmoCatsAnimations[speciesId][animationName]`
2. If not found, fallback to shared: `SharedAnimations[animationName]`

If a species-specific animation is missing, the system automatically falls back to the shared animation.

## Usage

```lua
-- Load shared animation directly
local idleAnim = ReplicatedStorage.SharedAnimations.Idle

-- Animation loading with fallback (see AnimationController.lua)
-- 1. Check species-specific: CosmoCatsAnimations[speciesId][animationName]
-- 2. Fallback to shared: SharedAnimations[animationName]
```

## Setup

1. Create Animation objects in Roblox Studio
2. Import or create animations
3. Place them in this folder in Studio
4. Name them exactly as listed above
5. Reference in code: `ReplicatedStorage.SharedAnimations.AnimationName`

## Note

The .anim.md files in this folder are placeholders documenting where the actual Animation objects should be placed in Roblox Studio.

