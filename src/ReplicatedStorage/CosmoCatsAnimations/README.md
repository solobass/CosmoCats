# CosmoCatsAnimations

Species-specific animation overrides for premium or special species.

## Folder Structure

Premium species may have custom animation overrides:

```
ReplicatedStorage/CosmoCatsAnimations/
    BLACK_HOLE_CAT/
        Idle.anim
        Float.anim
    [SPECIES_ID]/
        [AnimationName].anim
```

## Animation Override System

- **Species-specific animations** override shared animations
- **Folder name** must match species ID (e.g., `BLACK_HOLE_CAT`)
- **If an animation is missing** → fallback to shared animation in `ReplicatedStorage/SharedAnimations/`

## Animation Loading

Cursor will load animations with this priority:

1. Check species-specific folder: `CosmoCatsAnimations/[SPECIES_ID]/[AnimationName].anim`
2. If not found, fallback to: `SharedAnimations/[AnimationName].anim`

## Animation Naming

- Use PascalCase (e.g., `Idle.anim`, `Walk.anim`, `Float.anim`)
- Match shared animation names for consistency when overriding
- Custom animations can have unique names

## Shared Animations

All species use these shared animations by default:
- `Idle.anim`
- `Walk.anim`
- `Run.anim`
- `Sit.anim`
- `Lay.anim`
- `Loaf.anim`
- `Groom.anim`
- `TailFlick.anim`

See `ReplicatedStorage/SharedAnimations/` for the complete set.


