-- AccessoriesLibrary.lua
-- Available accessories for character customization.
--
-- Accessory Pipeline:
-- - Accessories are separate MeshParts (unskinned)
-- - Stored in ReplicatedStorage/CosmoCatsAccessories/[ACCESSORY_ID]/MeshPart.rbxm
-- - Attached via WeldConstraints or Accessory attachment points
-- - Cursor's CharacterCreator will weld them automatically
--
-- Accessory Format:
-- {
--     id = "STAR_COLLAR",
--     displayName = "Star Collar",
--     attachmentPoint = "Neck", -- Where to attach on character
--     category = "Common", -- Common | Rare | Epic | Legendary
-- }

local AccessoriesLibrary = {}

--[[
    Accessory Library Format
    
    Accessories stored as:
    {
        [accessoryId] = {
            id = "STAR_COLLAR",
            displayName = "Star Collar",
            attachmentPoint = "Neck", -- Where to attach on character
            category = "Common", -- Common | Rare | Epic | Legendary
        }
    }
    
    Cursor's CharacterCreator will load and weld accessories automatically:
    - Load from: ReplicatedStorage.CosmoCatsAccessories[accessoryId].MeshPart
    - Attach using WeldConstraint or Accessory attachment points
]]

local Accessories = {
    -- TODO: Add accessory definitions
    -- STAR_COLLAR = {
    --     id = "STAR_COLLAR",
    --     displayName = "Star Collar",
    --     attachmentPoint = "Neck",
    --     category = "Common",
    -- },
    -- EAR_CRYSTALS = {
    --     id = "EAR_CRYSTALS",
    --     displayName = "Ear Crystals",
    --     attachmentPoint = "Head",
    --     category = "Rare",
    -- },
}

function AccessoriesLibrary.Get(accessoryId: string): table?
    return Accessories[accessoryId]
end

function AccessoriesLibrary.GetAll(): { [string]: table }
    return Accessories
end

function AccessoriesLibrary.Has(accessoryId: string): boolean
    return Accessories[accessoryId] ~= nil
end

return AccessoriesLibrary

