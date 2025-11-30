-- Simple Cat Avatar Manager for CosmoCat
-- This loads the CosmoKitten model from ReplicatedStorage (like SpaceCat)

local CatAvatarManager = {}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Track players to prevent infinite loops
local PlayerFlags = {}

-- Get GameConfig for avatar mapping
local GameConfig = require(script.Parent.GameConfig)

-- Flag: use the imported CosmoKitten model in ReplicatedStorage when available
local USE_IMPORTED_MODEL = true

-- Avatar mapping - dynamically generated from GameConfig (currently unused for custom models)
local LevelAvatars = {}
for level, config in pairs(GameConfig.Levels) do
    LevelAvatars[level] = config.catModel
end

-- Function to create a simple cat character Model
local function CreateCatCharacterModel(player, level)
    print("Creating cat character Model for", player.Name, "at level", level)
    
    local catModelName = "CosmoKitten"
    local catModel = ReplicatedStorage:FindFirstChild(catModelName)
    
    -- Try to use imported CosmoKitten model if enabled and valid
    if USE_IMPORTED_MODEL and catModel and catModel.ClassName == "Model" then
        print("Found CosmoKitten model in ReplicatedStorage, trying imported model")
        
        local hasHumanoid = catModel:FindFirstChild("Humanoid")
        local hasHumanoidRootPart = catModel:FindFirstChild("HumanoidRootPart")
        
        if hasHumanoid and hasHumanoidRootPart then
            print("CosmoKitten imported model has Humanoid and HumanoidRootPart - using it")
            
            local characterModel = catModel:Clone()
            characterModel.Name = player.Name
            
            -- Configure humanoid
            local humanoid = characterModel:FindFirstChild("Humanoid")
            humanoid.DisplayName = "Level " .. level .. " - " .. catModelName
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
            humanoid.MaxHealth = 100
            humanoid.Health = 100
            
            -- Configure HumanoidRootPart (invisible physics capsule)
            local humanoidRootPart = characterModel:FindFirstChild("HumanoidRootPart")
            humanoidRootPart.Anchored = false
            humanoidRootPart.CanCollide = true
            humanoidRootPart.Transparency = 1 -- hide the gray block
            
            -- Find main visible mesh (e.g. "input")
            local mainMeshPart
            for _, child in ipairs(characterModel:GetChildren()) do
                if child:IsA("MeshPart") then
                    mainMeshPart = child
                    break
                end
            end
            
            if mainMeshPart then
                -- If mesh is huge, rescale to a reasonable cat size
                if mainMeshPart.Size.Magnitude > 50 then
                    local targetSize = Vector3.new(2.5, 3, 5)
                    print("Rescaling CosmoKitten mesh from", mainMeshPart.Size, "to", targetSize)
                    mainMeshPart.Size = targetSize
                end
                
                -- Position mesh relative to HumanoidRootPart so it sits on the baseplate
                mainMeshPart.Anchored = false
                mainMeshPart.CanCollide = false
                mainMeshPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 2, 0)
                
                -- Weld mesh to HumanoidRootPart so it follows movement
                if not mainMeshPart:FindFirstChildOfClass("WeldConstraint") then
                    local weld = Instance.new("WeldConstraint")
                    weld.Name = "RootToMeshWeld"
                    weld.Part0 = humanoidRootPart
                    weld.Part1 = mainMeshPart
                    weld.Parent = humanoidRootPart
                end
            end
            
            -- Make all other parts non-colliding so physics is stable
            for _, part in ipairs(characterModel:GetDescendants()) do
                if part:IsA("BasePart") and part ~= humanoidRootPart and part ~= mainMeshPart then
                    part.CanCollide = false
                end
            end
            
            -- Add marker so we don't replace this character again
            local catAppearanceMarker = Instance.new("BoolValue")
            catAppearanceMarker.Name = "CatAppearance"
            catAppearanceMarker.Value = true
            catAppearanceMarker.Parent = characterModel
            
            print("Using imported CosmoKitten model as character")
            return characterModel
        else
            print("WARNING: Imported CosmoKitten model missing Humanoid or HumanoidRootPart")
        end
    end
    
    -- Fallback: create a simple, stable cat character from parts
    print("Using simple fallback cat character (no valid imported model)")
    
    -- Create the character Model
    local characterModel = Instance.new("Model")
    characterModel.Name = player.Name
    
    -- Create HumanoidRootPart (required for movement)
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Size = Vector3.new(2, 2, 1)
    -- Spawn the character a bit above the baseplate so it is clearly visible
    humanoidRootPart.Position = Vector3.new(0, 10, 0)
    humanoidRootPart.Anchored = false
    humanoidRootPart.CanCollide = true
    humanoidRootPart.Material = Enum.Material.SmoothPlastic
    humanoidRootPart.Color = Color3.fromRGB(100, 100, 100) -- Neutral gray
    humanoidRootPart.Parent = characterModel
    
    -- Set as PrimaryPart (required)
    characterModel.PrimaryPart = humanoidRootPart
    
    -- Create Humanoid (required for movement)
    local humanoid = Instance.new("Humanoid")
    humanoid.DisplayName = "Level " .. level .. " - " .. catModelName
    humanoid.WalkSpeed = 16
    humanoid.JumpPower = 50
    humanoid.MaxHealth = 100
    humanoid.Health = 100
    humanoid.Parent = characterModel
    
    -- Create a simple fallback cat appearance
    local catBody = Instance.new("Part")
    catBody.Name = "CatBody"
    catBody.Size = Vector3.new(3, 4, 2)
    catBody.Color = Color3.fromRGB(255, 165, 0) -- Orange
    catBody.Material = Enum.Material.Neon
    catBody.Anchored = false
    catBody.CanCollide = false
    catBody.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 1, 0)
    catBody.Parent = characterModel
    
    -- Create cat head
    local catHead = Instance.new("Part")
    catHead.Name = "CatHead"
    catHead.Shape = Enum.PartType.Ball
    catHead.Size = Vector3.new(2, 2, 2)
    catHead.Color = Color3.fromRGB(255, 200, 100) -- Light orange
    catHead.Material = Enum.Material.Neon
    catHead.Anchored = false
    catHead.CanCollide = false
    catHead.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 3, 0)
    catHead.Parent = characterModel
    
    -- Create cat ears
    local leftEar = Instance.new("Part")
    leftEar.Name = "LeftEar"
    leftEar.Size = Vector3.new(0.5, 1, 0.5)
    leftEar.Color = Color3.fromRGB(255, 200, 100)
    leftEar.Material = Enum.Material.Neon
    leftEar.Anchored = false
    leftEar.CanCollide = false
    leftEar.CFrame = humanoidRootPart.CFrame * CFrame.new(-0.8, 4, 0)
    leftEar.Parent = characterModel
    
    local rightEar = Instance.new("Part")
    rightEar.Name = "RightEar"
    rightEar.Size = Vector3.new(0.5, 1, 0.5)
    rightEar.Color = Color3.fromRGB(255, 200, 100)
    rightEar.Material = Enum.Material.Neon
    rightEar.Anchored = false
    rightEar.CanCollide = false
    rightEar.CFrame = humanoidRootPart.CFrame * CFrame.new(0.8, 4, 0)
    rightEar.Parent = characterModel
    
    -- Create cat tail
    local catTail = Instance.new("Part")
    catTail.Name = "CatTail"
    catTail.Size = Vector3.new(0.5, 2, 0.5)
    catTail.Color = Color3.fromRGB(255, 200, 100)
    catTail.Material = Enum.Material.Neon
    catTail.Anchored = false
    catTail.CanCollide = false
    catTail.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 1, -1.5)
    catTail.Parent = characterModel
    
    -- Add a marker to identify this as a custom cat character
    local catAppearanceMarker = Instance.new("BoolValue")
    catAppearanceMarker.Name = "CatAppearance"
    catAppearanceMarker.Value = true
    catAppearanceMarker.Parent = characterModel
    
    print("Fallback cat model created - replace with imported CosmoKitten when ready")
    return characterModel
