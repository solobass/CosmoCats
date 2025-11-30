-- CurrencyServer.lua
-- Handles Stardust balances, time-based rewards, and purchase validation.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local GameConfig = require(Modules.Config.GameConfig)

-- Integrate with existing systems
local ServerScriptService = game:GetService("ServerScriptService")
local Systems = ServerScriptService:FindFirstChild("Systems")
local EconomyManager = Systems and require(Systems.EconomyManager) or nil
local PlayerDataManager = Systems and require(Systems.PlayerDataManager) or nil

local CurrencyServer = {}

local playerStardust: { [Player]: number } = {}
local stardustLoops: { [Player]: boolean } = {} -- Track running loops for cleanup (flag-based)

-- Get or create RemoteEvents
local function getRemotes()
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotesFolder then
		remotesFolder = Instance.new("Folder")
		remotesFolder.Name = "Remotes"
		remotesFolder.Parent = ReplicatedStorage
	end
	
	local currencyRemotes = remotesFolder:FindFirstChild("CurrencyRemotes")
	if not currencyRemotes then
		currencyRemotes = Instance.new("Folder")
		currencyRemotes.Name = "CurrencyRemotes"
		currencyRemotes.Parent = remotesFolder
	end
	
	local stardustUpdated = currencyRemotes:FindFirstChild("StardustUpdated")
	if not stardustUpdated then
		stardustUpdated = Instance.new("RemoteEvent")
		stardustUpdated.Name = "StardustUpdated"
		stardustUpdated.Parent = currencyRemotes
	end
	
	local getStardustBalance = currencyRemotes:FindFirstChild("GetStardustBalance")
	if not getStardustBalance then
		getStardustBalance = Instance.new("RemoteFunction")
		getStardustBalance.Name = "GetStardustBalance"
		getStardustBalance.Parent = currencyRemotes
	end
	
	return stardustUpdated, getStardustBalance
end

local stardustUpdatedRemote, getStardustBalanceRemote = getRemotes()

-- Update client with new balance
local function updateClientBalance(player: Player, balance: number)
	stardustUpdatedRemote:FireClient(player, balance)
end

local function initPlayerBalance(player: Player)
	-- TODO: Load from DataStore or default to 0
	-- Use PlayerDataManager if available
	local balance = 0
	
	if PlayerDataManager then
		local playerData = PlayerDataManager:GetPlayerData(player)
		if playerData then
			balance = playerData.Stardust or 0
		end
	end
	
	playerStardust[player] = balance
	updateClientBalance(player, balance)
	
	print("[CurrencyServer] Initialized balance for", player.Name, ":", balance)
end

local function startStardustLoop(player: Player)
	-- Stop any existing loop
	if stardustLoops[player] then
		stardustLoops[player] = false -- Signal to stop
		stardustLoops[player] = nil
	end
	
	-- Create a flag to track if loop should continue
	local shouldContinue = true
	stardustLoops[player] = shouldContinue
	
	task.spawn(function()
		while player.Parent and shouldContinue do
			task.wait(GameConfig.StardustIntervalSeconds)
			
			-- Check if we should continue (player might have left)
			if not stardustLoops[player] then
				break
			end
			
			if player.Parent then
				CurrencyServer.AddStardust(player, GameConfig.StardustPerInterval)
			end
		end
		
		-- Clean up
		if stardustLoops[player] == shouldContinue then
			stardustLoops[player] = nil
		end
	end)
end

function CurrencyServer.GetBalance(player: Player): number
	return playerStardust[player] or 0
end

function CurrencyServer.AddStardust(player: Player, amount: number)
	local current = CurrencyServer.GetBalance(player)
	local newAmount = current + amount
	
	playerStardust[player] = newAmount
	
	-- Update via EconomyManager if available (for consistency)
	if EconomyManager then
		EconomyManager:AddCurrency(player, "Stardust", amount, "Time-based reward")
	else
		-- Update PlayerData directly
		if PlayerDataManager then
			PlayerDataManager:UpdatePlayerData(player, "Stardust", newAmount)
		end
	end
	
	-- Fire RemoteEvent to update client UI
	updateClientBalance(player, newAmount)
	
	print("[CurrencyServer] Added", amount, "Stardust to", player.Name, "- New balance:", newAmount)
end

function CurrencyServer.TryPurchase(player: Player, cost: number): boolean
	local current = CurrencyServer.GetBalance(player)
	
	if current < cost then
		warn("[CurrencyServer] Player", player.Name, "insufficient Stardust:", current, "<", cost)
		return false
	end
	
	local newAmount = current - cost
	playerStardust[player] = newAmount
	
	-- Update via EconomyManager if available
	if EconomyManager then
		EconomyManager:RemoveCurrency(player, "Stardust", cost, "Purchase")
	else
		-- Update PlayerData directly
		if PlayerDataManager then
			PlayerDataManager:UpdatePlayerData(player, "Stardust", newAmount)
		end
	end
	
	-- Fire RemoteEvent to update balance
	updateClientBalance(player, newAmount)
	
	print("[CurrencyServer] Player", player.Name, "purchased for", cost, "Stardust - New balance:", newAmount)
	return true
end

-- Handle balance queries
getStardustBalanceRemote.OnServerInvoke = function(player: Player)
	return CurrencyServer.GetBalance(player)
end

Players.PlayerAdded:Connect(function(player: Player)
	initPlayerBalance(player)
	startStardustLoop(player)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	-- TODO: Save playerStardust[player] to DataStore, then cleanup
	-- PlayerDataManager should handle this automatically, but ensure it's saved
	if PlayerDataManager and playerStardust[player] then
		PlayerDataManager:UpdatePlayerData(player, "Stardust", playerStardust[player])
		PlayerDataManager:SavePlayerData(player)
	end
	
	-- Stop stardust loop (flag-based, no Disconnect() call needed)
	if stardustLoops[player] then
		stardustLoops[player] = false
		stardustLoops[player] = nil
	end
	
	-- Cleanup
	playerStardust[player] = nil
end)

-- Initialize existing players
for _, player in ipairs(Players:GetPlayers()) do
	initPlayerBalance(player)
	startStardustLoop(player)
end

print("[CurrencyServer] Initialized")

return CurrencyServer

