--[[
	InventoryEvents.lua
	Events for inventory-related actions (items added, removed, equipped, etc.)
]]

local EventSystem = require(script.Parent.EventSystem)

local InventoryEvents = {}

-- Item added to inventory (player, itemId, itemData)
InventoryEvents.ItemAdded = EventSystem.new("ItemAdded")

-- Item removed from inventory (player, itemId)
InventoryEvents.ItemRemoved = EventSystem.new("ItemRemoved")

-- Item equipped (player, itemId, slot)
InventoryEvents.ItemEquipped = EventSystem.new("ItemEquipped")

-- Item unequipped (player, itemId, slot)
InventoryEvents.ItemUnequipped = EventSystem.new("ItemUnequipped")

-- Inventory updated (player, inventoryData)
InventoryEvents.InventoryUpdated = EventSystem.new("InventoryUpdated")

return InventoryEvents

