-- SpeciesServer.lua
-- Server-side species management: validating unlocks and spawning characters.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local SpeciesController = require(Modules.Species.SpeciesController)
local GameConfig = require(Modules.Config.GameConfig)

-- Get PlayerDataManager for loading species data
local ServerScriptService = game:GetService("ServerScriptService")
local Systems = ServerScriptService:FindFirstChild("Systems")
local PlayerDataManager = Systems and require(Systems.PlayerDataManager) or nil

-- Get or create RemoteEvents
local function getRemotes()
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotesFolder then
		remotesFolder = Instance.new("Folder")
		remotesFolder.Name = "Remotes"
		remotesFolder.Parent = ReplicatedStorage
	end
	
	local speciesRemotes = remotesFolder:FindFirstChild("SpeciesRemotes")
	if not speciesRemotes then
		speciesRemotes = Instance.new("Folder")
		speciesRemotes.Name = "SpeciesRemotes"
		speciesRemotes.Parent = remotesFolder
	end
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = speciesRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = speciesRemotes
		end
		return remote
	end
	
	return {
		SetSpecies = getOrCreateRemote("SetSpecies", "RemoteEvent"),
		GetSpecies = getOrCreateRemote("GetSpecies", "RemoteFunction"),
		SpeciesUpdated = getOrCreateRemote("SpeciesUpdated", "RemoteEvent"),
	}
end

local remotes = getRemotes()

-- Validate if player can use a species
local function canPlayerUseSpecies(player: Player, speciesId: string): boolean
	local speciesData = SpeciesController.GetSpecies(speciesId)
	if not speciesData then
		return false
	end
	
	-- Starter species are always available
	if speciesData.category == "Starter" then
		return true
	end
	
	-- TODO: Check if player has unlocked the species
	-- - Check unlockCost (Stardust)
	-- - Check gamePassId (Robux game pass)
	-- - Check if in player's unlocked species list
	
	return false
end

-- Spawn character as species
local function spawnAsSpecies(character: Model, speciesId: string)
	local speciesData = SpeciesController.GetSpecies(speciesId)
	if not speciesData then
		warn("[SpeciesServer] Cannot spawn unknown species:", speciesId)
		return
	end
	
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then
		warn("[SpeciesServer] Character missing Humanoid")
		return
	end
	
	-- Apply scale using Humanoid:ApplyDescriptionScale()
	local scale = speciesData.defaultScale or 1.0
	if scale ~= 1.0 then
		local humanoidDescription = humanoid:GetAppliedDescription()
		humanoidDescription.HeadScale = scale
		humanoidDescription.DepthScale = scale
		humanoidDescription.HeightScale = scale
		humanoidDescription.ProportionScale = scale
		humanoidDescription.WidthScale = scale
		humanoid:ApplyDescription(humanoidDescription)
	end
	
	-- TODO:
	-- 1. Load species model from ReplicatedStorage/CosmoCatsModels/[modelFolder]/Model.rbxm
	--    Example: local model = ReplicatedStorage.CosmoCatsModels[speciesData.modelFolder].Model:Clone()
	-- 2. Replace character with species model
	-- 3. Apply default appearance
	-- 4. Set up animations
	-- 5. Configure movement profile
	-- 
	-- Optional files available:
	-- - ReplicatedStorage.CosmoCatsModels[speciesData.modelFolder].icon (ImageLabel/ImageButton)
	-- - ReplicatedStorage.CosmoCatsModels[speciesData.modelFolder].thumbnail
	-- - ReplicatedStorage.CosmoCatsModels[speciesData.modelFolder].metadata (StringValue with JSON)
	
	print("[SpeciesServer] Spawning", speciesId, "for character with scale:", scale)
end

local function onPlayerAdded(player: Player)
	-- TODO:
	-- 1. Load player species from DataStore (or fallback to default).
	-- 2. Store in SpeciesController.
	-- 3. Optionally spawn them immediately as that species.
	
	local speciesId = GameConfig.DefaultSpeciesId
	
	-- Try to load from PlayerData
	if PlayerDataManager then
		local playerData = PlayerDataManager:GetPlayerData(player)
		if playerData and playerData.SpeciesId then
			speciesId = playerData.SpeciesId
		end
	end
	
	-- Validate species
	if not canPlayerUseSpecies(player, speciesId) then
		speciesId = GameConfig.DefaultSpeciesId
	end
	
	-- Store in SpeciesController
	SpeciesController.SetPlayerSpecies(player, speciesId)
	
	-- Notify client
	remotes.SpeciesUpdated:FireClient(player, speciesId)
	
	print("[SpeciesServer] Player", player.Name, "assigned species:", speciesId)
end

local function onCharacterAdded(character: Model)
	-- TODO:
	-- 1. Get player from character.
	-- 2. Get player species from SpeciesController.
	-- 3. Replace default R15 character with cat species model.
	
	local player = Players:GetPlayerFromCharacter(character)
	if not player then
		return
	end
	
	local speciesId = SpeciesController.GetPlayerSpecies(player)
	if not speciesId then
		speciesId = GameConfig.DefaultSpeciesId
		SpeciesController.SetPlayerSpecies(player, speciesId)
	end
	
	-- Wait for character to fully load
	character:WaitForChild("Humanoid")
	
	-- Spawn as species
	spawnAsSpecies(character, speciesId)
end

-- Handle species change requests
remotes.SetSpecies.OnServerEvent:Connect(function(player: Player, speciesId: string)
	-- Validate request
	if not canPlayerUseSpecies(player, speciesId) then
		warn("[SpeciesServer] Player", player.Name, "cannot use species:", speciesId)
		remotes.SpeciesUpdated:FireClient(player, SpeciesController.GetPlayerSpecies(player))
		return
	end
	
	-- Set species
	SpeciesController.SetPlayerSpecies(player, speciesId)
	
	-- Save to PlayerData
	if PlayerDataManager then
		PlayerDataManager:UpdatePlayerData(player, "SpeciesId", speciesId)
	end
	
	-- Notify client
	remotes.SpeciesUpdated:FireClient(player, speciesId)
	
	-- Respawn if character exists
	if player.Character then
		player.Character:BreakJoints()
	end
	
	print("[SpeciesServer] Player", player.Name, "changed to species:", speciesId)
end)

-- Handle species query
remotes.GetSpecies.OnServerInvoke = function(player: Player)
	return SpeciesController.GetPlayerSpecies(player) or GameConfig.DefaultSpeciesId
end

Players.PlayerAdded:Connect(onPlayerAdded)

Players.PlayerRemoving:Connect(function(player: Player)
	-- TODO: Save species data if needed
	-- PlayerDataManager should handle this automatically
end)

-- Hook characters for all current players (for studio test)
for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
	if player.Character then
		onCharacterAdded(player.Character)
	else
		player.CharacterAdded:Connect(onCharacterAdded)
	end
end

-- Hook character spawning for future players
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end)

print("[SpeciesServer] Initialized")

return {}

