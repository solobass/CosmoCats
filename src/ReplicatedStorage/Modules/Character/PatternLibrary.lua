-- PatternLibrary.lua
-- Available patterns for character customization.
-- 
-- Pattern & Texture Pipeline:
-- - Each pattern is stored as a Roblox asset ID
-- - Patterns can be applied to head, body, or both
-- - Cursor will apply patterns using: part.TextureID = Patterns[patternId]
-- - Or use SurfaceAppearance for complex multi-layer patterns
--
-- UV Layout Requirements:
-- - Do NOT overlap UVs
-- - Use clear torso/limb separation
-- - Support multiple mask layers

local PatternLibrary = {}

--[[
    Pattern Library Format
    
    Patterns stored as:
    {
        [patternId] = "rbxassetid://XXXXXXXX",
    }
    
    Cursor will apply patterns using:
    - head.TextureID = Patterns[patternId]
    - body.TextureID = Patterns[patternId]
    - Or use SurfaceAppearance for complex multi-layer patterns
]]

local Patterns = {
    -- TODO: Add pattern asset IDs
    -- STARFIELD = "rbxassetid://XXXXXXXX",
    -- NEBULA_SWIRL = "rbxassetid://XXXXXXXX",
    -- COMET_TABS = "rbxassetid://XXXXXXXX",
}

function PatternLibrary.Get(patternId: string): string?
    return Patterns[patternId]
end

function PatternLibrary.GetAll(): { [string]: string }
    return Patterns
end

function PatternLibrary.Has(patternId: string): boolean
    return Patterns[patternId] ~= nil
end

return PatternLibrary

