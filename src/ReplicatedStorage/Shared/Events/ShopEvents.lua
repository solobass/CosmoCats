--[[
	ShopEvents.lua
	Events for shop-related actions (game passes, developer products, etc.)
]]

local EventSystem = require(script.Parent.EventSystem)

local ShopEvents = {}

-- Game pass purchase attempted (player, gamePassId)
ShopEvents.GamePassPurchaseAttempted = EventSystem.new("GamePassPurchaseAttempted")

-- Game pass purchase succeeded (player, gamePassId)
ShopEvents.GamePassPurchaseSucceeded = EventSystem.new("GamePassPurchaseSucceeded")

-- Game pass purchase failed (player, gamePassId, reason)
ShopEvents.GamePassPurchaseFailed = EventSystem.new("GamePassPurchaseFailed")

-- Developer product purchase attempted (player, productId)
ShopEvents.ProductPurchaseAttempted = EventSystem.new("ProductPurchaseAttempted")

-- Developer product purchase succeeded (player, productId, amount)
ShopEvents.ProductPurchaseSucceeded = EventSystem.new("ProductPurchaseSucceeded")

-- Developer product purchase failed (player, productId, reason)
ShopEvents.ProductPurchaseFailed = EventSystem.new("ProductPurchaseFailed")

return ShopEvents


