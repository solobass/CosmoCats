--[[
	EconomyEvents.lua
	Events for economy-related actions (currency changes, transactions, etc.)
]]

local EventSystem = require(script.Parent.EventSystem)

local EconomyEvents = {}

-- Currency changed (player, currencyType, oldAmount, newAmount, reason)
EconomyEvents.CurrencyChanged = EventSystem.new("CurrencyChanged")

-- Transaction completed (player, transactionType, amount, success, errorMessage)
EconomyEvents.TransactionCompleted = EventSystem.new("TransactionCompleted")

-- Purchase attempted (player, itemId, itemType, cost)
EconomyEvents.PurchaseAttempted = EventSystem.new("PurchaseAttempted")

-- Purchase succeeded (player, itemId, itemType, cost)
EconomyEvents.PurchaseSucceeded = EventSystem.new("PurchaseSucceeded")

-- Purchase failed (player, itemId, itemType, reason)
EconomyEvents.PurchaseFailed = EventSystem.new("PurchaseFailed")

return EconomyEvents


