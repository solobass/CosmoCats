--[[
	ClanClient.client.lua
	Client-side clan UI and interactions.
	Connects ClanController to UI.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ClanController = require(ReplicatedStorage.Modules.Clans.ClanController)

local ClanClient = {}

function ClanClient:Init()
	-- ClanController already initializes RemoteEvent connections
	-- This is where we'd connect UI buttons to ClanController methods
	
	-- Example UI connections (when UI is created):
	-- UI.CreateClanButton.MouseButton1Click:Connect(function()
	--     ClanController.RequestCreateClan(clanName, color, iconId)
	-- end)
	
	print("[ClanClient] Initialized")
	print("[ClanClient] In clan:", ClanController.IsInClan())
end

ClanClient:Init()

