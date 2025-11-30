# Assets

All 3D content generated via Meshy AI or Blender.

**Purpose:** Easy to replace/update assets without touching core code.

## Structure

```
assets/
├── models/              # Species models
│   ├── GALAXY_KITTEN/
│   │   ├── v1_Model.fbx
│   │   ├── v2_Model.fbx
│   │   └── Model.rbxm          # exported to Roblox
│   ├── COSMO_SHORTHAIR/
│   └── LUNAR_LYNX/
│
├── animations/          # Animation files
│   ├── Idle.fbx
│   ├── Walk.fbx
│   ├── Sit.fbx
│   └── (export to Studio)
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

## Versioning Strategy

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

## Usage

- **Meshy AI** generates models → place in `assets/models/[SPECIES_ID]/`
- **Blender** exports animations → place in `assets/animations/`
- **Textures** created externally → place in `assets/textures/`
- **Effects** created in Studio → export to `assets/effects/`

## Import to Studio

Models and animations are imported into Roblox Studio and placed in:
- `studio-project/src/ReplicatedStorage/CosmoCatsModels/`
- `studio-project/src/ReplicatedStorage/SharedAnimations/`
- `studio-project/src/ReplicatedStorage/CosmoCatsEffects/`

