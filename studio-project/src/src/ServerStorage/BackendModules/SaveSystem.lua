-- SaveSystem.lua
-- Backend save system for data persistence.
-- Handles DataStore operations with retry logic, default data, and auto-save.

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local GameConfig = require(Modules:WaitForChild("Config"):WaitForChild("GameConfig"))

local SaveSystem = {}

-- DataStore configuration
local DATA_STORE_NAME = "CosmoCats_PlayerData"
local DATA_STORE_VERSION = GameConfig.DataStoreVersion or "v1"
local DATA_STORE_KEY = DATA_STORE_NAME .. "_" .. DATA_STORE_VERSION

-- Get DataStore
local playerDataStore = DataStoreService:GetDataStore(DATA_STORE_KEY)

-- Retry configuration
local MAX_RETRIES = 3
local RETRY_DELAY = 1

-- Auto-save configuration
local AUTO_SAVE_INTERVAL = 60 -- seconds
local pendingSaves = {} -- Track players with pending saves

----------------------------------------
-- DEFAULT PLAYER DATA
----------------------------------------

function SaveSystem.GetDefaultPlayerData()
    return {
        -- Species
        Species = "GALAXY_KITTEN",
        
        -- Currency
        Stardust = 0,
        
        -- Unlocks
        UnlockedSpecies = {},
        OwnedBeds = {},
        OwnedPatterns = {},
        OwnedEffects = {},
        
        -- Data version for migration
        DataVersion = 1,
    }
end

----------------------------------------
-- DATA VALIDATION
----------------------------------------

local function validatePlayerData(data)
    if not data or type(data) ~= "table" then
        return false
    end
    
    -- Ensure required fields exist
    if not data.Species then data.Species = "GALAXY_KITTEN" end
    if not data.Stardust then data.Stardust = 0 end
    if not data.UnlockedSpecies then data.UnlockedSpecies = {} end
    if not data.OwnedBeds then data.OwnedBeds = {} end
    if not data.OwnedPatterns then data.OwnedPatterns = {} end
    if not data.OwnedEffects then data.OwnedEffects = {} end
    
    -- Validate types
    if type(data.Stardust) ~= "number" or data.Stardust < 0 then
        data.Stardust = 0
    end
    
    if type(data.UnlockedSpecies) ~= "table" then
        data.UnlockedSpecies = {}
    end
    
    if type(data.OwnedBeds) ~= "table" then
        data.OwnedBeds = {}
    end
    
    if type(data.OwnedPatterns) ~= "table" then
        data.OwnedPatterns = {}
    end
    
    if type(data.OwnedEffects) ~= "table" then
        data.OwnedEffects = {}
    end
    
    return true
end

----------------------------------------
-- DATASTORE OPERATIONS WITH RETRY
----------------------------------------

local function loadDataWithRetry(userId)
    local key = tostring(userId)
    local attempts = 0
    
    while attempts < MAX_RETRIES do
        local success, result = pcall(function()
            return playerDataStore:GetAsync(key)
        end)
        
        if success then
            return result
        else
            attempts = attempts + 1
            if attempts < MAX_RETRIES then
                warn("[SaveSystem] Load attempt", attempts, "failed for user", userId, "- retrying...")
                task.wait(RETRY_DELAY)
            else
                warn("[SaveSystem] Failed to load data for user", userId, "after", MAX_RETRIES, "attempts")
                return nil
            end
        end
    end
    
    return nil
end

local function saveDataWithRetry(userId, data)
    local key = tostring(userId)
    local attempts = 0
    
    while attempts < MAX_RETRIES do
        local success, result = pcall(function()
            playerDataStore:SetAsync(key, data)
            return true
        end)
        
        if success then
            return true
        else
            attempts = attempts + 1
            if attempts < MAX_RETRIES then
                warn("[SaveSystem] Save attempt", attempts, "failed for user", userId, "- retrying...")
                task.wait(RETRY_DELAY)
            else
                warn("[SaveSystem] Failed to save data for user", userId, "after", MAX_RETRIES, "attempts")
                return false
            end
        end
    end
    
    return false
end

----------------------------------------
-- PUBLIC API
----------------------------------------

function SaveSystem.LoadPlayerData(player)
    if not player or not player.UserId then
        warn("[SaveSystem] Invalid player for LoadPlayerData")
        return SaveSystem.GetDefaultPlayerData()
    end
    
    local userId = player.UserId
    local loadedData = loadDataWithRetry(userId)
    
    if loadedData then
        -- Validate and merge with defaults
        if validatePlayerData(loadedData) then
            return loadedData
        else
            warn("[SaveSystem] Invalid data loaded for", player.Name, "- using defaults")
        end
    end
    
    -- Return default data if load failed or invalid
    return SaveSystem.GetDefaultPlayerData()
end

function SaveSystem.SavePlayerData(player, data)
    if not player or not player.UserId then
        warn("[SaveSystem] Invalid player for SavePlayerData")
        return false
    end
    
    if not data then
        warn("[SaveSystem] No data provided for", player.Name)
        return false
    end
    
    -- Validate data
    if not validatePlayerData(data) then
        warn("[SaveSystem] Invalid data for", player.Name, "- validation failed")
        return false
    end
    
    local userId = player.UserId
    local success = saveDataWithRetry(userId, data)
    
    if success then
        print("[SaveSystem] Successfully saved data for", player.Name)
    else
        warn("[SaveSystem] Failed to save data for", player.Name)
    end
    
    return success
end

----------------------------------------
-- AUTO-SAVE SYSTEM
----------------------------------------

local function queueAutoSave(player)
    if not pendingSaves[player] then
        pendingSaves[player] = true
    end
end

local function processAutoSave(player, playerData)
    if not pendingSaves[player] then
        return
    end
    
    pendingSaves[player] = nil
    SaveSystem.SavePlayerData(player, playerData)
end

-- Auto-save loop
task.spawn(function()
    while true do
        task.wait(AUTO_SAVE_INTERVAL)
        
        for player, _ in pairs(pendingSaves) do
            if player.Parent then
                -- Get current data from systems that use SaveSystem
                -- This will be called by CurrencyServer, SpeciesServer, etc.
                -- For now, we'll save when explicitly requested
            else
                pendingSaves[player] = nil
            end
        end
    end
end)

----------------------------------------
-- PLAYER LIFECYCLE
----------------------------------------

Players.PlayerRemoving:Connect(function(player)
    -- Final save on player leaving
    -- Systems should call SavePlayerData before player leaves
    pendingSaves[player] = nil
end)

----------------------------------------

return SaveSystem
