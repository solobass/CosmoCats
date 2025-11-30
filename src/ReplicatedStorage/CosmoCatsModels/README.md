# CosmoCatsModels

Species model storage location for all Cosmo Cats species.

## Folder Structure

Each species gets its own folder named with the species ID (uppercase):

```
ReplicatedStorage/
    CosmoCatsModels/
        GALAXY_KITTEN/
            Model.rbxm          (required - the rigged model)
            icon.png            (optional - for species selector GUI)
            thumbnail.png        (optional)
            metadata.json       (optional - for automated pipeline)
        COSMO_SHORTHAIR/
            Model.rbxm
            icon.png
            thumbnail.png
            metadata.json
        LUNAR_LYNX/
            Model.rbxm
            ...
```

## Required Files

- **Model.rbxm** (required) - The rigged model with R15 hierarchy

## Optional Files

- **icon.png** (optional) - Icon for species selector GUI
- **thumbnail.png** (optional) - Thumbnail image
- **metadata.json** (optional) - Metadata for automated pipeline

## Naming Convention

- **Folder name**: Must match species ID exactly (uppercase, underscores)
- **Model file**: Always named `Model.rbxm`
- **Example**: Species ID `GALAXY_KITTEN` → `CosmoCatsModels/GALAXY_KITTEN/Model.rbxm`

## Loading Species in Code

Cursor scripts can load a species like this:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CosmoCatsModels = ReplicatedStorage:WaitForChild("CosmoCatsModels")

local speciesId = "GALAXY_KITTEN"
local speciesFolder = CosmoCatsModels:WaitForChild(speciesId)
local model = speciesFolder:WaitForChild("Model"):Clone()
```

Or more concisely:

```lua
local model = ReplicatedStorage.CosmoCatsModels[speciesId].Model:Clone()
```

## Import Process

1. Import FBX/GLB from Meshy AI into Roblox Studio
2. Convert to Model format (.rbxm)
3. Create folder with species ID name
4. Place Model.rbxm inside the folder
5. Add optional files (icon.png, thumbnail.png, metadata.json)
6. Update `SpeciesData.lua` with `modelFolder` matching folder name

## Notes

- All species models must follow the standardized pipeline (see CHARACTER_PIPELINE.md)
- Models must be in T-Pose with R15 hierarchy
- Scale will be applied automatically via `Humanoid:ApplyDescription()`
- Each species folder should contain Model.rbxm and optional supporting files

