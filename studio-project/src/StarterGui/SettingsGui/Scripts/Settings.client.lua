-- Settings.client.lua
-- Handles settings UI and client-side preferences.

local gui = script.Parent.Parent -- SettingsGui
local screenGui = gui:WaitForChild("SettingsScreenGui")
local settingsFrame = screenGui:WaitForChild("Frame_Settings")

-- Get toggles
local toggleParticles = settingsFrame:WaitForChild("Toggle_Particles")
local toggleNametags = settingsFrame:WaitForChild("Toggle_Nametags")
local toggleMusic = settingsFrame:WaitForChild("Toggle_Music")
local toggleSoundEffects = settingsFrame:WaitForChild("Toggle_SoundEffects")
local closeButton = settingsFrame:WaitForChild("CloseButton")

-- Load settings from local storage
local function loadSettings()
    -- TODO: Load from LocalStorage or PlayerGui
    toggleParticles.Value = true
    toggleNametags.Value = true
    toggleMusic.Value = true
    toggleSoundEffects.Value = true
end

-- Save settings
local function saveSettings()
    -- TODO: Save to LocalStorage or PlayerGui
end

-- Toggle handlers
toggleParticles.Changed:Connect(function()
    print("[Settings] Particles:", toggleParticles.Value)
    saveSettings()
end)

toggleNametags.Changed:Connect(function()
    print("[Settings] Nametags:", toggleNametags.Value)
    saveSettings()
end)

toggleMusic.Changed:Connect(function()
    print("[Settings] Music:", toggleMusic.Value)
    saveSettings()
end)

toggleSoundEffects.Changed:Connect(function()
    print("[Settings] Sound Effects:", toggleSoundEffects.Value)
    saveSettings()
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Initialize
loadSettings()


