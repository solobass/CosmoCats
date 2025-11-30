-- SpeciesData.lua
-- Central static definitions for all Cosmo Cats species.

local SpeciesData = {}

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
        allowedEmotes = { "SIT", "LAY", "GROOM", "TAIL_FLICK" },
        abilities = { "ZERO_G_HOVER" },
    },

    LUNAR_LYNX = {
        id = "LUNAR_LYNX",
        displayName = "Lunar Lynx",
        category = "Unlockable",
        unlockCost = 250,
        gamePassId = nil,
        modelFolder = "LUNAR_LYNX",
        defaultScale = 1.1,
        movementProfile = "Graceful",
        allowedEmotes = { "SIT", "LAY", "GROOM", "STRETCH" },
        abilities = { "ZERO_G_HOVER", "GLOW_EYES" },
    },

    -- Add premium species here…
}

function SpeciesData.GetAll()
    return speciesDefinitions
end

function SpeciesData.Get(id)
    return speciesDefinitions[id]
end

return SpeciesData


