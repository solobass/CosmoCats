-- MainMenu.client.lua
-- Handles main menu navigation and button interactions.

local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local gui = script.Parent.Parent -- MainMenuGui
local screenGui = gui:WaitForChild("MainMenuScreenGui")
local mainFrame = screenGui:WaitForChild("Frame_MainMenu")

-- Get buttons
local playButton = mainFrame:WaitForChild("PlayButton")
local characterCreatorButton = mainFrame:WaitForChild("CharacterCreatorButton")
local clansButton = mainFrame:WaitForChild("ClansButton")
local settingsButton = mainFrame:WaitForChild("SettingsButton")

-- Get other GUIs
local speciesSelectorGui = StarterGui:FindFirstChild("SpeciesSelectorGui")
local characterCreatorGui = StarterGui:FindFirstChild("CharacterCreatorGui")
local clanGui = StarterGui:FindFirstChild("ClanGui")
local settingsGui = StarterGui:FindFirstChild("SettingsGui")

-- Button click handlers
playButton.MouseButton1Click:Connect(function()
    print("[MainMenu] Opening Species Selector")
    if speciesSelectorGui then
        speciesSelectorGui.SpeciesSelectorScreenGui.Enabled = true
        screenGui.Enabled = false
    end
end)

characterCreatorButton.MouseButton1Click:Connect(function()
    print("[MainMenu] Opening Character Creator")
    if characterCreatorGui then
        characterCreatorGui.CharacterCreatorScreenGui.Enabled = true
        screenGui.Enabled = false
    end
end)

clansButton.MouseButton1Click:Connect(function()
    print("[MainMenu] Opening Clan GUI")
    if clanGui then
        clanGui.ClanScreenGui.Enabled = true
        screenGui.Enabled = false
    end
end)

settingsButton.MouseButton1Click:Connect(function()
    print("[MainMenu] Opening Settings")
    if settingsGui then
        settingsGui.SettingsScreenGui.Enabled = true
        screenGui.Enabled = false
    end
end)

-- Show main menu on start
screenGui.Enabled = true


