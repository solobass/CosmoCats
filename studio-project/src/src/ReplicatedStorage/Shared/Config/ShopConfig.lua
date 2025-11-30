--[[
	ShopConfig.lua
	Configuration for shop items (game passes, developer products, etc.)
]]

local ShopConfig = {}

-- Game Passes (one-time purchases)
ShopConfig.GamePasses = {
	-- VIP Pass
	VIPPass = {
		Id = 0, -- Set this to your actual game pass ID
		Name = "VIP Pass",
		Description = "2x coins, exclusive cosmetics, and more!",
		Benefits = {
			CoinMultiplier = 2,
			ExclusiveCosmetics = true,
		},
	},
	
	-- Speed Boost
	SpeedBoost = {
		Id = 0, -- Set this to your actual game pass ID
		Name = "Speed Boost",
		Description = "Permanent movement speed increase",
		Benefits = {
			SpeedMultiplier = 1.5,
		},
	},
	
	-- Collector Pass
	CollectorPass = {
		Id = 0, -- Set this to your actual game pass ID
		Name = "Collector Pass",
		Description = "2x CatTreat spawn rate",
		Benefits = {
			SpawnRateMultiplier = 2,
		},
	},
	
	-- Premium Avatar Pack
	PremiumAvatarPack = {
		Id = 0, -- Set this to your actual game pass ID
		Name = "Premium Avatar Pack",
		Description = "Unlock all base avatars",
		Benefits = {
			UnlockAllAvatars = true,
		},
	},
	
	-- Auto-Collect
	AutoCollect = {
		Id = 0, -- Set this to your actual game pass ID
		Name = "Auto-Collect",
		Description = "Automatically collect nearby items",
		Benefits = {
			AutoCollectEnabled = true,
			AutoCollectRange = 20,
		},
	},
}

-- Developer Products (consumables)
ShopConfig.Products = {
	-- Coin Packs
	CoinPack100 = {
		Id = 0, -- Set this to your actual product ID
		Name = "100 Coins",
		Description = "Get 100 coins",
		Reward = {
			Currency = "Coins",
			Amount = 100,
		},
	},
	
	CoinPack500 = {
		Id = 0,
		Name = "500 Coins",
		Description = "Get 500 coins",
		Reward = {
			Currency = "Coins",
			Amount = 500,
		},
	},
	
	CoinPack1000 = {
		Id = 0,
		Name = "1000 Coins",
		Description = "Get 1000 coins",
		Reward = {
			Currency = "Coins",
			Amount = 1000,
		},
	},
	
	CoinPack5000 = {
		Id = 0,
		Name = "5000 Coins",
		Description = "Get 5000 coins",
		Reward = {
			Currency = "Coins",
			Amount = 5000,
		},
	},
	
	-- Gem Packs
	GemPack10 = {
		Id = 0,
		Name = "10 Gems",
		Description = "Get 10 gems",
		Reward = {
			Currency = "Gems",
			Amount = 10,
		},
	},
	
	GemPack50 = {
		Id = 0,
		Name = "50 Gems",
		Description = "Get 50 gems",
		Reward = {
			Currency = "Gems",
			Amount = 50,
		},
	},
	
	GemPack100 = {
		Id = 0,
		Name = "100 Gems",
		Description = "Get 100 gems",
		Reward = {
			Currency = "Gems",
			Amount = 100,
		},
	},
	
	GemPack500 = {
		Id = 0,
		Name = "500 Gems",
		Description = "Get 500 gems",
		Reward = {
			Currency = "Gems",
			Amount = 500,
		},
	},
	
	-- Boosters
	XPBooster1Hour = {
		Id = 0,
		Name = "XP Booster (1 Hour)",
		Description = "2x XP for 1 hour",
		Reward = {
			Type = "Booster",
			BoosterType = "XP",
			Multiplier = 2,
			Duration = 3600, -- seconds
		},
	},
	
	SpeedPotion = {
		Id = 0,
		Name = "Speed Potion",
		Description = "Temporary speed boost",
		Reward = {
			Type = "Booster",
			BoosterType = "Speed",
			Multiplier = 1.5,
			Duration = 300, -- 5 minutes
		},
	},
	
	LuckyCat = {
		Id = 0,
		Name = "Lucky Cat",
		Description = "Increased rare item spawns (1 hour)",
		Reward = {
			Type = "Booster",
			BoosterType = "Lucky",
			Multiplier = 2,
			Duration = 3600,
		},
	},
}

return ShopConfig

