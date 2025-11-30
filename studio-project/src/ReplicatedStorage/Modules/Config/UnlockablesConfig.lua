-- UnlockablesConfig.lua
-- Central registry of anything purchasable with Stardust.

local UnlockablesConfig = {}

local Unlockables = {
    -- Species unlocks
    LUNAR_LYNX = {
        cost = 250,
        type = "Species",
        saveField = "UnlockedSpecies",
    },

    -- Bed unlocks
    MOON_ROCK_BED = {
        cost = 150,
        type = "Bed",
        saveField = "OwnedBeds",
    },
    BLANKET_BED = {
        cost = 100,
        type = "Bed",
        saveField = "OwnedBeds",
    },
    BOX_BED = {
        cost = 75,
        type = "Bed",
        saveField = "OwnedBeds",
    },

    -- Effect unlocks
    NEBULA_AURA = {
        cost = 200,
        type = "Effect",
        saveField = "OwnedEffects",
    },
    STAR_TRAIL = {
        cost = 175,
        type = "Effect",
        saveField = "OwnedEffects",
    },

    -- Pattern unlocks
    STARFIELD = {
        cost = 175,
        type = "Pattern",
        saveField = "OwnedPatterns",
    },
    NEBULA_SWIRL = {
        cost = 200,
        type = "Pattern",
        saveField = "OwnedPatterns",
    },
}

function UnlockablesConfig.Get(unlockId)
    return Unlockables[unlockId]
end

function UnlockablesConfig.GetAll()
    return Unlockables
end

-- Make it indexable like a table
setmetatable(UnlockablesConfig, {
    __index = function(_, key)
        return Unlockables[key]
    end
})

return UnlockablesConfig


