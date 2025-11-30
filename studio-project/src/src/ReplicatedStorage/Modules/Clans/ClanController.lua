-- ClanController.lua
-- Handles client-side data & UI for Clans (Cosmic Clans).

local ClanController = {}

--[[
    Clans Data Model (high level):

    Clan {
        id: string,
        name: string,
        leaderUserId: number,
        color: Color3,
        iconId: string? (decal / image),
        roles: { [roleName]: { canInvite: bool, canKick: bool, canSetHome: bool } },
        members: { [userId]: roleName },
        homeLocation: Vector3? -- or CFrame
    }

    Client responsibilities:
        - Cache player's clan membership
        - Provide joins/creates/kick/leave requests via RemoteEvents
        - Drive Clan GUI (clan list, members, role display)

    Server does validation & persistence.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local myClan = nil

-- Get or create RemoteEvents
local function getRemotes()
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotesFolder then
		remotesFolder = Instance.new("Folder")
		remotesFolder.Name = "Remotes"
		remotesFolder.Parent = ReplicatedStorage
	end
	
	local clanRemotes = remotesFolder:FindFirstChild("ClanRemotes")
	if not clanRemotes then
		clanRemotes = Instance.new("Folder")
		clanRemotes.Name = "ClanRemotes"
		clanRemotes.Parent = remotesFolder
	end
	
	local function getOrCreateRemote(name: string, className: string)
		local remote = clanRemotes:FindFirstChild(name)
		if not remote then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = clanRemotes
		end
		return remote
	end
	
	return {
		CreateClan = getOrCreateRemote("CreateClan", "RemoteEvent"),
		JoinClan = getOrCreateRemote("JoinClan", "RemoteEvent"),
		LeaveClan = getOrCreateRemote("LeaveClan", "RemoteEvent"),
		InvitePlayer = getOrCreateRemote("InvitePlayer", "RemoteEvent"),
		KickPlayer = getOrCreateRemote("KickPlayer", "RemoteEvent"),
		ClanUpdated = getOrCreateRemote("ClanUpdated", "RemoteEvent"),
	}
end

function ClanController.SetMyClan(clanData: table?)
    myClan = clanData
end

function ClanController.GetMyClan(): table?
    return myClan
end

-- Request to create a new clan
function ClanController.RequestCreateClan(clanName: string, color: Color3, iconId: string?)
	local remotes = getRemotes()
	remotes.CreateClan:FireServer(clanName, color, iconId)
end

-- Request to join a clan
function ClanController.RequestJoinClan(clanId: string)
	local remotes = getRemotes()
	remotes.JoinClan:FireServer(clanId)
end

-- Request to leave current clan
function ClanController.RequestLeaveClan()
	if not myClan then
		warn("[ClanController] Cannot leave clan - not in a clan")
		return
	end
	
	local remotes = getRemotes()
	remotes.LeaveClan:FireServer()
end

-- Request to invite a player to the clan
function ClanController.RequestInvitePlayer(playerNameOrId: string | number)
	if not myClan then
		warn("[ClanController] Cannot invite - not in a clan")
		return
	end
	
	local remotes = getRemotes()
	remotes.InvitePlayer:FireServer(playerNameOrId)
end

-- Request to kick a player from the clan
function ClanController.RequestKickPlayer(userId: number)
	if not myClan then
		warn("[ClanController] Cannot kick - not in a clan")
		return
	end
	
	local remotes = getRemotes()
	remotes.KickPlayer:FireServer(userId)
end

-- Check if player is in a clan
function ClanController.IsInClan(): boolean
	return myClan ~= nil
end

-- Get player's role in their clan
function ClanController.GetMyRole(): string?
	if not myClan then
		return nil
	end
	
	local localPlayer = Players.LocalPlayer
	if not localPlayer then
		return nil
	end
	
	return myClan.members and myClan.members[tostring(localPlayer.UserId)]
end

-- Check if player has a specific permission
function ClanController.HasPermission(permission: string): boolean
	local role = ClanController.GetMyRole()
	if not role or not myClan or not myClan.roles then
		return false
	end
	
	local roleData = myClan.roles[role]
	if not roleData then
		return false
	end
	
	return roleData[permission] == true
end

-- Listen for clan updates from server
local remotes = getRemotes()
remotes.ClanUpdated.OnClientEvent:Connect(function(clanData: table?)
	ClanController.SetMyClan(clanData)
end)

-- TODO: Add helper methods to:
-- - RequestCreateClan(clanName, color, iconId)
-- - RequestJoinClan(clanId)
-- - RequestLeaveClan()
-- - RequestInvitePlayer(playerNameOrId)
-- These will use RemoteEvents to talk to server.

return ClanController

