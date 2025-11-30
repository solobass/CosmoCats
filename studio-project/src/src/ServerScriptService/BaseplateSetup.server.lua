-- Baseplate setup for CosmoCat
print("=== SETTING UP BASEPLATE ===")

-- Services
local Workspace = game:GetService("Workspace")

-- Check if baseplate already exists
local existingBaseplate = Workspace:FindFirstChild("Baseplate")
if existingBaseplate then
    print("Baseplate already exists, skipping creation")
    return
end

-- Create baseplate
local baseplate = Instance.new("Part")
baseplate.Name = "Baseplate"
baseplate.Size = Vector3.new(1000, 1, 1000)
baseplate.Position = Vector3.new(0, 0, 0)
baseplate.Anchored = true
baseplate.CanCollide = true
baseplate.Material = Enum.Material.SmoothPlastic
baseplate.Color = Color3.fromRGB(0, 0, 0) -- Black
baseplate.Transparency = 0.8 -- Mostly invisible
baseplate.Parent = Workspace

-- Ensure the baseplate is properly set up for collision
baseplate.TopSurface = Enum.SurfaceType.Smooth
baseplate.BottomSurface = Enum.SurfaceType.Smooth
baseplate.FrontSurface = Enum.SurfaceType.Smooth
baseplate.BackSurface = Enum.SurfaceType.Smooth
baseplate.LeftSurface = Enum.SurfaceType.Smooth
baseplate.RightSurface = Enum.SurfaceType.Smooth

-- Add a small invisible wall around the edges to prevent characters from falling off
local function CreateBoundaryWall(position, size)
    local wall = Instance.new("Part")
    wall.Name = "BoundaryWall"
    wall.Size = size
    wall.Position = position
    wall.Anchored = true
    wall.CanCollide = true
    wall.Material = Enum.Material.SmoothPlastic
    wall.Color = Color3.fromRGB(0, 0, 0)
    wall.Transparency = 1 -- Completely invisible
    wall.Parent = Workspace
end

-- Create boundary walls
CreateBoundaryWall(Vector3.new(0, 5, 500), Vector3.new(1000, 10, 1))  -- North wall
CreateBoundaryWall(Vector3.new(0, 5, -500), Vector3.new(1000, 10, 1)) -- South wall
CreateBoundaryWall(Vector3.new(500, 5, 0), Vector3.new(1, 10, 1000))  -- East wall
CreateBoundaryWall(Vector3.new(-500, 5, 0), Vector3.new(1, 10, 1000)) -- West wall

print("Baseplate created successfully")

-- Create sky
local sky = Instance.new("Sky")
sky.Name = "CosmoCatSky"
sky.SkyboxBk = "rbxassetid://6444884337" -- Black sky
sky.SkyboxDn = "rbxassetid://6444884337"
sky.SkyboxFt = "rbxassetid://6444884337"
sky.SkyboxLf = "rbxassetid://6444884337"
sky.SkyboxRt = "rbxassetid://6444884337"
sky.SkyboxUp = "rbxassetid://6444884337"
sky.Parent = Workspace

print("Sky created successfully")

print("=== BASEPLATE SETUP COMPLETE ===")
