-- EmoteController.lua
-- Client-side controller for playing emote animations on the player's character.

local EmoteController = {}

--[[
    Goals:

    - Provide a unified API:
        EmoteController.PlayEmote("SIT")
        EmoteController.StopCurrentEmote()

    - Connect to:
        - EmoteBar GUI buttons
        - Number key hotkeys (1-9)

    - Use Animation objects stored in ReplicatedStorage/SharedAnimations or species-specific folders.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SharedAnimations = ReplicatedStorage:WaitForChild("SharedAnimations")

local currentTrack: AnimationTrack? = nil

local function getHumanoid()
    local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid") :: Humanoid
end

local emoteIdToAnimationName = {
    SIT = "Sit",
    LAY = "Lay",
    LOAF = "Loaf",
    GROOM = "Groom",
    TAIL_FLICK = "TailFlick",
    ROLL = "Roll",
    MEOW = "Meow", -- could be sound only or paired with animation
    -- TODO: Fill in more emotes
}

function EmoteController.PlayEmote(emoteId: string)
    local humanoid = getHumanoid()

    -- Stop currently playing track
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end

    local animName = emoteIdToAnimationName[emoteId]
    if not animName then
        warn("Unknown emoteId:", emoteId)
        return
    end

    local animObj = SharedAnimations:FindFirstChild(animName)
    if not animObj then
        warn("Missing Animation object for emote:", animName)
        return
    end

    local track = humanoid:LoadAnimation(animObj)
    currentTrack = track
    track:Play()
end

function EmoteController.StopCurrentEmote()
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end
end

-- TODO: Connect to EmoteBar UI & keybinds in EmoteBar.client.lua

return EmoteController

