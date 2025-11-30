--[[
	EmoteClient.client.lua
	Client-side emote handling and input.
	Connects EmoteController to UI and keybinds.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local EmoteController = require(ReplicatedStorage.Modules.Emotes.EmoteController)

local EmoteClient = {}

-- Keybind mapping (1-9 keys to emotes)
local keybindToEmote = {
	[Enum.KeyCode.One] = "SIT",
	[Enum.KeyCode.Two] = "LAY",
	[Enum.KeyCode.Three] = "LOAF",
	[Enum.KeyCode.Four] = "GROOM",
	[Enum.KeyCode.Five] = "TAIL_FLICK",
	-- TODO: Add more keybinds
}

function EmoteClient:Init()
	-- Connect keybinds
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		
		local emoteId = keybindToEmote[input.KeyCode]
		if emoteId then
			EmoteController.PlayEmote(emoteId)
		end
	end)
	
	-- TODO: Connect to EmoteBar UI buttons
	-- TODO: Connect to RemoteEvents for server validation if needed
	
	print("[EmoteClient] Initialized")
end

EmoteClient:Init()

