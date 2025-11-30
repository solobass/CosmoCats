-- Clean CatTreat collection and level progression system for CosmoCat
print("=== CATTREAT COLLECTION & LEVEL SYSTEM STARTING ===")

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Get local player
local player = Players.LocalPlayer
if not player then
    print("ERROR: Local player not found!")
    return
end

-- Simple UI cleanup function
local function CleanupUI()
    -- Remove username display
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.DisplayName = ""
        end
    end
    
    -- Remove unwanted UI elements
    local playerGui = player:FindFirstChild("PlayerGui")
    if playerGui then
        for _, child in pairs(playerGui:GetChildren()) do
            -- Check if child has Text property before accessing it
            if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                if child.Text and (child.Text:find("FurGamesRoblox") or 
                                  child.Text:find("Roblox automatically translates")) then
                    child:Destroy()
                end
            end
        end
    end
end

-- Run UI cleanup every 5 seconds
spawn(function()
    while wait(5) do
        CleanupUI()
    end
end)

-- Third-person camera system
local function SetupThirdPersonCamera()
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    -- Don't override the camera type - let Roblox handle movement
    -- Just ensure we have a good starting position
    camera.CameraType = Enum.CameraType.Custom
    
    -- Set a good starting camera distance
    local function UpdateCameraDistance()
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        -- Set camera to follow character at a good distance
        camera.CameraSubject = character
        camera.CameraType = Enum.CameraType.Custom
    end
    
    -- Update camera when character changes
    player.CharacterAdded:Connect(UpdateCameraDistance)
    
    -- Update for existing character
    if player.Character then
        UpdateCameraDistance()
    end
end

-- Initialize camera system
spawn(SetupThirdPersonCamera)

-- Movement system for both WASD and arrow keys
local function SetupMovementSystem()
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    
    local moveVector = Vector3.new(0, 0, 0)
    local isMoving = false
    
    -- Handle input for both WASD and arrow keys
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        local keyCode = input.KeyCode
        if keyCode == Enum.KeyCode.W or keyCode == Enum.KeyCode.Up then
            moveVector = moveVector + Vector3.new(0, 0, -1)
            isMoving = true
        elseif keyCode == Enum.KeyCode.S or keyCode == Enum.KeyCode.Down then
            moveVector = moveVector + Vector3.new(0, 0, 1)
            isMoving = true
        elseif keyCode == Enum.KeyCode.A or keyCode == Enum.KeyCode.Left then
            moveVector = moveVector + Vector3.new(-1, 0, 0)
            isMoving = true
        elseif keyCode == Enum.KeyCode.D or keyCode == Enum.KeyCode.Right then
            moveVector = moveVector + Vector3.new(1, 0, 0)
            isMoving = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        local keyCode = input.KeyCode
        if keyCode == Enum.KeyCode.W or keyCode == Enum.KeyCode.Up then
            moveVector = moveVector - Vector3.new(0, 0, -1)
        elseif keyCode == Enum.KeyCode.S or keyCode == Enum.KeyCode.Down then
            moveVector = moveVector - Vector3.new(0, 0, 1)
        elseif keyCode == Enum.KeyCode.A or keyCode == Enum.KeyCode.Left then
            moveVector = moveVector - Vector3.new(-1, 0, 0)
        elseif keyCode == Enum.KeyCode.D or keyCode == Enum.KeyCode.Right then
            moveVector = moveVector - Vector3.new(1, 0, 0)
        end
        
        -- Check if we're still moving
        if moveVector.Magnitude < 0.1 then
            isMoving = false
        end
    end)
    
    -- Update movement
    RunService.Heartbeat:Connect(function()
        local character = player.Character
        if not character then return end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        -- Apply movement
        if isMoving and moveVector.Magnitude > 0.1 then
            humanoid:Move(moveVector)
        end
    end)
end

-- Initialize movement system
spawn(SetupMovementSystem)

-- Game state
local playerScore = 0
local playerLevel = 1
local gameConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("GameConfig"))

-- UI elements
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CosmoCatUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false  -- Prevent UI from being destroyed on respawn

-- Score display
local scoreLabel = Instance.new("TextLabel")
scoreLabel.Name = "ScoreLabel"
scoreLabel.Size = UDim2.new(0, 200, 0, 50)
scoreLabel.Position = UDim2.new(0, 20, 1, -70)
scoreLabel.BackgroundTransparency = 0.3
scoreLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
scoreLabel.BorderSizePixel = 0
scoreLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
scoreLabel.TextScaled = true
scoreLabel.Font = Enum.Font.GothamBold
scoreLabel.Text = "Meow: 0"
scoreLabel.ZIndex = 10
scoreLabel.Parent = screenGui

