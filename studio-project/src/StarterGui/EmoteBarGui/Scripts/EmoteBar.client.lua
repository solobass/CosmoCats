-- EmoteBar.client.lua
-- Handles emote bar UI and emote playback.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local EmoteController = require(Modules:WaitForChild("Emotes"):WaitForChild("EmoteController"))

local gui = script.Parent.Parent -- EmoteBarGui
local screenGui = gui:WaitForChild("EmoteBarScreenGui")
local emoteFrame = screenGui:WaitForChild("Frame_EmoteButtons")

-- Emote IDs in order
local emoteOrder = {
    "SIT",
    "LAY",
    "LOAF",
    "GROOM",
    "MEOW",
    "TAIL_FLICK",
    "ROLL",
    "STRETCH",
}

-- Connect emote buttons
for i, emoteId in ipairs(emoteOrder) do
    local button = emoteFrame:FindFirstChild("Emote" .. i)
    if button then
        button.MouseButton1Click:Connect(function()
            EmoteController.PlayEmote(emoteId)
        end)
        
        -- Set button text
        button.Text = emoteId
    end
end

-- Number key bindings (1-9)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode.Value >= 49 and input.KeyCode.Value <= 57 then -- Keys 1-9
        local index = input.KeyCode.Value - 48 -- Convert to 1-9
        if emoteOrder[index] then
            EmoteController.PlayEmote(emoteOrder[index])
        end
    end
end)


