-- BedController.lua
-- Controls building/placing cat beds (Blanket, Box, Moon Rock, etc.).

local BedController = {}

--[[
    Bed placement flow (client perspective):

    1. Player opens Bed UI and selects a bed type they own.
    2. Player clicks "Place Bed" and enters placement mode (ghost preview).
    3. Player clicks on ground to confirm placement.
    4. Client sends request to server to place bed at position.

    Server validates:
        - Player owns bed type
        - Position is valid in allowed region
    Then replicates the bed in Workspace/Beds and associates ownership with player.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local BedTypes = require(script.Parent.BedTypes)

-- Placement state
local isInPlacementMode = false
local currentBedTypeId: string? = nil
local ghostModel: Model? = nil
local placementConnection: RBXScriptConnection? = nil
local clickConnection: RBXScriptConnection? = nil

-- Get or create RemoteEvent
local function getPlaceBedRemote()
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotesFolder then
		remotesFolder = Instance.new("Folder")
		remotesFolder.Name = "Remotes"
		remotesFolder.Parent = ReplicatedStorage
	end
	
	local bedRemotes = remotesFolder:FindFirstChild("BedRemotes")
	if not bedRemotes then
		bedRemotes = Instance.new("Folder")
		bedRemotes.Name = "BedRemotes"
		bedRemotes.Parent = remotesFolder
	end
	
	local placeBed = bedRemotes:FindFirstChild("PlaceBed")
	if not placeBed then
		placeBed = Instance.new("RemoteEvent")
		placeBed.Name = "PlaceBed"
		placeBed.Parent = bedRemotes
	end
	
	return placeBed
end

-- Create ghost preview model
local function createGhostModel(bedTypeId: string): Model?
	local bedData = BedTypes.GetBed(bedTypeId)
	if not bedData then
		warn("[BedController] Unknown bed type:", bedTypeId)
		return nil
	end
	
	-- TODO: Load actual bed model from ServerStorage or ReplicatedStorage
	-- For now, create a placeholder
	local ghost = Instance.new("Model")
	ghost.Name = "BedGhost"
	
	-- Make it semi-transparent
	local part = Instance.new("Part")
	part.Name = "Preview"
	part.Size = Vector3.new(4, 0.5, 4)
	part.Anchored = true
	part.CanCollide = false
	part.Transparency = 0.7
	part.BrickColor = BrickColor.new("Bright blue")
	part.Parent = ghost
	
	-- Add selection box or outline
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Adornee = part
	selectionBox.LineThickness = 0.1
	selectionBox.Transparency = 0.5
	selectionBox.Color3 = Color3.new(0, 1, 1)
	selectionBox.Parent = ghost
	
	return ghost
end

-- Update ghost position based on mouse/raycast
local function updateGhostPosition()
	if not ghostModel then
		return
	end
	
	local camera = workspace.CurrentCamera
	if not camera then
		return
	end
	
	local mouse = Players.LocalPlayer:GetMouse()
	local ray = camera:ScreenPointToRay(mouse.X, mouse.Y)
	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {ghostModel, Players.LocalPlayer.Character}
	
	local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 100, raycastParams)
	
	if raycastResult then
		ghostModel:SetPrimaryPartCFrame(CFrame.new(raycastResult.Position + Vector3.new(0, 0.25, 0)))
	end
end

function BedController.EnterPlacementMode(bedTypeId: string)
	if isInPlacementMode then
		BedController.ExitPlacementMode()
	end
	
	local bedData = BedTypes.GetBed(bedTypeId)
	if not bedData then
		warn("[BedController] Cannot place unknown bed type:", bedTypeId)
		return
	end
	
	isInPlacementMode = true
	currentBedTypeId = bedTypeId
	
	-- Create ghost model
	ghostModel = createGhostModel(bedTypeId)
	if ghostModel then
		ghostModel.Parent = workspace
	end
	
	-- Update ghost position on mouse move
	placementConnection = RunService.Heartbeat:Connect(function()
		updateGhostPosition()
	end)
	
	-- Handle placement click
	clickConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end
		
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			-- Confirm placement
			if ghostModel and ghostModel.PrimaryPart then
				local position = ghostModel.PrimaryPart.Position
				local placeBedRemote = getPlaceBedRemote()
				placeBedRemote:FireServer(bedTypeId, position)
				
				-- Exit placement mode after placing
				BedController.ExitPlacementMode()
			end
		elseif input.KeyCode == Enum.KeyCode.Escape then
			-- Cancel placement
			BedController.ExitPlacementMode()
		end
	end)
	
	print("[BedController] Entered placement mode for:", bedTypeId)
end

function BedController.ExitPlacementMode()
	if not isInPlacementMode then
		return
	end
	
	isInPlacementMode = false
	currentBedTypeId = nil
	
	-- Clean up ghost model
	if ghostModel then
		ghostModel:Destroy()
		ghostModel = nil
	end
	
	-- Disconnect events
	if placementConnection then
		placementConnection:Disconnect()
		placementConnection = nil
	end
	
	if clickConnection then
		clickConnection:Disconnect()
		clickConnection = nil
	end
	
	print("[BedController] Exited placement mode")
end

-- Check if currently in placement mode
function BedController.IsInPlacementMode(): boolean
	return isInPlacementMode
end

return BedController

