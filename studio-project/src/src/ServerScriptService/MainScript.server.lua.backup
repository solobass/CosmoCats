-- Clean CatTreat spawning system for CosmoCat
print("=== CATTREAT SYSTEM STARTING ===")

-- Services
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create RemoteEvent for client-server communication
print("Creating RemoteEvents...")
local RemoteEvents = Instance.new("Folder")
RemoteEvents.Name = "RemoteEvents"
RemoteEvents.Parent = ReplicatedStorage

local CollectCatTreatEvent = Instance.new("RemoteEvent")
CollectCatTreatEvent.Name = "CollectCatTreat"
CollectCatTreatEvent.Parent = RemoteEvents

print("RemoteEvents created successfully!")

-- Initialize Cat Avatar System
print("=== INITIALIZING CAT AVATAR SYSTEM ===")
local success, CatAvatarManager = pcall(require, ReplicatedStorage:WaitForChild("Shared"):WaitForChild("CatAvatarManager"))

if not success then
    print("ERROR: Failed to require CatAvatarManager:", CatAvatarManager)
    return
end

print("CatAvatarManager loaded successfully")

local initSuccess, initResult = pcall(function()
    return CatAvatarManager.Initialize()
end)

if not initSuccess then
    print("ERROR: Failed to initialize CatAvatarManager:", initResult)
else
    print("CatAvatarManager initialized successfully")
end

-- Handle CatTreat collection requests from clients
local function HandleCatTreatCollection(player, catTreatInfo)
    if not catTreatInfo or type(catTreatInfo) ~= "table" then
        return
    end
    
    -- Find the actual CatTreat object in workspace by name and position
    local foundCatTreat = nil
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name == catTreatInfo.name and obj:IsA(catTreatInfo.className) then
            -- Check if position matches (within reasonable tolerance)
            local objPosition
            if obj:IsA("Model") then
                objPosition = obj.PrimaryPart and obj.PrimaryPart.Position or obj:FindFirstChildOfClass("Part") and obj:FindFirstChildOfClass("Part").Position
            else
                objPosition = obj.Position
            end
            
            if objPosition and (objPosition - catTreatInfo.position).Magnitude < 5 then
                foundCatTreat = obj
                break
            end
        end
    end
    
    if not foundCatTreat then
        return
    end
    
    -- Check if CatTreat has points and destroy it
    local points = foundCatTreat:FindFirstChild("Points")
    if points then
        foundCatTreat:Destroy()
        print("CatTreat collected and destroyed by", player.Name)
    end
end

-- Connect the RemoteEvent
CollectCatTreatEvent.OnServerEvent:Connect(HandleCatTreatCollection)
print("CatTreat collection handler connected!")

-- Configuration
local MAX_CATTREATS = 25
local SPAWN_HEIGHT = 50
local LAND_HEIGHT = 1
local PLAY_AREA_SIZE = 100
local FALL_TIME = 4

-- Function to create a CatTreat
local function CreateCatTreat()
    -- Find the CatTreat model in ReplicatedStorage
    local catTreatModel = ReplicatedStorage:FindFirstChild("CatTreat")
    if catTreatModel then
        print("Found CatTreat model in ReplicatedStorage")
        return catTreatModel:Clone()
    end
    
    -- Also check if CatTreat is directly in Workspace
    local workspaceCatTreat = Workspace:FindFirstChild("CatTreat")
    if workspaceCatTreat then
        local catTreat = workspaceCatTreat:Clone()
        
        -- Scale the model appropriately
        for _, part in pairs(catTreat:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Size = part.Size * 0.03
            end
        end
        
        -- Set properties for all BasePart descendants
        for _, part in pairs(catTreat:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = true
                part.CanCollide = false
            end
        end
        
        -- Add points value
        local points = Instance.new("IntValue")
        points.Name = "Points"
        points.Value = 1
        points.Parent = catTreat
        
        return catTreat
    end
    
    -- Fallback: create a simple Part if the model isn't found
    local catTreat = Instance.new("Part")
    catTreat.Name = "CatTreat"
    catTreat.Size = Vector3.new(2, 2, 2)
    catTreat.Color = Color3.fromRGB(255, 255, 0) -- Yellow
    catTreat.Material = Enum.Material.Neon
    catTreat.Anchored = true
    catTreat.CanCollide = false
    
    -- Add points value
    local points = Instance.new("IntValue")
    points.Name = "Points"
    points.Value = 1
    points.Parent = catTreat
    
    return catTreat
end

-- Spawn a single CatTreat at random position
local function SpawnCatTreat()
    local catTreat = CreateCatTreat()
    
    -- Add the CatTreat to workspace
    catTreat.Parent = workspace
    
    -- Random spawn position in the sky (diagonal shooting star effect)
    local spawnX = math.random(-PLAY_AREA_SIZE, PLAY_AREA_SIZE)
    local spawnZ = math.random(-PLAY_AREA_SIZE, PLAY_AREA_SIZE)
    local spawnPos = Vector3.new(spawnX, SPAWN_HEIGHT, spawnZ)
    
    -- Random landing position on the ground (spread out)
    local landX = math.random(-PLAY_AREA_SIZE, PLAY_AREA_SIZE)
    local landZ = math.random(-PLAY_AREA_SIZE, PLAY_AREA_SIZE)
    local landPos = Vector3.new(landX, LAND_HEIGHT, landZ)
    
    -- Set initial position based on whether it's a Model or Part
    if catTreat:IsA("Model") then
        -- For models, set the PrimaryPart position
        if catTreat.PrimaryPart then
            catTreat.PrimaryPart.Position = spawnPos
        else
            -- If no PrimaryPart, set the first Part's position
            local firstPart = catTreat:FindFirstChildOfClass("Part")
            if firstPart then
                firstPart.Position = spawnPos
            end
        end
    else
        -- For Parts, set position directly
        catTreat.Position = spawnPos
    end
    
    -- Animate the CatTreat falling (shooting star effect)
    if catTreat:IsA("Model") then
        -- For models, animate the PrimaryPart or first Part
        local partToAnimate = catTreat.PrimaryPart or catTreat:FindFirstChildOfClass("Part")
        if partToAnimate then
            local tween = TweenService:Create(
                partToAnimate,
                TweenInfo.new(FALL_TIME, Enum.EasingStyle.Linear),
                {Position = landPos}
            )
            tween:Play()
        end
    else
        -- For Parts, animate directly
        local tween = TweenService:Create(
            catTreat,
            TweenInfo.new(FALL_TIME, Enum.EasingStyle.Linear),
            {Position = landPos}
        )
        tween:Play()
    end
    
    return catTreat
end

-- Spawn all CatTreats
local function SpawnAllCatTreats()
    print("Starting CatTreat spawning...")
    
    for i = 1, MAX_CATTREATS do
        local catTreat = SpawnCatTreat()
        print("Spawned CatTreat", i, "of", MAX_CATTREATS)
    end
    
    print("All", MAX_CATTREATS, "CatTreats spawned! They will land in", FALL_TIME, "seconds.")
end

-- Start spawning
print("Starting CatTreat spawning...")
SpawnAllCatTreats()

print("=== CATTREAT SYSTEM COMPLETE ===")
print("=== COSMOCAT GAME SERVER FULLY INITIALIZED ===")

