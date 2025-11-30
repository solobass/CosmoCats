-- SpeciesController.lua
-- Shared utilities for species validation, fetching, and metadata access.

local SpeciesData = require(script.Parent.SpeciesData)

local SpeciesController = {}

function SpeciesController.GetAllSpecies()
    return SpeciesData.GetAll()
end

function SpeciesController.GetSpecies(speciesId)
    return SpeciesData.Get(speciesId)
end

function SpeciesController.CanPlayerUseSpecies(player, speciesDef, playerData)
    -- Starter species
    if speciesDef.category == "Starter" then
        return true
    end

    -- Unlockable species
    if speciesDef.category == "Unlockable" then
        return playerData.UnlockedSpecies[speciesDef.id] == true
    end

    -- Premium species via Gamepass
    if speciesDef.category == "Premium" then
        if speciesDef.gamePassId == nil then
            return false
        end
        local passService = game:GetService("MarketplaceService")
        return passService:UserOwnsGamePassAsync(player.UserId, speciesDef.gamePassId)
    end

    return false
end

return SpeciesController


