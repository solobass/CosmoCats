-- CosmoKitten Model
-- This creates a MeshPart that references the FBX file

local CosmoKitten = Instance.new("Model")
CosmoKitten.Name = "CosmoKitten"

-- Create the main MeshPart that will reference the FBX
local meshPart = Instance.new("MeshPart")
meshPart.Name = "CosmoKittenMesh"
meshPart.Size = Vector3.new(4, 4, 4) -- Adjust size as needed
meshPart.Position = Vector3.new(0, 0, 0)
meshPart.Anchored = false
meshPart.CanCollide = false
meshPart.Material = Enum.Material.SmoothPlastic
meshPart.Color = Color3.fromRGB(255, 200, 100) -- Orange color

-- Set the mesh to reference the FBX file
-- The FBX file is in the same StarterCharacter folder
meshPart.MeshId = "rbxasset://src/StarterPlayer/StarterCharacter/CosmoKitten.fbx"

meshPart.Parent = CosmoKitten

-- Set as PrimaryPart
CosmoKitten.PrimaryPart = meshPart

-- This will be loaded as a Model by Rojo
