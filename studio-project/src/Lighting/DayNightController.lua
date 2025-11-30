-- DayNightController.lua
-- Custom Stellar Cycle lighting system for Cosmo Cats world.

local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local DayNightController = {}

-- Stellar Cycle Configuration
local CYCLE_DURATION = 300 -- 5 minutes per cycle
local DAY_DURATION = CYCLE_DURATION * 0.5 -- 50% day
local NIGHT_DURATION = CYCLE_DURATION * 0.5 -- 50% night

-- Day Settings
local DAY_SETTINGS = {
    Ambient = Color3.fromRGB(100, 120, 150),
    Brightness = 2.5,
    FogColor = Color3.fromRGB(150, 150, 180),
    FogEnd = 1000,
    FogStart = 0,
    OutdoorAmbient = Color3.fromRGB(120, 140, 170),
    TimeOfDay = 12, -- Noon
}

-- Night Settings
local NIGHT_SETTINGS = {
    Ambient = Color3.fromRGB(50, 60, 80),
    Brightness = 0.5,
    FogColor = Color3.fromRGB(80, 60, 100),
    FogEnd = 500,
    FogStart = 0,
    OutdoorAmbient = Color3.fromRGB(60, 70, 90),
    TimeOfDay = 0, -- Midnight
}

-- Biome-specific overrides
local BIOME_OVERRIDES = {
    NebulaForest = {
        FogEnd = 700, -- 30% more fog
        FogStart = 0,
    },
    VoidTemple = {
        Brightness = 0.3, -- Always darker
        Ambient = Color3.fromRGB(30, 20, 40),
    },
    OuterRim = {
        Brightness = 0.2, -- Space darkness
        Ambient = Color3.fromRGB(10, 10, 20),
    },
}

local currentCycle = 0
local isDay = true

-- Tween lighting properties
local function tweenLighting(targetSettings, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    
    local properties = {
        Ambient = targetSettings.Ambient,
        Brightness = targetSettings.Brightness,
        FogColor = targetSettings.FogColor,
        FogEnd = targetSettings.FogEnd,
        FogStart = targetSettings.FogStart,
        OutdoorAmbient = targetSettings.OutdoorAmbient,
        TimeOfDay = targetSettings.TimeOfDay,
    }
    
    local tween = TweenService:Create(Lighting, tweenInfo, properties)
    tween:Play()
    
    return tween
end

-- Apply biome-specific overrides
local function applyBiomeOverrides(biomeName)
    local override = BIOME_OVERRIDES[biomeName]
    if override then
        for property, value in pairs(override) do
            Lighting[property] = value
        end
    end
end

-- Main cycle loop
local function startStellarCycle()
    task.spawn(function()
        while true do
            -- Day phase
            isDay = true
            tweenLighting(DAY_SETTINGS, 2)
            task.wait(DAY_DURATION)
            
            -- Transition to night
            tweenLighting(NIGHT_SETTINGS, 2)
            task.wait(2)
            isDay = false
            
            -- Night phase
            task.wait(NIGHT_DURATION - 2)
            
            currentCycle = currentCycle + 1
        end
    end)
end

-- Initialize
function DayNightController:Init()
    -- Set initial day settings
    for property, value in pairs(DAY_SETTINGS) do
        Lighting[property] = value
    end
    
    -- Start cycle
    startStellarCycle()
    
    print("[DayNightController] Stellar Cycle initialized")
end

-- Get current phase
function DayNightController:IsDay()
    return isDay
end

function DayNightController:IsNight()
    return not isDay
end

-- Apply biome lighting
function DayNightController:SetBiome(biomeName)
    applyBiomeOverrides(biomeName)
end

DayNightController:Init()

return DayNightController


