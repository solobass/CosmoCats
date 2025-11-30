-- ClanGui.client.lua
-- Handles clan management UI and interactions.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local Modules = ReplicatedStorage:WaitForChild("Modules")
local ClanController = require(Modules:WaitForChild("Clans"):WaitForChild("ClanController"))

local gui = script.Parent.Parent -- ClanGui
local screenGui = gui:WaitForChild("ClanScreenGui")
local frameClanHome = screenGui:WaitForChild("Frame_ClanHome")
local frameNoClan = screenGui:WaitForChild("Frame_NoClan")

-- Get buttons
local createClanButton = frameNoClan:WaitForChild("CreateClanButton")
local joinClanButton = frameNoClan:WaitForChild("JoinClanButton")
local inviteButton = frameClanHome:WaitForChild("InviteButton")
local leaveClanButton = frameClanHome:WaitForChild("LeaveClanButton")
local teleportHomeButton = frameClanHome:WaitForChild("TeleportHomeButton")

local memberList = frameClanHome:WaitForChild("MemberList")
local clanNameLabel = frameClanHome:WaitForChild("ClanNameLabel")

-- Update UI based on clan status
local function updateClanUI()
    local myClan = ClanController.GetMyClan()
    
    if myClan then
        frameClanHome.Visible = true
        frameNoClan.Visible = false
        clanNameLabel.Text = "CLAN: " .. myClan.name
        
        -- TODO: Populate member list
    else
        frameClanHome.Visible = false
        frameNoClan.Visible = true
    end
end

-- Button handlers
createClanButton.MouseButton1Click:Connect(function()
    print("[ClanGui] Create clan clicked")
    -- TODO: Open create clan popup
end)

joinClanButton.MouseButton1Click:Connect(function()
    print("[ClanGui] Join clan clicked")
    -- TODO: Open join clan interface
end)

inviteButton.MouseButton1Click:Connect(function()
    print("[ClanGui] Invite clicked")
    -- TODO: Open player list for inviting
end)

leaveClanButton.MouseButton1Click:Connect(function()
    print("[ClanGui] Leave clan clicked")
    -- TODO: Confirm and leave clan
end)

teleportHomeButton.MouseButton1Click:Connect(function()
    print("[ClanGui] Teleport home clicked")
    -- TODO: Request teleport to clan home
end)

-- Initialize UI
task.wait(1) -- Wait for ClanController to initialize
updateClanUI()


