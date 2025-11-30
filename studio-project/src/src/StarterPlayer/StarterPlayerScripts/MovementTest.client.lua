-- Simple movement test script for CosmoCat
print("=== MOVEMENT TEST SCRIPT STARTING ===")

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Get local player
local player = Players.LocalPlayer
if not player then
    print("ERROR: Local player not found!")
    return
end

-- Function to test character movement
local function TestCharacterMovement()
    local character = player.Character
    if not character then
        print("No character found!")
        return
    end
    
    print("Character found:", character.Name)
    print("Character class:", character.ClassName)
    
    -- Check for Humanoid
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        print("Humanoid found!")
        print("WalkSpeed:", humanoid.WalkSpeed)
        print("JumpPower:", humanoid.JumpPower)
        print("Current State:", humanoid:GetState())
        
        -- Test setting movement values
        humanoid.WalkSpeed = 20
        humanoid.JumpPower = 60
        print("Set WalkSpeed to 20, JumpPower to 60")
    else
        print("ERROR: No Humanoid found!")
    end
    
    -- Check for HumanoidRootPart
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        print("HumanoidRootPart found!")
        print("Position:", humanoidRootPart.Position)
        print("Anchored:", humanoidRootPart.Anchored)
        print("CanCollide:", humanoidRootPart.CanCollide)
    else
        print("ERROR: No HumanoidRootPart found!")
    end
    
    -- List all character children
    print("Character children:")
    for _, child in pairs(character:GetChildren()) do
        print("  -", child.Name, "(" .. child.ClassName .. ")")
    end
    
    -- Check for CatAppearance
    local catAppearance = character:FindFirstChild("CatAppearance")
    if catAppearance and catAppearance.ClassName == "Model" then
        print("CatAppearance found!")
        print("CatAppearance children:")
        for _, child in pairs(catAppearance:GetChildren()) do
            print("  -", child.Name, "(" .. child.ClassName .. ")")
            if child.ClassName == "BasePart" or child.ClassName == "MeshPart" then
                print("    Size:", child.Size, "Position:", child.Position, "Transparency:", child.Transparency)
                -- Make sure the part is visible
                if child.Transparency >= 1 then
                    print("    WARNING: Part is invisible (Transparency >= 1)")
                    child.Transparency = 0
                    print("    Fixed: Set Transparency to 0")
                end
                -- Make sure the part is not too small
                if child.Size.Magnitude < 0.1 then
                    print("    WARNING: Part is too small:", child.Size)
                    child.Size = Vector3.new(2, 2, 2)
                    print("    Fixed: Set Size to (2, 2, 2)")
                end
            end
        end
    else
        print("No CatAppearance found")
    end
end

-- Run test after character loads
local function OnCharacterAdded(character)
    print("Character added, waiting 2 seconds then testing...")
    wait(2)
    TestCharacterMovement()
end

-- Connect to character added event
player.CharacterAdded:Connect(OnCharacterAdded)

-- Test existing character if available
if player.Character then
    print("Character already exists, testing immediately...")
    TestCharacterMovement()
end

print("=== MOVEMENT TEST SCRIPT COMPLETE ===")