-- Level up notification
local levelUpLabel = Instance.new("TextLabel")
levelUpLabel.Name = "LevelUpLabel"
levelUpLabel.Size = UDim2.new(0, 400, 0, 60)
levelUpLabel.Position = UDim2.new(0.5, -200, 1, -80)
levelUpLabel.BackgroundTransparency = 0.3
levelUpLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
levelUpLabel.BorderSizePixel = 0
levelUpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
levelUpLabel.TextScaled = true
levelUpLabel.Font = Enum.Font.GothamBold
levelUpLabel.Text = ""
levelUpLabel.Visible = false
levelUpLabel.ZIndex = 10
levelUpLabel.Parent = screenGui

-- Ensure UI persists by re-parenting if needed
local function EnsureUIPersistence()
    if not screenGui.Parent then
        print("UI: ScreenGui lost parent, re-parenting...")
        screenGui.Parent = player:WaitForChild("PlayerGui")
    end
    
    if not scoreLabel.Parent then
        print("UI: Score label lost parent, re-parenting...")
        scoreLabel.Parent = screenGui
    end
    
    if not levelUpLabel.Parent then
        print("UI: Level up label lost parent, re-parenting...")
        levelUpLabel.Parent = screenGui
    end
end

-- Check UI persistence periodically
spawn(function()
    while wait(1) do
        EnsureUIPersistence()
    end
end)

-- Function to update score display
local function UpdateScoreDisplay()
    scoreLabel.Text = "Meow: " .. playerScore
    print("UI: Score display updated to:", scoreLabel.Text)
end

-- Function to show level up notification
local function ShowLevelUpNotification(newLevel)
    local levelName = gameConfig.Levels[newLevel] and gameConfig.Levels[newLevel].name or "Unknown"
    
    -- Set text with different colors
    levelUpLabel.Text = "LEVEL " .. newLevel .. " - " .. levelName
    
    -- Make LEVEL X yellow, rest white
    local levelText = "LEVEL " .. newLevel
    local nameText = " - " .. levelName
    
    levelUpLabel.Text = levelText .. nameText
    
    -- Show notification
    levelUpLabel.Visible = true
    print("UI: Level up notification shown:", levelUpLabel.Text)
    
    -- Hide after 3 seconds
    spawn(function()
        wait(3)
        levelUpLabel.Visible = false
        print("UI: Level up notification hidden")
    end)
end

-- Function to check for level up
local function CheckLevelUp()
    local currentLevel = playerLevel
    local requiredPoints = gameConfig.Levels[currentLevel + 1] and gameConfig.Levels[currentLevel + 1].pointsRequired
    
    print("Checking level up - Current level:", currentLevel, "Score:", playerScore, "Required for next level:", requiredPoints)
    
    if requiredPoints and playerScore >= requiredPoints then
        playerLevel = currentLevel + 1
        print("Level up! Now level", playerLevel)
        ShowLevelUpNotification(playerLevel)
        
        -- Update avatar (this will be handled by the server)
        local CatAvatarManager = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("CatAvatarManager"))
        if CatAvatarManager.UpdatePlayerAvatar then
            CatAvatarManager.UpdatePlayerAvatar(player, playerLevel)
        end
    end
end

-- Function to check for CatTreat collection
local function CheckCatTreatCollection()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Check for CatTreats in workspace
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name == "CatTreat" then
            local objPosition
            if obj:IsA("Model") then
                objPosition = obj.PrimaryPart and obj.PrimaryPart.Position or obj:FindFirstChildOfClass("Part") and obj:FindFirstChildOfClass("Part").Position
            else
                objPosition = obj.Position
            end
            
            if objPosition and (humanoidRootPart.Position - objPosition).Magnitude < 3 then
                -- Collect the CatTreat
                local points = obj:FindFirstChild("Points")
                if points then
                    print("Collecting CatTreat with", points.Value, "points!")
                    
                    -- Send collection request to server
                    local remoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
                    if remoteEvents then
                        local collectEvent = remoteEvents:FindFirstChild("CollectCatTreat")
                        if collectEvent then
                            collectEvent:FireServer({
                                name = obj.Name,
                                position = objPosition,
                                className = obj.ClassName
                            })
                            
                            -- Update local score immediately
                            playerScore = playerScore + points.Value
                            print("Score updated to:", playerScore)
                            UpdateScoreDisplay()
                            
                            -- Check for level up
                            CheckLevelUp()
                        else
                            print("ERROR: CollectCatTreat event not found!")
                        end
                    else
                        print("ERROR: RemoteEvents folder not found!")
                    end
                else
                    print("ERROR: CatTreat has no Points value!")
                end
            end
        end
    end
end

-- Connect collection checking to RunService
RunService.Heartbeat:Connect(CheckCatTreatCollection)

-- Initialize
print("=== CATTREAT COLLECTION & LEVEL SYSTEM COMPLETE ===")
print("Player:", player.Name)
print("Starting level:", playerLevel)
print("Starting score:", playerScore)
print("UI: ScreenGui created:", screenGui.Name)
print("UI: Score label created:", scoreLabel.Name)
print("UI: Level up label created:", levelUpLabel.Name)
print("UI: Initial score display:", scoreLabel.Text)
