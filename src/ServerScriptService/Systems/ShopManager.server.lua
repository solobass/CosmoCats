--[[
	ShopManager.server.lua
	Handles game pass and developer product purchases.
]]

local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PlayerDataManager = require(script.Parent.PlayerDataManager)
local EconomyManager = require(script.Parent.EconomyManager)
local ShopConfig = require(ReplicatedStorage.Shared.Config.ShopConfig)
local ShopEvents = require(ReplicatedStorage.Shared.Events.ShopEvents)
local EconomyEvents = require(ReplicatedStorage.Shared.Events.EconomyEvents)

local ShopManager = {}
ShopManager.__index = ShopManager

-- Purchase tracking (prevent duplicate processing)
local processingPurchases = {}

-- Create new ShopManager instance
function ShopManager.new()
	local self = setmetatable({}, ShopManager)
	return self
end

-- Initialize singleton
local shopManager = ShopManager.new()

-- Process game pass purchase
local function processGamePassPurchase(player: Player, gamePassId: number)
	-- Find game pass config
	local gamePassConfig = nil
	for key, config in pairs(ShopConfig.GamePasses) do
		if config.Id == gamePassId then
			gamePassConfig = config
			break
		end
	end
	
	if not gamePassConfig then
		warn(`[ShopManager] Unknown game pass ID: {gamePassId}`)
		return false
	end
	
	-- Get player data
	local playerData = PlayerDataManager:GetPlayerData(player)
	if not playerData then
		warn(`[ShopManager] No player data for {player.Name}`)
		return false
	end
	
	-- Check if already owned
	if playerData.GamePasses[gamePassId] then
		warn(`[ShopManager] Player {player.Name} already owns game pass {gamePassId}`)
		return false
	end
	
	-- Add to owned game passes
	if not playerData.GamePasses then
		playerData.GamePasses = {}
	end
	playerData.GamePasses[gamePassId] = {
		PurchasedAt = os.time(),
		Benefits = gamePassConfig.Benefits,
	}
	
	-- Update player data
	PlayerDataManager:UpdatePlayerData(player, "GamePasses", playerData.GamePasses)
	
	-- Fire event
	ShopEvents.GamePassPurchaseSucceeded:Fire(player, gamePassId)
	
	print(`[ShopManager] {player.Name} purchased game pass: {gamePassConfig.Name}`)
	return true
end

-- Process developer product purchase
local function processProductPurchase(player: Player, productId: number, purchaseId: string)
	-- Find product config
	local productConfig = nil
	for key, config in pairs(ShopConfig.Products) do
		if config.Id == productId then
			productConfig = config
			break
		end
	end
	
	if not productConfig then
		warn(`[ShopManager] Unknown product ID: {productId}`)
		return false
	end
	
	-- Process reward
	if productConfig.Reward.Currency then
		-- Currency reward
		local currencyType = productConfig.Reward.Currency
		local amount = productConfig.Reward.Amount
		
		EconomyManager:AddCurrency(player, currencyType, amount, `Product Purchase: {productConfig.Name}`)
		
	elseif productConfig.Reward.Type == "Booster" then
		-- Booster reward (to be implemented with inventory/booster system)
		warn(`[ShopManager] Booster rewards not yet implemented: {productConfig.Name}`)
		-- TODO: Add booster to player's active boosters
	end
	
	-- Fire event
	ShopEvents.ProductPurchaseSucceeded:Fire(player, productId, productConfig.Reward)
	
	print(`[ShopManager] {player.Name} purchased product: {productConfig.Name}`)
	return true
end

-- Handle game pass purchase
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player: Player, gamePassId: number, wasPurchased: boolean)
	if not wasPurchased then
		ShopEvents.GamePassPurchaseFailed:Fire(player, gamePassId, "Purchase cancelled")
		return
	end
	
	-- Check if already processing
	local purchaseKey = `gamepass_{player.UserId}_{gamePassId}`
	if processingPurchases[purchaseKey] then
		warn(`[ShopManager] Duplicate purchase detected for {player.Name}, game pass {gamePassId}`)
		return
	end
	
	processingPurchases[purchaseKey] = true
	
	-- Process purchase
	local success = processGamePassPurchase(player, gamePassId)
	
	if not success then
		ShopEvents.GamePassPurchaseFailed:Fire(player, gamePassId, "Processing failed")
	end
	
	-- Clean up after a delay
	task.delay(5, function()
		processingPurchases[purchaseKey] = nil
	end)
end)

-- Handle developer product purchase
MarketplaceService.PromptProductPurchaseFinished:Connect(function(player: Player, productId: number, wasPurchased: boolean)
	if not wasPurchased then
		ShopEvents.ProductPurchaseFailed:Fire(player, productId, "Purchase cancelled")
		return
	end
	
	-- Check if already processing
	local purchaseKey = `product_{player.UserId}_{productId}`
	if processingPurchases[purchaseKey] then
		warn(`[ShopManager] Duplicate purchase detected for {player.Name}, product {productId}`)
		return
	end
	
	processingPurchases[purchaseKey] = true
	
	-- Process purchase
	local success = processProductPurchase(player, productId, tostring(os.time()))
	
	if not success then
		ShopEvents.ProductPurchaseFailed:Fire(player, productId, "Processing failed")
	end
	
	-- Clean up after a delay
	task.delay(5, function()
		processingPurchases[purchaseKey] = nil
	end)
end)

-- Check if player owns a game pass
function ShopManager:PlayerOwnsGamePass(player: Player, gamePassId: number): boolean
	local playerData = PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return false
	end
	
	return playerData.GamePasses and playerData.GamePasses[gamePassId] ~= nil
end

-- Get game pass benefits for player
function ShopManager:GetGamePassBenefits(player: Player): {[string]: any}
	local playerData = PlayerDataManager:GetPlayerData(player)
	if not playerData or not playerData.GamePasses then
		return {}
	end
	
	local benefits = {}
	
	for gamePassId, _ in pairs(playerData.GamePasses) do
		-- Find game pass config
		for key, config in pairs(ShopConfig.GamePasses) do
			if config.Id == gamePassId then
				-- Merge benefits
				for benefitKey, benefitValue in pairs(config.Benefits) do
					benefits[benefitKey] = benefitValue
				end
				break
			end
		end
	end
	
	return benefits
end

-- Clean up when player leaves
Players.PlayerRemoving:Connect(function(player)
	local userId = tostring(player.UserId)
	
	-- Clean up processing purchases
	for key, _ in pairs(processingPurchases) do
		if string.find(key, userId) then
			processingPurchases[key] = nil
		end
	end
end)

return ShopManager


