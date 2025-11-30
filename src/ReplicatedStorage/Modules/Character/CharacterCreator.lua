-- CharacterCreator.lua
-- Shared logic for applying cosmetic data to a cat character (colors, patterns, effects).

local CharacterCreator = {}

--[[
    Concept:

    "AppearanceData" schema example:

    {
        primaryColor = Color3,
        secondaryColor = Color3,
        detailColor = Color3,
        patternId = "NEBULA_TABS",
        eyeStyleId = "COSMIC_BLUE",
        tailStyleId = "NEBULA_TAIL",
        accessories = { "STAR_COLLAR", "EAR_CRYSTALS" },
        effects = { "NEBULA_AURA", "STAR_TRAIL" },
        sizeScale = 1.0,
    }

    CharacterCreator.ApplyAppearance(character: Model, appearanceData)
]]

local PatternLibrary = require(script.Parent.PatternLibrary)
local AccessoriesLibrary = require(script.Parent.AccessoriesLibrary)
local EffectsLibrary = require(script.Parent.EffectsLibrary)

function CharacterCreator.ApplyAppearance(character: Model, appearanceData: table)
    -- TODO:
    -- 1. Apply base colors to relevant parts
    -- 2. Apply pattern textures / decals (via PatternLibrary)
    -- 3. Attach accessories (AccessoriesLibrary)
    -- 4. Attach particle effects (EffectsLibrary)
    -- 5. Adjust character scale if needed
    
    if not character or not appearanceData then
        warn("[CharacterCreator] Invalid character or appearanceData")
        return
    end
    
    -- Apply colors
    if appearanceData.primaryColor then
        -- TODO: Apply to body parts
    end
    
    if appearanceData.secondaryColor then
        -- TODO: Apply to secondary parts
    end
    
    if appearanceData.detailColor then
        -- TODO: Apply to details (eyes, etc.)
    end
    
    -- Apply pattern
    if appearanceData.patternId then
        local patternAssetId = PatternLibrary.Get(appearanceData.patternId)
        if patternAssetId then
            -- TODO: Apply pattern texture/decal
            -- Example: head.TextureID = patternAssetId
            -- Example: body.TextureID = patternAssetId
            -- Or use SurfaceAppearance for complex patterns
        end
    end
    
    -- Apply accessories
    if appearanceData.accessories then
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local accessoriesFolder = ReplicatedStorage:FindFirstChild("CosmoCatsAccessories")
        
        for _, accessoryId in ipairs(appearanceData.accessories) do
            local accessoryData = AccessoriesLibrary.Get(accessoryId)
            if accessoryData and accessoriesFolder then
                local accessoryFolder = accessoriesFolder:FindFirstChild(accessoryId)
                if accessoryFolder then
                    local meshPart = accessoryFolder:FindFirstChild("MeshPart")
                    if meshPart then
                        -- TODO: Clone and attach accessory to character
                        -- Example:
                        -- local clonedPart = meshPart:Clone()
                        -- Find attachment point on character (e.g., character:FindFirstChild(accessoryData.attachmentPoint, true))
                        -- Create WeldConstraint to attach
                        -- clonedPart.Parent = character
                    end
                end
            else
                warn("[CharacterCreator] Unknown accessory or folder missing:", accessoryId)
            end
        end
    end
    
    -- Apply effects
    if appearanceData.effects then
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local effectsFolder = ReplicatedStorage:FindFirstChild("CosmoCatsEffects")
        
        for _, effectId in ipairs(appearanceData.effects) do
            local effectData = EffectsLibrary.Get(effectId)
            if effectData and effectsFolder then
                local effectModel = effectsFolder:FindFirstChild(effectData.fileName)
                if effectModel then
                    -- TODO: Clone and attach effect to character
                    -- Example:
                    -- local clonedEffect = effectModel:Clone()
                    -- Find attachment point based on effectData.attachmentPoint
                    -- - "HumanoidRootPart" for aura effects
                    -- - "TailTip" for trail effects (or tail end)
                    -- - "Head" for head effects
                    -- clonedEffect.Parent = attachmentPoint
                end
            else
                warn("[CharacterCreator] Unknown effect or folder missing:", effectId)
            end
        end
    end
    
    -- Apply scale
    if appearanceData.sizeScale and appearanceData.sizeScale ~= 1.0 then
        -- TODO: Scale character model
    end
end

-- Get default appearance for a species
function CharacterCreator.GetDefaultAppearance(speciesId: string): table
    -- TODO: Return default appearance data for the species
    return {
        primaryColor = Color3.fromRGB(100, 100, 150),
        secondaryColor = Color3.fromRGB(150, 150, 200),
        detailColor = Color3.fromRGB(255, 255, 255),
        patternId = nil,
        eyeStyleId = "DEFAULT",
        tailStyleId = "DEFAULT",
        accessories = {},
        effects = {},
        sizeScale = 1.0,
    }
end

-- TODO: Add helper to build a default appearance for a species.

return CharacterCreator

