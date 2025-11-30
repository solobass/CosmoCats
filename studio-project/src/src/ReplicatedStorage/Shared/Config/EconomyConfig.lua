--[[
	EconomyConfig.lua
	Configuration for economy system (currency limits, transaction limits, etc.)
]]

local EconomyConfig = {}

-- Currency limits
EconomyConfig.MaxCoins = 999999999
EconomyConfig.MaxGems = 999999
EconomyConfig.MaxCatTreats = 999999
EconomyConfig.MaxStardust = 999999

-- Transaction limits (per minute)
EconomyConfig.MaxTransactionsPerMinute = 60
EconomyConfig.TransactionCooldown = 1 -- seconds

-- Currency earning rates (can be modified by game passes/boosts)
EconomyConfig.BaseEarningRates = {
	CatTreatValue = 1, -- Coins per CatTreat
	XPPerCatTreat = 1,
}

-- Minimum/maximum transaction amounts
EconomyConfig.MinTransactionAmount = 1
EconomyConfig.MaxTransactionAmount = 1000000

return EconomyConfig

