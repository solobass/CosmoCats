--[[
	PlayerDataEvents.lua
	Events for player data changes (data loaded, saved, updated, etc.)
]]

local EventSystem = require(script.Parent.EventSystem)

local PlayerDataEvents = {}

-- Player data loaded (player, playerData)
PlayerDataEvents.DataLoaded = EventSystem.new("DataLoaded")

-- Player data saved (player, success, errorMessage)
PlayerDataEvents.DataSaved = EventSystem.new("DataSaved")

-- Player data updated (player, dataKey, oldValue, newValue)
PlayerDataEvents.DataUpdated = EventSystem.new("DataUpdated")

-- Player data reset (player)
PlayerDataEvents.DataReset = EventSystem.new("DataReset")

return PlayerDataEvents


