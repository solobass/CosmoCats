-- Basic Animate script for CosmoKitten character
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Animation states
local isWalking = false
local isRunning = false
local isJumping = false

-- Handle character movement
local function updateMovement()
    local velocity = humanoidRootPart.Velocity
    local speed = velocity.Magnitude
    
    if speed > 0.1 then
        if not isWalking then
            isWalking = true
            print("DEBUG: CosmoKitten is walking")
        end
    else
        if isWalking then
            isWalking = false
            print("DEBUG: CosmoKitten stopped walking")
        end
    end
    
    -- Check if jumping
    if velocity.Y > 5 then
        if not isJumping then
            isJumping = true
            print("DEBUG: CosmoKitten is jumping")
        end
    else
        if isJumping then
            isJumping = false
            print("DEBUG: CosmoKitten landed")
        end
    end
end

-- Connect to RunService to update movement
RunService.Heartbeat:Connect(updateMovement)

print("DEBUG: CosmoKitten Animate script loaded successfully!")
print("DEBUG: Character name:", character.Name)
print("DEBUG: Humanoid DisplayName:", humanoid.DisplayName)
print("DEBUG: HumanoidRootPart position:", humanoidRootPart.Position)
