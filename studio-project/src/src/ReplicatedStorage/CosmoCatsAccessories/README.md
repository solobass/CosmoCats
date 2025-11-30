# CosmoCatsAccessories

Accessory storage location for all Cosmo Cats accessories.

## Folder Structure

Each accessory gets its own folder named with the accessory ID (uppercase):

```
ReplicatedStorage/
    CosmoCatsAccessories/
        STAR_COLLAR/
            MeshPart.rbxm
        EAR_CRYSTALS/
            MeshPart.rbxm
        [ACCESSORY_ID]/
            MeshPart.rbxm
```

## Accessory Requirements

Accessories must be:
- **Separate MeshParts** - Not part of the main character mesh
- **Unskinned** - Independent mesh parts (not skinned to bones)
- **Attached via WeldConstraints or Accessory attachment points** - Standard Roblox attachment system

## Naming Convention

- **Folder name**: Must match accessory ID exactly (uppercase, underscores)
- **Mesh file**: Always named `MeshPart.rbxm`
- **Example**: Accessory ID `STAR_COLLAR` → `CosmoCatsAccessories/STAR_COLLAR/MeshPart.rbxm`

## Loading Accessories in Code

Cursor's CharacterCreator will weld them automatically:

```lua
local accessoriesFolder = ReplicatedStorage:WaitForChild("CosmoCatsAccessories")
local accessoryFolder = accessoriesFolder:WaitForChild(accessoryId)
local meshPart = accessoryFolder:WaitForChild("MeshPart"):Clone()

-- Attach to character using WeldConstraint or Attachment system
```

## Attachment Points

Common attachment points:
- **Collars**: `Neck` or `UpperTorso`
- **Ear accessories**: `Head` or specific ear attachments
- **Tail accessories**: `LowerTorso` or tail base
- **Body accessories**: `UpperTorso` or `LowerTorso`

## Import Process

1. Create accessory as separate MeshPart in Roblox Studio
2. Export or save as Model format (.rbxm)
3. Create folder with accessory ID name
4. Place MeshPart.rbxm inside the folder
5. Update `AccessoriesLibrary.lua` with new accessory data

## Notes

- Accessories are cosmetic items that enhance character appearance
- They are separate from the main character mesh for flexibility
- Cursor's CharacterCreator handles automatic welding/attachment
- All accessories must follow the unskinned MeshPart format

