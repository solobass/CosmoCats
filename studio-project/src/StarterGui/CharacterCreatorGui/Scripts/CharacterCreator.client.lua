-- CharacterCreator.client.lua
-- Handles character customization UI and appearance preview.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local Modules = ReplicatedStorage:WaitForChild("Modules")
local CharacterCreator = require(Modules:WaitForChild("Character"):WaitForChild("CharacterCreator"))

local gui = script.Parent.Parent -- CharacterCreatorGui
local screenGui = gui:WaitForChild("CharacterCreatorScreenGui")
local tabBar = screenGui:WaitForChild("TabBar")
local contentFrame = screenGui:WaitForChild("ContentFrame")

-- Get tabs
local tabColors = tabBar:WaitForChild("Tab_Colors")
local tabPatterns = tabBar:WaitForChild("Tab_Patterns")
local tabAccessories = tabBar:WaitForChild("Tab_Accessories")
local tabEffects = tabBar:WaitForChild("Tab_Effects")
local tabInfo = tabBar:WaitForChild("Tab_Info")

-- Get content frames
local frameColors = contentFrame:WaitForChild("Frame_Colors")
local framePatterns = contentFrame:WaitForChild("Frame_Patterns")
local frameAccessories = contentFrame:WaitForChild("Frame_Accessories")
local frameEffects = contentFrame:WaitForChild("Frame_Effects")
local frameInfo = contentFrame:WaitForChild("Frame_Info")
local previewViewport = contentFrame:WaitForChild("PreviewViewportFrame")

-- Temporary appearance data
local tempAppearanceData = {
    primaryColor = Color3.fromRGB(100, 100, 150),
    secondaryColor = Color3.fromRGB(150, 150, 200),
    detailColor = Color3.fromRGB(255, 255, 255),
    patternId = nil,
    accessories = {},
    effects = {},
}

-- Tab switching
local function showTab(frame)
    frameColors.Visible = false
    framePatterns.Visible = false
    frameAccessories.Visible = false
    frameEffects.Visible = false
    frameInfo.Visible = false
    
    frame.Visible = true
end

tabColors.MouseButton1Click:Connect(function()
    showTab(frameColors)
end)

tabPatterns.MouseButton1Click:Connect(function()
    showTab(framePatterns)
end)

tabAccessories.MouseButton1Click:Connect(function()
    showTab(frameAccessories)
end)

tabEffects.MouseButton1Click:Connect(function()
    showTab(frameEffects)
end)

tabInfo.MouseButton1Click:Connect(function()
    showTab(frameInfo)
end)

-- Update preview
local function updatePreview()
    local character = player.Character
    if character then
        -- TODO: Apply appearance to preview model
        -- CharacterCreator.ApplyAppearance(previewModel, tempAppearanceData)
    end
end

-- Apply button
local applyButton = contentFrame:FindFirstChild("ApplyButton")
if applyButton then
    applyButton.MouseButton1Click:Connect(function()
        -- TODO: Fire RemoteEvent to save appearance
        -- AppearanceUpdated:FireServer(tempAppearanceData)
        print("[CharacterCreator] Applying appearance")
        screenGui.Enabled = false
    end)
end

-- Close button
local closeButton = contentFrame:FindFirstChild("CloseButton")
if closeButton then
    closeButton.MouseButton1Click:Connect(function()
        screenGui.Enabled = false
    end)
end

-- Initialize: Show colors tab
showTab(frameColors)


