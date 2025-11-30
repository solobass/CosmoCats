--[[
	EmoteServer.lua
	Handles server-side emote validation and replication.
	Validates emote requests and ensures players have unlocked emotes.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local EmoteServer = {}
EmoteServer.__index = EmoteServer

-- Get dependencies (safely require - may not exist yet)
local PlayerDataManager = nil
local success, result = pcall(function() return require(script.Parent.Systems.PlayerDataManager) end)
if success and type(result) == "table" then
	PlayerDataManager = result
end

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
	
	local emoteRemotes = remotesFolder:FindFirstChild("EmoteRemotes")
	if not emoteRemotes then
		emoteRemotes = Instance.new("Folder")
		emoteRemotes.Name = "EmoteRemotes"
		emoteRemotes.Parent = remotesFolder
	end
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = emoteRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = emoteRemotes
		end
		return remote
	end
	
	return {
		PlayEmote = getOrCreateRemote("PlayEmote", "RemoteEvent"),
		StopEmote = getOrCreateRemote("StopEmote", "RemoteEvent"),
		EmoteReplicated = getOrCreateRemote("EmoteReplicated", "RemoteEvent"),
	}
end

local remotes = getRemotes()

-- ============================================
-- EMOTE VALIDATION
-- ============================================

-- Available emotes (from INTERACTION_SYSTEMS_BIBLE.md)
local AVAILABLE_EMOTES = {
	"SIT",
	"LAY",
	"LOAF",
	"GROOM",
	"STRETCH",
	"ROLL",
	"MEOW",
	"TAIL_FLICK",
	"POUNCE",
	"HOVER", -- Outer Rim only
}

-- Premium emotes (require unlock)
local PREMIUM_EMOTES = {
	-- TODO: Add premium emote IDs
}

local function validateEmote(player: Player, emoteId: string): boolean
	-- Check if emote exists
	if not table.find(AVAILABLE_EMOTES, emoteId) then
		warn(`[EmoteServer] Invalid emote: {emoteId}`)
		return false
	end
	
	-- Check if player has unlocked the emote
	local playerData = PlayerDataManager and PlayerDataManager:GetPlayerData(player)
	if not playerData then
		return true -- Default emotes are free
	end
	
	local unlockedEmotes = playerData.UnlockedEmotes or {}
	if PREMIUM_EMOTES[emoteId] and not unlockedEmotes[emoteId] then
		warn(`[EmoteServer] {player.Name} has not unlocked emote: {emoteId}`)
		return false
	end
	
	return true
end

-- ============================================
-- EMOTE REPLICATION
-- ============================================

remotes.PlayEmote.OnServerEvent:Connect(function(player: Player, emoteId: string)
	if not validateEmote(player, emoteId) then
		return
	end
	
	-- Replicate to all players (for multiplayer emotes)
	remotes.EmoteReplicated:FireAllClients(player, emoteId)
	
	print(`[EmoteServer] {player.Name} played emote: {emoteId}`)
end)

remotes.StopEmote.OnServerEvent:Connect(function(player: Player)
	remotes.EmoteReplicated:FireAllClients(player, "STOP")
end)

-- ============================================
-- INITIALIZATION
-- ============================================

print("[EmoteServer] Initialized - Emote system ready")
print("  - Available emotes: " .. #AVAILABLE_EMOTES)
print("  - Emote validation: Active")
print("  - Emote replication: Active")

return EmoteServer
