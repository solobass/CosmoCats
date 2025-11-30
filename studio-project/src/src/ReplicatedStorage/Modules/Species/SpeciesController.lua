-- SpeciesController.lua
-- Central manager for selecting, spawning, and managing species data for Cosmo Cats.
-- Runs on both client and server via RemoteEvents/RemoteFunctions.

local SpeciesController = {}

--[[
    Public API (target):

    SpeciesController.GetAllSpecies() -> { [speciesId]: SpeciesDefinition }
    SpeciesController.GetSpecies(speciesId: string) -> SpeciesDefinition?
    SpeciesController.GetDefaultSpeciesForNewPlayer(player: Player) -> string

    -- Client:
    SpeciesController.PromptSpeciesSelection()
    SpeciesController.SpawnAsSpecies(speciesId: string)

    -- Server:
    SpeciesController.SetPlayerSpecies(player: Player, speciesId: string)
    SpeciesController.GetPlayerSpecies(player: Player) -> string?
]]

local SpeciesData = require(script.Parent.SpeciesData)

-- Store temporary in-memory player → species mapping
local playerSpecies = {}

function SpeciesController.GetAllSpecies()
    return SpeciesData.GetAll()
end

function SpeciesController.GetSpecies(speciesId: string)
    return SpeciesData.Get(speciesId)
end

function SpeciesController.GetDefaultSpeciesForNewPlayer(player)
    -- TODO: Optionally customize based on gamepass / first-time status
    return "GALAXY_KITTEN"
end

function SpeciesController.SetPlayerSpecies(player, speciesId)
    -- TODO: validate species, check unlocks, and assign
    playerSpecies[player] = speciesId
end

function SpeciesController.GetPlayerSpecies(player)
    return playerSpecies[player]
end

-- TODO (Client): Connect GUI events → RemoteEvents for species selection and spawning.
-- TODO (Server): Hook into PlayerAdded/CharacterAdded to spawn species models.

return SpeciesController

