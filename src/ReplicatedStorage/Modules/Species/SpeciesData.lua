-- SpeciesData.lua
-- Static data definitions for all species (Space Cats) in Cosmo Cats.

local SpeciesData = {}

--[[
    SpeciesDefinition schema (Cursor Integration):
    
    All species must be defined using this schema. Cursor will use modelFolder to auto-spawn the right model.

    {
        id = "GALAXY_KITTEN",
        displayName = "Galaxy Kitten",
        category = "Starter", -- Starter | Unlockable | Premium
        unlockCost = 0,       -- Stardust cost if unlockable
        gamePassId = nil,     -- Robux gamepass if premium
        modelFolder = "GALAXY_KITTEN", -- Must match folder name in CosmoCatsModels/
        defaultScale = 1.0,
        movementProfile = "Default", -- references a movement config table
        allowedEmotes = { "SIT", "LOAF", "GROOM", "MEOW" },
        abilities = { "ZERO_G_HOVER" },
    }
    
    Cursor will use modelFolder to load: ReplicatedStorage.CosmoCatsModels[modelFolder].Model
]]

local speciesDefinitions = {
    GALAXY_KITTEN = {
        id = "GALAXY_KITTEN",
        displayName = "Galaxy Kitten",
        category = "Starter",
        unlockCost = 0,
        gamePassId = nil,
        modelFolder = "GALAXY_KITTEN",
        defaultScale = 1.0,
        movementProfile = "Default",
        allowedEmotes = { "SIT", "LOAF", "GROOM", "MEOW" },
        abilities = { "ZERO_G_HOVER" },
    },

    COSMO_SHORTHAIR = {
        id = "COSMO_SHORTHAIR",
        displayName = "Cosmo Shorthair",
        category = "Starter",
        unlockCost = 0,
        gamePassId = nil,
        modelFolder = "COSMO_SHORTHAIR",
        defaultScale = 1.0,
        movementProfile = "Default",
        allowedEmotes = { "SIT", "LAY", "GROOM", "TAIL_FLICK", "MEOW" },
        abilities = { "ZERO_G_HOVER" },
    },

    -- TODO: Add Lunar Lynx, Nebula Panther, Solar Tiger, Starshade Cat, etc.
}

function SpeciesData.GetAll()
    return speciesDefinitions
end

function SpeciesData.Get(id: string)
    return speciesDefinitions[id]
end

return SpeciesData

