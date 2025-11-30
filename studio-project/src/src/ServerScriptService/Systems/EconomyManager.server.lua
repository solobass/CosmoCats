--[[
	EconomyManager.server.lua
	Manages currency transactions with validation and anti-cheat measures.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Safely require modules (may not exist yet)
local success1, PlayerDataManager = pcall(function() return require(script.Parent.PlayerDataManager) end)
local success2, PlayerData = pcall(function() return require(ReplicatedStorage:WaitForChild("Shared", 1):WaitForChild("Types", 1):WaitForChild("PlayerData", 1)) end)
local success3, EconomyConfig = pcall(function() return require(ReplicatedStorage:WaitForChild("Shared", 1):WaitForChild("Config", 1):WaitForChild("EconomyConfig", 1)) end)
local success4, EconomyEvents = pcall(function() return require(ReplicatedStorage:WaitForChild("Shared", 1):WaitForChild("Events", 1):WaitForChild("EconomyEvents", 1)) end)

PlayerDataManager = success1 and PlayerDataManager or nil
PlayerData = success2 and PlayerData or nil
EconomyConfig = success3 and EconomyConfig or nil
EconomyEvents = success4 and EconomyEvents or nil

local EconomyManager = {}
EconomyManager.__index = EconomyManager

-- Transaction tracking (for rate limiting)
local transactionHistory = {}
local lastTransactionTime = {}

-- Create new EconomyManager instance
function EconomyManager.new()
	local self = setmetatable({}, EconomyManager)
	return self
end

-- Initialize singleton
local economyManager = EconomyManager.new()

-- Check if player can make a transaction (rate limiting)
local function canMakeTransaction(player: Player): boolean
	local userId = tostring(player.UserId)
	local currentTime = os.time()
	
	-- Check cooldown
	if lastTransactionTime[userId] then
		local timeSinceLastTransaction = currentTime - lastTransactionTime[userId]
		if timeSinceLastTransaction < EconomyConfig.TransactionCooldown then
			return false
		end
	end
	
	-- Check transaction count in last minute
	if transactionHistory[userId] then
		local recentTransactions = 0
		for _, timestamp in ipairs(transactionHistory[userId]) do
			if currentTime - timestamp < 60 then
				recentTransactions = recentTransactions + 1
			end
		end
		
		if recentTransactions >= EconomyConfig.MaxTransactionsPerMinute then
			return false
		end
	end
	
	return true
end

-- Record transaction
local function recordTransaction(player: Player)
	local userId = tostring(player.UserId)
	local currentTime = os.time()
	
	if not transactionHistory[userId] then
		transactionHistory[userId] = {}
	end
	
	table.insert(transactionHistory[userId], currentTime)
	lastTransactionTime[userId] = currentTime
	
	-- Clean old transactions (older than 1 minute)
	local cleaned = {}
	for _, timestamp in ipairs(transactionHistory[userId]) do
		if currentTime - timestamp < 60 then
			table.insert(cleaned, timestamp)
		end
	end
	transactionHistory[userId] = cleaned
end

-- Validate currency amount
local function validateCurrencyAmount(amount: number): boolean
	if type(amount) ~= "number" then
		return false
	end
	
	if amount < EconomyConfig.MinTransactionAmount then
		return false
	end
	
	if amount > EconomyConfig.MaxTransactionAmount then
		return false
	end
	
	return true
end

-- Get currency amount
function EconomyManager:GetCurrency(player: Player, currencyType: string): number
	local playerData = PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return 0
	end
	
	return playerData[currencyType] or 0
end

-- Add currency (with validation)
function EconomyManager:AddCurrency(player: Player, currencyType: string, amount: number, reason: string?): boolean
	if not canMakeTransaction(player) then
		warn(`[EconomyManager] Rate limit exceeded for {player.Name}`)
		return false
	end
	
	if not validateCurrencyAmount(amount) then
		warn(`[EconomyManager] Invalid amount for {player.Name}: {amount}`)
		return false
	end
	
	local playerData = PlayerDataManager:GetPlayerData(player)
	if not playerData then
		warn(`[EconomyManager] No player data for {player.Name}`)
		return false
	end
	
	-- Get current amount
	local currentAmount = playerData[currencyType] or 0
	
	-- Calculate new amount
	local newAmount = currentAmount + amount
	
	-- Check limits
	local maxAmount = EconomyConfig["Max" .. currencyType]
	if maxAmount and newAmount > maxAmount then
		newAmount = maxAmount
		amount = newAmount - currentAmount
	end
	
	-- Update player data
	local success = PlayerDataManager:UpdatePlayerData(player, currencyType, newAmount)
	
	if success then
		recordTransaction(player)
		
		-- Fire event
		EconomyEvents.CurrencyChanged:Fire(player, currencyType, currentAmount, newAmount, reason or "Added")
		EconomyEvents.TransactionCompleted:Fire(player, "Add", amount, true, nil)
		
		return true
	else
		EconomyEvents.TransactionCompleted:Fire(player, "Add", amount, false, "Update failed")
		return false
	end
end

-- Remove currency (with validation)
function EconomyManager:RemoveCurrency(player: Player, currencyType: string, amount: number, reason: string?): boolean
	if not canMakeTransaction(player) then
		warn(`[EconomyManager] Rate limit exceeded for {player.Name}`)
		return false
	end
	
	if not validateCurrencyAmount(amount) then
		warn(`[EconomyManager] Invalid amount for {player.Name}: {amount}`)
		return false
	end
	
	local playerData = PlayerDataManager:GetPlayerData(player)
	if not playerData then
		warn(`[EconomyManager] No player data for {player.Name}`)
		return false
	end
	
	-- Get current amount
	local currentAmount = playerData[currencyType] or 0
	
	-- Check if player has enough
	if currentAmount < amount then
		warn(`[EconomyManager] Insufficient {currencyType} for {player.Name}: {currentAmount} < {amount}`)
		EconomyEvents.TransactionCompleted:Fire(player, "Remove", amount, false, "Insufficient funds")
		return false
	end
	
	-- Calculate new amount
	local newAmount = currentAmount - amount
	
	-- Update player data
	local success = PlayerDataManager:UpdatePlayerData(player, currencyType, newAmount)
	
	if success then
		recordTransaction(player)
		
		-- Fire event
		EconomyEvents.CurrencyChanged:Fire(player, currencyType, currentAmount, newAmount, reason or "Removed")
		EconomyEvents.TransactionCompleted:Fire(player, "Remove", amount, true, nil)
		
		return true
	else
		EconomyEvents.TransactionCompleted:Fire(player, "Remove", amount, false, "Update failed")
		return false
	end
end

-- Transfer currency between players
function EconomyManager:TransferCurrency(fromPlayer: Player, toPlayer: Player, currencyType: string, amount: number, reason: string?): boolean
	-- Remove from sender
	if not self:RemoveCurrency(fromPlayer, currencyType, amount, reason or "Transfer") then
		return false
	end
	
	-- Add to receiver
	if not self:AddCurrency(toPlayer, currencyType, amount, reason or "Received") then
		-- Rollback: add back to sender
		self:AddCurrency(fromPlayer, currencyType, amount, "Rollback")
		return false
	end
	
	return true
end

-- Check if player can afford
function EconomyManager:CanAfford(player: Player, currencyType: string, amount: number): boolean
	local currentAmount = self:GetCurrency(player, currencyType)
	return currentAmount >= amount
end

-- Clean up player data when they leave
Players.PlayerRemoving:Connect(function(player)
	local userId = tostring(player.UserId)
	transactionHistory[userId] = nil
	lastTransactionTime[userId] = nil
end)

return EconomyManager

