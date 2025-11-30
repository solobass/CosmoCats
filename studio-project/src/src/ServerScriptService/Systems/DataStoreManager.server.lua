--[[
	DataStoreManager.server.lua
	Handles all data persistence with automatic saving, error handling, and retries.
]]

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local DataStoreManager = {}
DataStoreManager.__index = DataStoreManager

-- Configuration
local DATA_STORE_NAME = "PlayerData_CosmoCats"
local SAVE_INTERVAL = 30 -- seconds
local MAX_RETRIES = 3
local RETRY_DELAY = 1 -- seconds

-- Create DataStore (safely handle Studio environment where DataStore doesn't work)
local playerDataStore
local success, err = pcall(function()
	playerDataStore = DataStoreService:GetDataStore(DATA_STORE_NAME)
end)

if not success then
	warn("[DataStoreManager] DataStore not available (normal in Studio):", err)
	playerDataStore = nil
end

-- Player data cache
local playerDataCache = {}
local saveQueue = {}

-- Create new DataStoreManager instance
function DataStoreManager.new()
	local self = setmetatable({}, DataStoreManager)
	return self
end

-- Load player data with retries
function DataStoreManager:LoadData(player: Player): (boolean, any)
	if not playerDataStore then
		warn("[DataStoreManager] DataStore not available - returning nil data")
		return true, nil -- Return success with nil data (Studio mode)
	end
	
	local userId = tostring(player.UserId)
	local retries = 0
	
	repeat
		local success, data = pcall(function()
			return playerDataStore:GetAsync(userId)
		end)
		
		if success then
			if data then
				-- Data exists, cache it
				playerDataCache[userId] = data
				return true, data
			else
				-- No data exists, return nil
				return true, nil
			end
		else
			warn(`[DataStoreManager] Failed to load data for {player.Name} (Attempt {retries + 1}/{MAX_RETRIES}): {data}`)
			retries = retries + 1
			if retries < MAX_RETRIES then
				task.wait(RETRY_DELAY)
			end
		end
	until retries >= MAX_RETRIES
	
	warn(`[DataStoreManager] Failed to load data for {player.Name} after {MAX_RETRIES} attempts`)
	return false, nil
end

-- Save player data with retries
function DataStoreManager:SaveData(player: Player, data: any): boolean
	if not playerDataStore then
		-- In Studio mode, just cache the data
		local userId = tostring(player.UserId)
		playerDataCache[userId] = data
		return true -- Return success (data cached, not saved)
	end
	
	local userId = tostring(player.UserId)
	local retries = 0
	
	-- Update cache
	playerDataCache[userId] = data
	
	repeat
		local success, errorMessage = pcall(function()
			playerDataStore:SetAsync(userId, data)
		end)
		
		if success then
			return true
		else
			warn(`[DataStoreManager] Failed to save data for {player.Name} (Attempt {retries + 1}/{MAX_RETRIES}): {errorMessage}`)
			retries = retries + 1
			if retries < MAX_RETRIES then
				task.wait(RETRY_DELAY)
			end
		end
	until retries >= MAX_RETRIES
	
	warn(`[DataStoreManager] Failed to save data for {player.Name} after {MAX_RETRIES} attempts`)
	return false
end

-- Queue player for saving
function DataStoreManager:QueueSave(player: Player)
	local userId = tostring(player.UserId)
	saveQueue[userId] = true
end

-- Get cached data (doesn't load from DataStore)
function DataStoreManager:GetCachedData(player: Player): any?
	local userId = tostring(player.UserId)
	return playerDataCache[userId]
end

-- Update cached data
function DataStoreManager:UpdateCachedData(player: Player, data: any)
	local userId = tostring(player.UserId)
	playerDataCache[userId] = data
end

-- Remove player data from cache
function DataStoreManager:RemovePlayer(player: Player)
	local userId = tostring(player.UserId)
	
	-- Final save before removing
	if playerDataCache[userId] then
		self:SaveData(player, playerDataCache[userId])
	end
	
	playerDataCache[userId] = nil
	saveQueue[userId] = nil
end

-- Auto-save loop
task.spawn(function()
	while true do
		task.wait(SAVE_INTERVAL)
		
		-- Save all queued players
		for userId, _ in pairs(saveQueue) do
			local player = Players:GetPlayerByUserId(tonumber(userId))
			if player and playerDataCache[userId] then
				DataStoreManager:SaveData(player, playerDataCache[userId])
				saveQueue[userId] = nil
			elseif not player then
				-- Player left, remove from queue
				saveQueue[userId] = nil
			end
		end
	end
end)

-- Save all players on server shutdown
game:BindToClose(function()
	for userId, data in pairs(playerDataCache) do
		local player = Players:GetPlayerByUserId(tonumber(userId))
		if player then
			DataStoreManager:SaveData(player, data)
		end
	end
end)

return DataStoreManager

