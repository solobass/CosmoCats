-- SpeciesServer.lua
-- Authoritative server logic for handling species assignment, unlocks, and character spawning.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local SpeciesController = require(Modules:WaitForChild("Species"):WaitForChild("SpeciesController"))
local SpeciesData = require(Modules:WaitForChild("Species"):WaitForChild("SpeciesData"))

local SaveSystem = require(ServerStorage:WaitForChild("BackendModules"):WaitForChild("SaveSystem"))

local CurrencyServer = require(script.Parent.CurrencyServer)

local Remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Species")
local RequestSetSpecies = Remotes:WaitForChild("RequestSetSpecies")
local ConfirmSpecies = Remotes:WaitForChild("ConfirmSpecies")
local GetPlayerSpecies = Remotes:WaitForChild("GetPlayerSpecies")

-- Store player → species ID
local playerSpecies = {}

-- Load from DataStore or default
local function loadPlayerSpecies(player)
    local data = SaveSystem.LoadPlayerData(player)
    local speciesId = data.Species or "GALAXY_KITTEN"
    playerSpecies[player] = speciesId
end

local function savePlayerSpecies(player)
    local data = SaveSystem.LoadPlayerData(player)
    data.Species = playerSpecies[player]
    SaveSystem.SavePlayerData(player, data)
end

-- Spawn logic
local function applySpeciesModel(player, speciesId)
    local character = player.Character
    if not character then return end

    local speciesDef = SpeciesData.Get(speciesId)
    if not speciesDef then
        warn("[SpeciesServer] Invalid species:", speciesId)
        return
    end

    -- Remove default humanoid model parts
    for _, obj in ipairs(character:GetChildren()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("Accessory") then
            if obj.Name ~= "HumanoidRootPart" then
                obj:Destroy()
            end
        end
    end

    -- Load model from CosmoCatsModels
    local cosmoCatsModels = ReplicatedStorage:FindFirstChild("CosmoCatsModels")
    if not cosmoCatsModels then
        warn("[SpeciesServer] CosmoCatsModels folder not found")
        return
    end

    local modelFolder = cosmoCatsModels:FindFirstChild(speciesId)
    if not modelFolder then
        warn("[SpeciesServer] Missing species model folder:", speciesId)
        return
    end

    local model = modelFolder:FindFirstChild("Model")
    if not model then
        warn("[SpeciesServer] Missing Model in folder:", speciesId)
        return
    end

    local clonedModel = model:Clone()

    -- Get current position
    local hrp = character:WaitForChild("HumanoidRootPart")
    local currentCFrame = hrp.CFrame

    -- Move cloned model parts to character
    for _, item in ipairs(clonedModel:GetChildren()) do
        if item:IsA("BasePart") or item:IsA("MeshPart") then
            item.Parent = character
            if item.Name == "HumanoidRootPart" then
                item.CFrame = currentCFrame
            end
        elseif item:IsA("Accessory") or item:IsA("Model") then
            item.Parent = character
        end
    end

    -- Apply scale if needed
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid and speciesDef.defaultScale and speciesDef.defaultScale ~= 1.0 then
        local humanoidDescription = humanoid:GetAppliedDescription()
        local scale = speciesDef.defaultScale
        humanoidDescription.HeadScale = scale
        humanoidDescription.DepthScale = scale
        humanoidDescription.HeightScale = scale
        humanoidDescription.ProportionScale = scale
        humanoidDescription.WidthScale = scale
        humanoid:ApplyDescription(humanoidDescription)
    end

    -- Clean up cloned model container
    clonedModel:Destroy()

    print("[Cosmo Cats] Spawned species:", speciesId, "for", player.Name)
end

-- Handle species requests
RequestSetSpecies.OnServerEvent:Connect(function(player, speciesId)
    local speciesDef = SpeciesData.Get(speciesId)
    if not speciesDef then
        warn("[SpeciesServer] Invalid species requested:", speciesId, "by", player.Name)
        return
    end

    local data = SaveSystem.LoadPlayerData(player)

    -- Check if player has rights
    if not SpeciesController.CanPlayerUseSpecies(player, speciesDef, data) then
        warn("[SpeciesServer] Player", player.Name, "attempted to use unavailable species:", speciesId)
        return
    end

    -- Save selection
    playerSpecies[player] = speciesId
    savePlayerSpecies(player)

    -- Confirm to client
    ConfirmSpecies:FireClient(player, speciesId)

    -- Respawn character
    if player.Character then
        player:LoadCharacter()
    end
end)

GetPlayerSpecies.OnServerInvoke = function(_, player)
    return playerSpecies[player] or "GALAXY_KITTEN"
end

-- Player lifecycle
Players.PlayerAdded:Connect(function(player)
    loadPlayerSpecies(player)
end)

Players.PlayerRemoving:Connect(function(player)
    savePlayerSpecies(player)
    playerSpecies[player] = nil
end)

-- Character spawning
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        local speciesId = playerSpecies[player] or "GALAXY_KITTEN"
        task.wait(0.2) -- Wait for character to fully load
        applySpeciesModel(player, speciesId)
    end)
end)

-- Handle players already in game (for Studio testing)
for _, player in ipairs(Players:GetPlayers()) do
    loadPlayerSpecies(player)
    if player.Character then
        local speciesId = playerSpecies[player] or "GALAXY_KITTEN"
        task.wait(0.2)
        applySpeciesModel(player, speciesId)
    end
    player.CharacterAdded:Connect(function()
        local speciesId = playerSpecies[player] or "GALAXY_KITTEN"
        task.wait(0.2)
        applySpeciesModel(player, speciesId)
    end)
end

return {}

