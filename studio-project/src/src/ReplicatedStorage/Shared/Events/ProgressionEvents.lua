--[[
	ProgressionEvents.lua
	Events for progression-related actions (level up, XP gained, unlocks, etc.)
]]

local EventSystem = require(script.Parent.EventSystem)

local ProgressionEvents = {}

-- Level up (player, oldLevel, newLevel, rewards)
ProgressionEvents.LevelUp = EventSystem.new("LevelUp")

-- XP gained (player, amount, source)
ProgressionEvents.XPGained = EventSystem.new("XPGained")

-- Unlock achieved (player, unlockId, unlockType)
ProgressionEvents.UnlockAchieved = EventSystem.new("UnlockAchieved")

-- Progression updated (player, progressionData)
ProgressionEvents.ProgressionUpdated = EventSystem.new("ProgressionUpdated")

return ProgressionEvents

