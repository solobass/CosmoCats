-- SpeciesSelector.client.lua
-- Handles species selection UI and communicates with server.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Species")
local RequestSetSpecies = Remotes:WaitForChild("RequestSetSpecies")
local ConfirmSpecies = Remotes:WaitForChild("ConfirmSpecies")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local SpeciesController = require(Modules:WaitForChild("Species"):WaitForChild("SpeciesController"))
local CurrencyController = require(Modules:WaitForChild("Currency"):WaitForChild("CurrencyController"))

local gui = script.Parent.Parent -- SpeciesSelectorGui
local screenGui = gui:WaitForChild("SpeciesSelectorScreenGui")
local speciesFrame = screenGui:WaitForChild("Frame_SpeciesList")

local confirmButton = speciesFrame:WaitForChild("ConfirmButton")
local closeButton = speciesFrame:WaitForChild("CloseButton")
local scrollList = speciesFrame:WaitForChild("ScrollList")
local template = speciesFrame:WaitForChild("SpeciesButton_Template")

local selectedSpeciesId = nil
local speciesButtons = {}

-- Load all species
local function loadSpeciesList()
    local allSpecies = SpeciesController.GetAllSpecies()
    
    for speciesId, speciesData in pairs(allSpecies) do
        local button = template:Clone()
        button.Name = "Species_" .. speciesId
        button.Text = speciesData.displayName
        
        -- Check if locked
        local currentBalance = CurrencyController.GetBalance()
        local isLocked = false
        
        if speciesData.category == "Unlockable" then
            isLocked = currentBalance < speciesData.unlockCost
            if isLocked then
                button.Text = button.Text .. " (Locked - " .. speciesData.unlockCost .. " Stardust)"
            end
        elseif speciesData.category == "Premium" then
            isLocked = true
            button.Text = button.Text .. " (Premium)"
        end
        
        -- Set icon if available
        local cosmoCatsModels = ReplicatedStorage:FindFirstChild("CosmoCatsModels")
        if cosmoCatsModels then
            local speciesFolder = cosmoCatsModels:FindFirstChild(speciesId)
            if speciesFolder then
                local icon = speciesFolder:FindFirstChild("icon")
                if icon then
                    -- TODO: Set button image to icon
                end
            end
        end
        
        button.MouseButton1Click:Connect(function()
            if isLocked then
                -- Show purchase popup
                print("[SpeciesSelector] Species locked:", speciesId)
                -- TODO: Show purchase confirmation UI
            else
                selectedSpeciesId = speciesId
                print("[SpeciesSelector] Selected species:", speciesId)
            end
        end)
        
        button.Parent = scrollList
        speciesButtons[speciesId] = button
    end
    
    template.Visible = false
end

-- Confirm selection
confirmButton.MouseButton1Click:Connect(function()
    if selectedSpeciesId then
        print("[SpeciesSelector] Confirming species:", selectedSpeciesId)
        RequestSetSpecies:FireServer(selectedSpeciesId)
        screenGui.Enabled = false
    else
        warn("[SpeciesSelector] No species selected")
    end
end)

-- Close GUI
closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Server confirms change
ConfirmSpecies.OnClientEvent:Connect(function(speciesId)
    print("[SpeciesSelector] Species confirmed:", speciesId)
    screenGui.Enabled = false
end)

-- Load species list on start
task.wait(1) -- Wait for modules to load
loadSpeciesList()


