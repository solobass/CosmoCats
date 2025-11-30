--[[
	PlayerData.lua
	Type definitions and default data structure for player data
]]

local PlayerData = {}

-- Default player data structure
PlayerData.Default = {
	-- Species
	SpeciesId = "GALAXY_KITTEN",
	
	-- Currency
	Coins = 0,
	Gems = 0,
	CatTreats = 0,
	Stardust = 0,
	
	-- Progression
	Level = 1,
	XP = 0,
	TotalXP = 0,
	
	-- Inventory
	Inventory = {},
	EquippedItems = {},
	
	-- Game Passes (owned)
	GamePasses = {},
	
	-- Settings
	Settings = {
		MusicVolume = 0.5,
		SFXVolume = 0.5,
		CameraSensitivity = 1.0,
	},
	
	-- Statistics
	Stats = {
		TotalPlayTime = 0,
		CatTreatsCollected = 0,
		TimesLeveledUp = 0,
		TotalCoinsEarned = 0,
		TotalGemsEarned = 0,
	},
	
	-- Data version for migration
	DataVersion = 1,
}

-- Currency types
PlayerData.CurrencyTypes = {
	COINS = "Coins",
	GEMS = "Gems",
	CATTREATS = "CatTreats",
	STARDUST = "Stardust",
}

-- Item types
PlayerData.ItemTypes = {
	AVATAR = "Avatar",
	EFFECT = "Effect",
	BOOST = "Boost",
	COSMETIC = "Cosmetic",
}

return PlayerData