end

-- Function to set the player's character
local function SetPlayerCharacter(player, level)
    print("Setting character for", player.Name, "to level", level)
    
    -- Set flag to prevent infinite loop
    PlayerFlags[player] = true
    
    -- Create the cat character Model
    local catCharacter = CreateCatCharacterModel(player, level)
    
    -- Ensure position is set BEFORE parenting to workspace
    local humanoidRootPart = catCharacter:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        -- Temporarily anchor to set position
        humanoidRootPart.Anchored = true
        humanoidRootPart.Position = Vector3.new(0, 5, 0)
    end
    
    -- Set it as the player's character
    player.Character = catCharacter
    
    -- Parent to workspace
    catCharacter.Parent = workspace
    
    -- Now unanchor after a brief moment
    if humanoidRootPart then
        spawn(function()
            wait(0.3) -- Give physics time to initialize
            if humanoidRootPart and humanoidRootPart.Parent then
                humanoidRootPart.Anchored = false
                print("Character unanchored at position:", humanoidRootPart.Position)
            end
        end)
    end
    
    print("Player character set successfully! Character name:", catCharacter.Name, "Parent:", catCharacter.Parent and catCharacter.Parent.Name or "None")
    
    -- Clear flag after a short delay
    spawn(function()
        wait(1)
        PlayerFlags[player] = nil
        print("Player flag cleared for", player.Name)
    end)
    
    return catCharacter
