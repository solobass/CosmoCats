-- Movement verification script for CosmoCat
print("=== MOVEMENT VERIFICATION SCRIPT STARTING ===")

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Get local player
local player = Players.LocalPlayer
if not player then
    print("ERROR: Local player not found!")
    return
end

-- Create verification UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MovementVerification"
screenGui.Parent = player:WaitForChild("PlayerGui")

local verificationFrame = Instance.new("Frame")
verificationFrame.Name = "VerificationFrame"
verificationFrame.Size = UDim2.new(0, 250, 0, 100)
verificationFrame.Position = UDim2.new(0, 20, 0, 20)
verificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
verificationFrame.BackgroundTransparency = 0.3
verificationFrame.BorderSizePixel = 0
verificationFrame.Parent = screenGui

local verificationLabel = Instance.new("TextLabel")
verificationLabel.Name = "VerificationLabel"
verificationLabel.Size = UDim2.new(1, -10, 1, -10)
verificationLabel.Position = UDim2.new(0, 5, 0, 5)
verificationLabel.BackgroundTransparency = 1
verificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
verificationLabel.TextScaled = true
verificationLabel.Font = Enum.Font.Gotham -- Fixed: Changed from Monospace to Gotham
verificationLabel.TextXAlignment = Enum.TextXAlignment.Left
verificationLabel.TextYAlignment = Enum.TextYAlignment.Top
verificationLabel.Text = "Movement Test\nPress WASD to test"
verificationLabel.Parent = verificationFrame

-- Movement test variables
local lastPosition = Vector3.new(0, 0, 0)
local movementDetected = false
local testStartTime = tick()

-- Function to test movement
local function TestMovement()
    local character = player.Character
    if not character then
        verificationLabel.Text = "No Character\nCannot test movement"
        return
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        verificationLabel.Text = "No HumanoidRootPart\nCannot test movement"
        return
    end
    
    local currentPosition = humanoidRootPart.Position
    local distance = (currentPosition - lastPosition).Magnitude
    
    if distance > 0.1 then
        movementDetected = true
        verificationLabel.Text = string.format("MOVEMENT DETECTED!\nDistance: %.2f studs\nPosition: %.1f, %.1f, %.1f", 
            distance, currentPosition.X, currentPosition.Y, currentPosition.Z)
    else
        local timeSinceStart = tick() - testStartTime
        verificationLabel.Text = string.format("No Movement\nTime: %.1f seconds\nPosition: %.1f, %.1f, %.1f", 
            timeSinceStart, currentPosition.X, currentPosition.Y, currentPosition.Z)
    end
    
    lastPosition = currentPosition
end

-- Update movement test every frame
RunService.Heartbeat:Connect(TestMovement)

-- Input test
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    local keyPressed = input.KeyCode.Name
    if keyPressed == "W" or keyPressed == "A" or keyPressed == "S" or keyPressed == "D" then
        verificationLabel.Text = "Key pressed: " .. keyPressed .. "\nTesting movement..."
        testStartTime = tick()
    end
end)

print("=== MOVEMENT VERIFICATION SCRIPT COMPLETE ===")
