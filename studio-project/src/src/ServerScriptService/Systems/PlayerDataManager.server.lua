--[[
	PlayerDataManager.server.lua
	Manages player state, validates all data changes, and syncs to clients.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Safely require modules (may not exist yet)
local success1, DataStoreManager = pcall(function() return require(script.Parent.DataStoreManager) end)
local success2, PlayerData = pcall(function() return require(ReplicatedStorage:WaitForChild("Shared", 1):WaitForChild("Types", 1):WaitForChild("PlayerData", 1)) end)
local success3, PlayerDataEvents = pcall(function() return require(ReplicatedStorage:WaitForChild("Shared", 1):WaitForChild("Events", 1):WaitForChild("PlayerDataEvents", 1)) end)

DataStoreManager = success1 and DataStoreManager or nil
PlayerData = success2 and PlayerData or nil
PlayerDataEvents = success3 and PlayerDataEvents or nil

local PlayerDataManager = {}
PlayerDataManager.__index = PlayerDataManager

-- Initialize DataStoreManager (safely handle nil)
local dataStoreManager
if DataStoreManager then
	dataStoreManager = DataStoreManager.new()
else
	warn("[PlayerDataManager] DataStoreManager not available - running in Studio mode")
	dataStoreManager = nil
end

-- Remote events for client communication
local remoteEvents = Instance.new("Folder")
remoteEvents.Name = "PlayerDataRemotes"
remoteEvents.Parent = ReplicatedStorage

local updateDataRemote = Instance.new("RemoteEvent")
updateDataRemote.Name = "UpdatePlayerData"
updateDataRemote.Parent = remoteEvents

-- Player data storage
local playerData = {}

-- Create new PlayerDataManager instance
function PlayerDataManager.new()
	local self = setmetatable({}, PlayerDataManager)
	return self
end

-- Merge default data with loaded data (handles data migration)
local function mergeWithDefaults(loadedData: any): any
	local merged = {}
	
	-- Copy defaults
	for key, value in pairs(PlayerData.Default) do
		if type(value) == "table" and not table.isfrozen(value) then
			merged[key] = {}
			for k, v in pairs(value) do
				merged[key][k] = v
			end
		else
			merged[key] = value
		end
	end
	
	-- Override with loaded data
	if loadedData then
		for key, value in pairs(loadedData) do
			if merged[key] ~= nil then
				if type(value) == "table" and type(merged[key]) == "table" then
					-- Deep merge tables
					for k, v in pairs(value) do
						merged[key][k] = v
					end
				else
					merged[key] = value
				end
			end
		end
	end
	
	-- Ensure data version is set
	merged.DataVersion = PlayerData.Default.DataVersion
	
	return merged
end

-- Load player data
function PlayerDataManager:LoadPlayerData(player: Player): boolean
	if not dataStoreManager then
		-- Studio mode - return default data
		warn(`[PlayerDataManager] DataStoreManager not available - using default data for {player.Name}`)
		return true
	end
	
	local success, loadedData = dataStoreManager:LoadData(player)
	
	if not success then
		warn(`[PlayerDataManager] Failed to load data for {player.Name}`)
		return false
	end
	
	-- Merge with defaults
	local mergedData = mergeWithDefaults(loadedData)
	
	-- Store in memory
	playerData[player] = mergedData
	
	-- Cache in DataStoreManager (if available)
	if dataStoreManager then
		dataStoreManager:UpdateCachedData(player, mergedData)
	end
	
	-- Fire event
	PlayerDataEvents.DataLoaded:Fire(player, mergedData)
	
	-- Sync to client
	updateDataRemote:FireClient(player, mergedData)
	
	return true
end

-- Save player data
function PlayerDataManager:SavePlayerData(player: Player): boolean
	if not playerData[player] then
		warn(`[PlayerDataManager] No data to save for {player.Name}`)
		return false
	end
	
	if not dataStoreManager then
		-- Studio mode - just return success (data is in memory)
		PlayerDataEvents.DataSaved:Fire(player, true, nil)
		return true
	end
	
	local success = dataStoreManager:SaveData(player, playerData[player])
	
	if success then
		PlayerDataEvents.DataSaved:Fire(player, true, nil)
	else
		PlayerDataEvents.DataSaved:Fire(player, false, "Save failed")
	end
	
	return success
end

-- Get player data
function PlayerDataManager:GetPlayerData(player: Player): any?
	return playerData[player]
end

-- Update player data (with validation)
function PlayerDataManager:UpdatePlayerData(player: Player, key: string, value: any): boolean
	if not playerData[player] then
		warn(`[PlayerDataManager] No data for {player.Name}`)
		return false
	end
	
	local oldValue = playerData[player][key]
	
	-- Validate the update
	if not self:ValidateDataUpdate(key, value) then
		warn(`[PlayerDataManager] Invalid data update for {player.Name}: {key} = {value}`)
		return false
	end
	
	-- Update data
	playerData[player][key] = value
	
	-- Update cache (if available)
	if dataStoreManager then
		dataStoreManager:UpdateCachedData(player, playerData[player])
		-- Queue save
		dataStoreManager:QueueSave(player)
	end
	
	-- Fire event
	PlayerDataEvents.DataUpdated:Fire(player, key, oldValue, value)
	
	-- Sync to client
	updateDataRemote:FireClient(player, playerData[player])
	
	return true
end

-- Validate data update
function PlayerDataManager:ValidateDataUpdate(key: string, value: any): boolean
	-- Basic validation
	if PlayerData.Default[key] == nil then
		return false
	end
	
	-- Type checking
	local expectedType = type(PlayerData.Default[key])
	if type(value) ~= expectedType then
		return false
	end
	
	-- Number validation (ensure non-negative for currencies)
	if key == "Coins" or key == "Gems" or key == "CatTreats" or key == "XP" then
		if type(value) ~= "number" or value < 0 then
			return false
		end
	end
	
	-- Level validation
	if key == "Level" then
		if type(value) ~= "number" or value < 1 then
			return false
		end
	end
	
	return true
end

-- Reset player data to defaults
function PlayerDataManager:ResetPlayerData(player: Player): boolean
	playerData[player] = mergeWithDefaults(nil)
	
	-- Save immediately
	self:SavePlayerData(player)
	
	-- Fire event
	PlayerDataEvents.DataReset:Fire(player)
	
	-- Sync to client
	updateDataRemote:FireClient(player, playerData[player])
	
	return true
end

-- Remove player data
function PlayerDataManager:RemovePlayer(player: Player)
	-- Final save
	if playerData[player] then
		self:SavePlayerData(player)
	end
	
	-- Clean up
	playerData[player] = nil
	if dataStoreManager then
		dataStoreManager:RemovePlayer(player)
	end
end

-- Initialize player when they join
Players.PlayerAdded:Connect(function(player)
	-- Wait a bit for player to fully load
	task.wait(1)
	
	-- Load their data
	PlayerDataManager:LoadPlayerData(player)
end)

-- Save and remove player when they leave
Players.PlayerRemoving:Connect(function(player)
	PlayerDataManager:RemovePlayer(player)
end)

return PlayerDataManager

