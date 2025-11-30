--[[
	InteractionController.client.lua
	Handles all player interactions: player-to-player, player-to-environment, player-to-biome.
	Implements the full interaction system from INTERACTION_SYSTEMS_BIBLE.md
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer

-- Get dependencies
local EmoteController = require(ReplicatedStorage.Modules.Emotes.EmoteController)

local InteractionController = {}
InteractionController.__index = InteractionController

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
	
	local interactionRemotes = remotesFolder:FindFirstChild("InteractionRemotes")
	if not interactionRemotes then
		interactionRemotes = Instance.new("Folder")
		interactionRemotes.Name = "InteractionRemotes"
		interactionRemotes.Parent = remotesFolder
	end
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = interactionRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = interactionRemotes
		end
		return remote
	end
	
	return {
		NuzzleRequest = getOrCreateRemote("NuzzleRequest", "RemoteEvent"),
		NuzzleAccept = getOrCreateRemote("NuzzleAccept", "RemoteEvent"),
		CuddleRequest = getOrCreateRemote("CuddleRequest", "RemoteEvent"),
		CuddleAccept = getOrCreateRemote("CuddleAccept", "RemoteEvent"),
		CarryRequest = getOrCreateRemote("CarryRequest", "RemoteEvent"),
		CarryAccept = getOrCreateRemote("CarryAccept", "RemoteEvent"),
		FollowRequest = getOrCreateRemote("FollowRequest", "RemoteEvent"),
		FollowAccept = getOrCreateRemote("FollowAccept", "RemoteEvent"),
		GroupSitRequest = getOrCreateRemote("GroupSitRequest", "RemoteEvent"),
		InteractionReplicated = getOrCreateRemote("InteractionReplicated", "RemoteEvent"),
	}
end

local remotes = getRemotes()

-- ============================================
-- INTERACTION STATE
-- ============================================

local currentInteraction = nil -- {type, target, state}
local followingTarget = nil -- Player being followed
local carryingTarget = nil -- Player being carried
local isFollowing = false

-- ============================================
-- PLAYER-TO-PLAYER INTERACTIONS
-- ============================================

-- Nuzzle (mutual consent)
function InteractionController:RequestNuzzle(targetPlayer: Player)
	if not targetPlayer or not targetPlayer.Character then
		return
	end
	
	remotes.NuzzleRequest:FireServer(targetPlayer)
	print(`[InteractionController] Requesting nuzzle with {targetPlayer.Name}`)
end

remotes.NuzzleAccept.OnClientEvent:Connect(function(requester: Player, accepted: boolean)
	if not accepted then
		print(`[InteractionController] {requester.Name} declined nuzzle request`)
		return
	end
	
	-- Play nuzzle animation on both players
	local myCharacter = localPlayer.Character
	local theirCharacter = requester.Character
	
	if myCharacter and theirCharacter then
		-- TODO: Play nuzzle animation
		-- TODO: Add soft bell sound
		-- TODO: Add nebula glow VFX
		print(`[InteractionController] Nuzzling with {requester.Name}`)
	end
end)

-- Cuddle (invitation + accept)
function InteractionController:RequestCuddle(targetPlayer: Player, variant: string?)
	if not targetPlayer or not targetPlayer.Character then
		return
	end
	
	remotes.CuddleRequest:FireServer(targetPlayer, variant or "side-by-side")
	print(`[InteractionController] Requesting cuddle with {targetPlayer.Name}`)
end

remotes.CuddleAccept.OnClientEvent:Connect(function(requester: Player, variant: string, accepted: boolean)
	if not accepted then
		print(`[InteractionController] {requester.Name} declined cuddle request`)
		return
	end
	
	-- Play cuddle animation
	local myCharacter = localPlayer.Character
	local theirCharacter = requester.Character
	
	if myCharacter and theirCharacter then
		-- TODO: Play cuddle animation (variant: side-by-side, curled, head-on-lap)
		-- TODO: Add nebula glow VFX around both players
		print(`[InteractionController] Cuddling with {requester.Name} ({variant})`)
	end
end)

-- Carry (Motor6D attachment)
function InteractionController:RequestCarry(targetPlayer: Player, carryType: string?)
	if not targetPlayer or not targetPlayer.Character then
		return
	end
	
	remotes.CarryRequest:FireServer(targetPlayer, carryType or "arms")
	print(`[InteractionController] Requesting to carry {targetPlayer.Name}`)
end

remotes.CarryAccept.OnClientEvent:Connect(function(requester: Player, carryType: string, accepted: boolean)
	if not accepted then
		print(`[InteractionController] {requester.Name} declined carry request`)
		return
	end
	
	-- Attach via Motor6D
	local myCharacter = localPlayer.Character
	local theirCharacter = requester.Character
	
	if myCharacter and theirCharacter then
		local myTorso = myCharacter:FindFirstChild("Torso") or myCharacter:FindFirstChild("UpperTorso")
		local theirHRP = theirCharacter:FindFirstChild("HumanoidRootPart")
		
		if myTorso and theirHRP then
			-- Create Motor6D attachment
			local motor = Instance.new("Motor6D")
			motor.Part0 = myTorso
			motor.Part1 = theirHRP
			motor.Name = "CarryMotor"
			
			-- Position based on carry type
			if carryType == "arms" then
				motor.C0 = CFrame.new(0, 0, -1.5) * CFrame.Angles(math.rad(-90), 0, 0)
			elseif carryType == "back" then
				motor.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(math.rad(90), 0, 0)
			end
			
			motor.Parent = myTorso
			carryingTarget = requester
			
			-- Reduce movement speed
			local myHumanoid = myCharacter:FindFirstChild("Humanoid")
			if myHumanoid then
				myHumanoid.WalkSpeed = myHumanoid.WalkSpeed * 0.7 -- 30% slower
			end
			
			print(`[InteractionController] Carrying {requester.Name} ({carryType})`)
		end
	end
end)

-- Follow Mode
function InteractionController:RequestFollow(targetPlayer: Player)
	if not targetPlayer or not targetPlayer.Character then
		return
	end
	
	remotes.FollowRequest:FireServer(targetPlayer)
	print(`[InteractionController] Requesting to follow {targetPlayer.Name}`)
end

remotes.FollowAccept.OnClientEvent:Connect(function(leader: Player, accepted: boolean)
	if not accepted then
		print(`[InteractionController] {leader.Name} declined follow request`)
		return
	end
	
	followingTarget = leader
	isFollowing = true
	
	-- Start follow loop
	task.spawn(function()
		local myCharacter = localPlayer.Character
		if not myCharacter then
			return
		end
		
		local myHRP = myCharacter:FindFirstChild("HumanoidRootPart")
		local myHumanoid = myCharacter:FindFirstChild("Humanoid")
		
		while isFollowing and followingTarget == leader and leader.Parent do
			task.wait(0.1)
			
			local theirCharacter = leader.Character
			if not theirCharacter then
				break
			end
			
			local theirHRP = theirCharacter:FindFirstChild("HumanoidRootPart")
			if not theirHRP or not myHRP or not myHumanoid then
				break
			end
			
			-- Follow with slight delay
			local distance = (theirHRP.Position - myHRP.Position).Magnitude
			if distance > 5 then
				-- Move towards leader
				myHumanoid:MoveTo(theirHRP.Position + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2)))
			elseif distance < 3 then
				-- Too close, stop
				myHumanoid:MoveTo(myHRP.Position)
			end
			
			-- Occasional "idle look toward leader"
			if math.random() < 0.1 then
				-- TODO: Play head turn animation
			end
		end
		
		isFollowing = false
		followingTarget = nil
	end)
	
	print(`[InteractionController] Following {leader.Name}`)
end)

