-- GameConfig.lua
-- High-level configuration values for Cosmo Cats.

local GameConfig = {
    GameName = "Cosmo Cats",
    DefaultSpeciesId = "GALAXY_KITTEN",
    
    -- Stardust earnings
    StardustPerInterval = 5,
    StardustIntervalSeconds = 90,
    
    -- DataStore keys / versioning
    DataStoreVersion = "v1",
    
    -- Misc gameplay tuning
    MaxBedsPerPlayer = 3,
    MaxClanMembers = 30,
}

return GameConfig


