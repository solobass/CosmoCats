-- CurrencyController.lua
-- Client-side mirror of Stardust balance.

local CurrencyController = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Currency")
local CurrencyUpdated = Remotes:WaitForChild("CurrencyUpdated")
local GetStardustBalance = Remotes:WaitForChild("GetStardustBalance")

local localBalance = 0

function CurrencyController.GetBalance()
    return localBalance
end

function CurrencyController.RequestBalance()
    localBalance = GetStardustBalance:InvokeServer()
    return localBalance
end

function CurrencyController.RequestPurchase(unlockId)
    local RequestPurchaseUnlock = Remotes:WaitForChild("RequestPurchaseUnlock")
    RequestPurchaseUnlock:FireServer(unlockId)
end

-- Listen for server updates
CurrencyUpdated.OnClientEvent:Connect(function(newAmount)
    localBalance = newAmount
    
    -- Fire UI update signal
    if CurrencyController.OnUpdated then
        CurrencyController.OnUpdated(newAmount)
    end
end)

-- Request initial balance on load
task.wait(1) -- Wait for server to be ready
CurrencyController.RequestBalance()

return CurrencyController