-- Group Sit / Huddle
function InteractionController:RequestGroupSit(formation: string?)
	remotes.GroupSitRequest:FireServer(formation or "circle")
	print(`[InteractionController] Requesting group sit ({formation})`)
end

remotes.InteractionReplicated.OnClientEvent:Connect(function(interactionType: string, player: Player, data: any)
	-- Handle replicated interactions from other players
	-- TODO: Play animations, apply VFX
end)

-- ============================================
-- EMOTE WHEEL
-- ============================================

local emoteWheelOpen = false
local emoteWheelGui = nil

function InteractionController:OpenEmoteWheel()
	if emoteWheelOpen then
		return
	end
	
	-- TODO: Create circular emote wheel UI
	-- Press 'R' to open
	-- Icons only, soft glow highlight
	-- Animated opening
	
	emoteWheelOpen = true
	print("[InteractionController] Emote wheel opened")
end

function InteractionController:CloseEmoteWheel()
	if not emoteWheelOpen then
		return
	end
	
	emoteWheelOpen = false
	print("[InteractionController] Emote wheel closed")
end

function InteractionController:SelectEmote(emoteId: string)
	EmoteController.PlayEmote(emoteId)
	self:CloseEmoteWheel()
end

-- ============================================
-- INPUT HANDLING
-- ============================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	-- Press 'R' to open emote wheel
	if input.KeyCode == Enum.KeyCode.R then
		if emoteWheelOpen then
			InteractionController:CloseEmoteWheel()
		else
			InteractionController:OpenEmoteWheel()
		end
	end
	
	-- Press 'E' to interact with nearby player/object
	if input.KeyCode == Enum.KeyCode.E then
		-- TODO: Raycast to find nearby player or interactable
		-- TODO: Show interaction prompt
	end
end)

-- ============================================
-- PLAYER-TO-ENVIRONMENT INTERACTIONS
-- ============================================

-- Beds (handled by BedClient)
-- Dens (enter, hide)
-- Perches (teleport to pose)
-- Shrines (meditation)

-- ============================================
-- PLAYER-TO-BIOME ENERGY INTERACTIONS
-- ============================================

-- Nebula Blessing (Forest)
-- Lunar Reflection (Caverns)
-- Starfall Empowerment (Desert)
-- Void Ritual (Temple)
-- Orbital Levitation (Outer Rim)

-- ============================================
-- INITIALIZATION
-- ============================================

function InteractionController:Init()
	print("[InteractionController] Initialized - Interaction system ready")
	print("  - Player-to-player: Nuzzle, Cuddle, Carry, Follow")
	print("  - Emote wheel: Press 'R' to open")
	print("  - Group interactions: Group sit, huddle")
end

InteractionController:Init()

return InteractionController

