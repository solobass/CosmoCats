--[[
	BedServer.lua
	Handles server-side bed interaction validation and rest system.
	Manages bed placement, ownership, and rest mechanics.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local BedServer = {}
BedServer.__index = BedServer

-- ============================================
-- REMOTE EVENTS
-- ============================================

local function getRemotes()
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
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = bedRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = bedRemotes
		end
		return remote
	end
	
	return {
		PlaceBed = getOrCreateRemote("PlaceBed", "RemoteEvent"),
		RemoveBed = getOrCreateRemote("RemoveBed", "RemoteEvent"),
		UseBed = getOrCreateRemote("UseBed", "RemoteEvent"),
		LeaveBed = getOrCreateRemote("LeaveBed", "RemoteEvent"),
	}
end

local remotes = getRemotes()

-- ============================================
-- BED MANAGEMENT
-- ============================================

local playerBeds = {} -- [userId] = bedModel
local bedOwners = {} -- [bedInstance] = userId

-- Bed types (from INTERACTION_SYSTEMS_BIBLE.md)
local BED_TYPES = {
	"Blanket",
	"Box",
	"MoonRock",
	"NebulaHammock",
	"StarCradle", -- Prestige
}

remotes.PlaceBed.OnServerEvent:Connect(function(player: Player, bedType: string, position: Vector3)
	-- Validate bed type
	if not table.find(BED_TYPES, bedType) then
		warn(`[BedServer] Invalid bed type: {bedType}`)
		return
	end
	
	-- TODO: Check if player has unlocked this bed type
	-- TODO: Check if player has reached bed limit
	-- TODO: Validate position (not in restricted areas)
	
	-- Find bed model in ReplicatedStorage
	local bedModel = ReplicatedStorage:FindFirstChild("CosmoCatsModels") 
		and ReplicatedStorage.CosmoCatsModels:FindFirstChild("Beds")
		and ReplicatedStorage.CosmoCatsModels.Beds:FindFirstChild(bedType)
	
	if not bedModel then
		warn(`[BedServer] Bed model not found: {bedType}`)
		return
	end
	
	-- Clone and place bed
	local bed = bedModel:Clone()
	bed:SetPrimaryPartCFrame(CFrame.new(position))
	bed.Parent = Workspace
	
	-- Store ownership
	playerBeds[tostring(player.UserId)] = bed
	bedOwners[bed] = player.UserId
	
	print(`[BedServer] {player.Name} placed {bedType} bed at {position}`)
end)

remotes.UseBed.OnServerEvent:Connect(function(player: Player, bedInstance: Instance)
	-- Validate bed exists
	if not bedInstance or not bedInstance.Parent then
		return
	end
	
	-- TODO: Apply rest state to player
	-- TODO: Start rest animation
	-- TODO: Apply rest benefits (XP, Stardust over time)
	
	print(`[BedServer] {player.Name} using bed`)
end)

remotes.LeaveBed.OnServerEvent:Connect(function(player: Player)
	-- TODO: Remove rest state
	-- TODO: Stop rest animation
	
	print(`[BedServer] {player.Name} left bed`)
end)

-- ============================================
-- INITIALIZATION
-- ============================================

print("[BedServer] Initialized - Bed system ready")
print("  - Bed types: " .. #BED_TYPES)
print("  - Bed placement: Active")
print("  - Bed interactions: Active")

return BedServer
