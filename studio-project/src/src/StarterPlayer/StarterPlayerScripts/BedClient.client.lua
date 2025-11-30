--[[
	BedClient.client.lua
	Client-side bed interaction and UI.
	Connects BedController to UI.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BedController = require(ReplicatedStorage.Modules.Beds.BedController)

local BedClient = {}

function BedClient:Init()
	-- BedController handles placement mode internally
	-- This is where we'd connect UI buttons to BedController methods
	
	-- Example UI connections (when UI is created):
	-- UI.PlaceBedButton.MouseButton1Click:Connect(function()
	--     local selectedBedType = UI.GetSelectedBedType()
	--     BedController.EnterPlacementMode(selectedBedType)
	-- end)
	--
	-- UI.CancelPlacementButton.MouseButton1Click:Connect(function()
	--     BedController.ExitPlacementMode()
	-- end)
	
	print("[BedClient] Initialized")
end

BedClient:Init()

