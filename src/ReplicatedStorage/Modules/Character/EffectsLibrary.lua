-- EffectsLibrary.lua
-- Available effects (particles, trails, etc.) for characters.
--
-- Effects / Particle Library:
-- - Effects are stored as .rbxm files in ReplicatedStorage/CosmoCatsEffects/
-- - Named in PascalCase (e.g., NebulaAura.rbxm)
-- - Cursor attaches them automatically to HumanoidRootPart, TailTip, or Head
-- - Depending on effect type
--
-- Effect Format:
-- {
--     id = "NEBULA_AURA",
--     displayName = "Nebula Aura",
--     fileName = "NebulaAura", -- Name of .rbxm file
--     attachmentPoint = "HumanoidRootPart", -- HumanoidRootPart | TailTip | Head
--     category = "Rare", -- Common | Rare | Epic | Legendary
-- }

local EffectsLibrary = {}

--[[
    Effects Library Format
    
    Effects stored as:
    {
        [effectId] = {
            id = "NEBULA_AURA",
            displayName = "Nebula Aura",
            fileName = "NebulaAura", -- Name of .rbxm file in CosmoCatsEffects/
            attachmentPoint = "HumanoidRootPart", -- HumanoidRootPart | TailTip | Head
            category = "Rare", -- Common | Rare | Epic | Legendary
        }
    }
    
    Cursor attaches effects automatically:
    - Load from: ReplicatedStorage.CosmoCatsEffects[fileName].rbxm
    - Attach to appropriate part based on attachmentPoint
]]

local Effects = {
    -- TODO: Add effect definitions
    -- NEBULA_AURA = {
    --     id = "NEBULA_AURA",
    --     displayName = "Nebula Aura",
    --     fileName = "NebulaAura",
    --     attachmentPoint = "HumanoidRootPart",
    --     category = "Rare",
    -- },
    -- STAR_TRAIL = {
    --     id = "STAR_TRAIL",
    --     displayName = "Star Trail",
    --     fileName = "StarTrail",
    --     attachmentPoint = "TailTip",
    --     category = "Epic",
    -- },
    -- QUANTUM_GLITCH = {
    --     id = "QUANTUM_GLITCH",
    --     displayName = "Quantum Glitch",
    --     fileName = "QuantumGlitch",
    --     attachmentPoint = "Head",
    --     category = "Legendary",
    -- },
}

function EffectsLibrary.Get(effectId: string): table?
    return Effects[effectId]
end

function EffectsLibrary.GetAll(): { [string]: table }
    return Effects
end

function EffectsLibrary.Has(effectId: string): boolean
    return Effects[effectId] ~= nil
end

return EffectsLibrary

