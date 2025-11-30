-- SpeciesClient.client.lua
-- Handles species selection UI + communicates with server.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Species")
local RequestSetSpecies = Remotes:WaitForChild("RequestSetSpecies")
local ConfirmSpecies = Remotes:WaitForChild("ConfirmSpecies")
local GetPlayerSpecies = Remotes:WaitForChild("GetPlayerSpecies")

-- UI reference (will be created in StarterGui)
local StarterGui = game:GetService("StarterGui")
local speciesSelector = StarterGui:FindFirstChild("SpeciesSelectorGui")

-- Called when player picks a species
local function onSpeciesChosen(speciesId)
    print("[SpeciesClient] Requesting species:", speciesId)
    RequestSetSpecies:FireServer(speciesId)
end

-- Server confirms change
ConfirmSpecies.OnClientEvent:Connect(function(speciesId)
    print("[Cosmo Cats] Species confirmed:", speciesId)
    
    -- Update UI to show selected species
    if speciesSelector then
        -- Update selected species indicator in UI
        local selectedIndicator = speciesSelector:FindFirstChild("SelectedIndicator")
        if selectedIndicator then
            selectedIndicator.Text = "Selected: " .. speciesId
            selectedIndicator.Visible = true
        end
        
        -- Highlight the selected button
        local buttons = speciesSelector:FindFirstChild("Buttons")
        if buttons then
            for _, button in ipairs(buttons:GetChildren()) do
                if button:IsA("GuiButton") then
                    -- Reset all buttons
                    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    -- Highlight selected button
                    if button.Name == speciesId or button:GetAttribute("SpeciesId") == speciesId then
                        button.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
                    end
                end
            end
        end
    end
    
    -- TODO: Play confirmation sound/effect (requires sound/effect assets)
    -- local sound = Instance.new("Sound")
    -- sound.SoundId = "rbxassetid://CONFIRMATION_SOUND_ID"
    -- sound.Parent = player:FindFirstChild("PlayerGui")
    -- sound:Play()
end)

-- Get current species from server
local function getCurrentSpecies()
    local currentSpecies = GetPlayerSpecies:InvokeServer()
    print("[SpeciesClient] Current species:", currentSpecies)
    return currentSpecies
end

-- Connect GUI buttons when UI is created
task.spawn(function()
    -- Wait for UI to be created
    local maxWait = 10
    local waited = 0
    while not speciesSelector and waited < maxWait do
        task.wait(0.5)
        speciesSelector = StarterGui:FindFirstChild("SpeciesSelectorGui")
        waited = waited + 0.5
    end
    
    if speciesSelector then
        local buttons = speciesSelector:FindFirstChild("Buttons")
        if buttons then
            -- Connect all species buttons
            for _, button in ipairs(buttons:GetChildren()) do
                if button:IsA("GuiButton") then
                    -- Get species ID from button name or attribute
                    local speciesId = button:GetAttribute("SpeciesId") or button.Name
                    
                    -- Connect click event
                    button.MouseButton1Click:Connect(function()
                        onSpeciesChosen(speciesId)
                    end)
                    
                    print("[SpeciesClient] Connected button:", button.Name, "→", speciesId)
                end
            end
        else
            warn("[SpeciesClient] Buttons folder not found in SpeciesSelectorGui")
        end
    else
        warn("[SpeciesClient] SpeciesSelectorGui not found - UI buttons will not be connected")
    end
end)

-- Initialize: Get current species on load
task.wait(1) -- Wait for server to be ready
getCurrentSpecies()

return {}

