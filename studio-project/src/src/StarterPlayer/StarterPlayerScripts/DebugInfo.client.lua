-- Debug info script for CosmoCat
print("=== DEBUG INFO SCRIPT STARTING ===")

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Get local player
local player = Players.LocalPlayer
if not player then
    print("ERROR: Local player not found!")
    return
end

-- Create debug UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DebugInfo"
screenGui.Parent = player:WaitForChild("PlayerGui")

local debugFrame = Instance.new("Frame")
debugFrame.Name = "DebugFrame"
debugFrame.Size = UDim2.new(0, 300, 0, 200)
debugFrame.Position = UDim2.new(1, -320, 0, 20)
debugFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
debugFrame.BackgroundTransparency = 0.3
debugFrame.BorderSizePixel = 0
debugFrame.Parent = screenGui

local debugLabel = Instance.new("TextLabel")
debugLabel.Name = "DebugLabel"
debugLabel.Size = UDim2.new(1, -10, 1, -10)
debugLabel.Position = UDim2.new(0, 5, 0, 5)
debugLabel.BackgroundTransparency = 1
debugLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
debugLabel.TextScaled = true
debugLabel.Font = Enum.Font.Gotham -- Fixed: Changed from Monospace to Gotham
debugLabel.TextXAlignment = Enum.TextXAlignment.Left
debugLabel.TextYAlignment = Enum.TextYAlignment.Top
debugLabel.Text = "Debug Info Loading..."
debugLabel.Parent = debugFrame

-- Function to update debug info
local function UpdateDebugInfo()
    local character = player.Character
    if not character then
        debugLabel.Text = "No Character"
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local catAppearance = character:FindFirstChild("CatAppearance")
    
    local info = {}
    table.insert(info, "Character: " .. character.Name)
    table.insert(info, "Class: " .. character.ClassName)
    
    if humanoid then
        table.insert(info, "Humanoid: ✓")
        table.insert(info, "WalkSpeed: " .. humanoid.WalkSpeed)
        table.insert(info, "JumpPower: " .. humanoid.JumpPower)
        table.insert(info, "State: " .. tostring(humanoid:GetState()))
    else
        table.insert(info, "Humanoid: ✗")
    end
    
    if humanoidRootPart then
        table.insert(info, "RootPart: ✓")
        table.insert(info, "Pos: " .. string.format("%.1f, %.1f, %.1f", 
            humanoidRootPart.Position.X, 
            humanoidRootPart.Position.Y, 
            humanoidRootPart.Position.Z))
        table.insert(info, "Anchored: " .. tostring(humanoidRootPart.Anchored))
    else
        table.insert(info, "RootPart: ✗")
    end
    
    if catAppearance then
        table.insert(info, "CatAppearance: ✓")
        table.insert(info, "Children: " .. #catAppearance:GetChildren())
    else
        table.insert(info, "CatAppearance: ✗")
    end
    
    -- Count visible parts
    local visibleParts = 0
    local hiddenParts = 0
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("BasePart") then
            if child.Transparency >= 1 then
                hiddenParts = hiddenParts + 1
            else
                visibleParts = visibleParts + 1
            end
        end
    end
    table.insert(info, "Visible Parts: " .. visibleParts)
    table.insert(info, "Hidden Parts: " .. hiddenParts)
    
    debugLabel.Text = table.concat(info, "\n")
end

-- Update debug info every frame
RunService.Heartbeat:Connect(UpdateDebugInfo)

print("=== DEBUG INFO SCRIPT COMPLETE ===")
