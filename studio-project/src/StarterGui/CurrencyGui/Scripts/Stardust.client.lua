-- Stardust.client.lua
-- Updates Stardust display in real-time.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrencyController = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Currency"):WaitForChild("CurrencyController"))

local gui = script.Parent.Parent -- StardustGui
local label = gui:WaitForChild("StardustLabel")

local function update(amount)
    label.Text = "Stardust: " .. tostring(amount)
end

-- Connect to currency updates
CurrencyController.OnUpdated = update

-- Request initial balance
task.wait(1) -- Wait for CurrencyController to initialize
local initial = CurrencyController.RequestBalance()
update(initial)


