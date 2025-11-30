-- Simple avatar test script for CosmoCat
print("=== AVATAR TEST SCRIPT STARTING ===")

-- Wait for services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Wait for CatAvatarManager
local CatAvatarManager = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("CatAvatarManager"))

-- Test function
local function TestAvatarSystem()
    print("Testing avatar system...")
    
    -- Test with existing players
    for _, player in pairs(Players:GetPlayers()) do
        print("Testing with player:", player.Name)
        
        if player.Character then
            print("Player has character:", player.Character.Name)
            print("Character class:", player.Character.ClassName)
            
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                print("Humanoid found - WalkSpeed:", humanoid.WalkSpeed)
                print("Humanoid DisplayName:", humanoid.DisplayName)
            else
                print("No Humanoid found!")
            end
            
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                print("HumanoidRootPart found at position:", humanoidRootPart.Position)
            else
                print("No HumanoidRootPart found!")
            end
        else
            print("Player has no character")
        end
    end
end

-- Run test after a delay
spawn(function()
    wait(5) -- Wait for everything to load
    TestAvatarSystem()
end)

print("=== AVATAR TEST SCRIPT COMPLETE ===")