end

-- Function to handle when a default character is added
local function OnCharacterAdded(character, player)
    -- Prevent infinite loop
    if PlayerFlags[player] then
        print("Skipping character replacement for", player.Name, "- already processing")
        return
    end
    
    -- Check if this is a valid character to replace (not our custom one)
    if character and character.Parent and not character:FindFirstChild("CatAppearance") then
        print("Default character detected for", player.Name, "- replacing with cat")
        
        -- Wait a moment for the character to fully load
        wait(0.1)
        
        -- Double-check this is still the default character before destroying
        if character and character.Parent and not character:FindFirstChild("CatAppearance") then
            character:Destroy()
            print("Default character destroyed")
            
            -- Create and set our cat character
            SetPlayerCharacter(player, 1)
        else
            print("Character already replaced or is our custom character")
        end
    else
        print("Character is already our custom character or invalid")
    end
end

-- Handle when player joins
local function OnPlayerAdded(player)
    print("Player joined:", player.Name)
    
    -- Connect to character added event to catch any default characters
    player.CharacterAdded:Connect(function(character)
        OnCharacterAdded(character, player)
    end)
    
    -- Handle existing character if any
    if player.Character then
        OnCharacterAdded(player.Character, player)
    end
end

-- Initialize the system
function CatAvatarManager.Initialize()
    print("Initializing ReplicatedStorage-based Cat Avatar System...")
    
    -- Connect to player joining
    Players.PlayerAdded:Connect(OnPlayerAdded)
    
    -- Handle existing players
    for _, player in pairs(Players:GetPlayers()) do
        OnPlayerAdded(player)
    end
    
    print("ReplicatedStorage-based Cat Avatar System initialized!")
    return true
end

-- Function to update avatar when player levels up
function CatAvatarManager.UpdatePlayerAvatar(player, newLevel)
    print("Updating avatar for", player.Name, "to level", newLevel)
    
    -- Get the appropriate avatar for this level
    local avatarName = LevelAvatars[newLevel] or "CosmoKitten"
    print("Level", newLevel, "should use avatar:", avatarName)
    
    -- Check if we need to switch avatars
    if player.Character and player.Character:FindFirstChild("CatAppearance") then
        local currentAvatar = player.Character:FindFirstChild("CatAppearance")
        if currentAvatar.Value then
            print("Player already has a custom avatar, checking if we need to switch")
            
            -- Get the current avatar model name from the character
            local currentModelName = "CosmoKitten" -- Default fallback
            if player.Character.Name == player.Name then
                -- This is a custom character, check what type it is
                for _, child in pairs(player.Character:GetChildren()) do
                    if child.ClassName == "Model" and child.Name ~= player.Name then
                        currentModelName = child.Name
                        break
                    end
                end
            end
            
            print("Current avatar model:", currentModelName, "Target avatar:", avatarName)
            
            -- Only switch if the avatar is different
            if currentModelName ~= avatarName then
                print("Switching avatar from", currentModelName, "to", avatarName)
                
                -- Destroy current character and create new one
                if player.Character then
                    player.Character:Destroy()
                end
                
                -- Create new character with the appropriate avatar
                SetPlayerCharacter(player, newLevel)
                return
            else
                print("Avatar is already correct, just updating display name")
            end
        end
    end
    
    -- Update the display name
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        humanoid.DisplayName = "Level " .. newLevel .. " - " .. avatarName
        print("Updated display name to:", humanoid.DisplayName)
    end
end

return CatAvatarManager
