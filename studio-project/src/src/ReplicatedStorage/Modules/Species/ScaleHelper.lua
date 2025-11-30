-- ScaleHelper.lua
-- Helper functions for applying scale to species models using Humanoid:ApplyDescriptionScale().

local ScaleHelper = {}

--[[
    Applies scale to a character's Humanoid using Humanoid:ApplyDescriptionScale().
    
    @param humanoid Humanoid - The character's Humanoid
    @param scale number - The scale multiplier (e.g., 1.0 for adult, 0.6-0.75 for kitten, 1.2-1.3 for premium)
    @return boolean - Success status
]]
function ScaleHelper.ApplyScale(humanoid: Humanoid, scale: number): boolean
    if not humanoid then
        warn("[ScaleHelper] Humanoid is nil")
        return false
    end
    
    if type(scale) ~= "number" or scale <= 0 then
        warn("[ScaleHelper] Invalid scale value:", scale)
        return false
    end
    
    -- Get current HumanoidDescription
    local humanoidDescription = humanoid:GetAppliedDescription()
    
    -- Apply scale
    humanoidDescription.HeadScale = scale
    humanoidDescription.DepthScale = scale
    humanoidDescription.HeightScale = scale
    humanoidDescription.ProportionScale = scale
    humanoidDescription.WidthScale = scale
    
    -- Apply the scaled description
    humanoid:ApplyDescription(humanoidDescription)
    
    return true
end

return ScaleHelper

