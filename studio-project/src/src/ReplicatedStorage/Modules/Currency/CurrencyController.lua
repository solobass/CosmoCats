-- CurrencyController.lua
-- Shared interface for Stardust currency (client + server usage).

local CurrencyController = {}

--[[
    Currency: "Stardust"

    Server responsibilities:
        - Track Stardust balances in DataStore
        - Award Stardust over time
        - Validate purchases / unlocks

    Client responsibilities:
        - Display Stardust balance in UI
        - Request purchases (server validates)

    Expected RemoteEvents / RemoteFunctions:
        - RemoteEvent: StardustUpdated (server -> client)
        - RemoteFunction: GetStardustBalance (client -> server)
        - RemoteEvent: RequestPurchaseUnlock (client -> server)
]]

-- Client-only storage (mirrors server state)
local localBalance = 0

function CurrencyController.SetLocalBalance(amount: number)
    localBalance = amount
end

function CurrencyController.GetLocalBalance(): number
    return localBalance
end

-- Format Stardust amount for GUI display
function CurrencyController.FormatStardust(amount: number): string
    if amount >= 1000000 then
        return string.format("%.1fM", amount / 1000000)
    elseif amount >= 1000 then
        return string.format("%.1fK", amount / 1000)
    else
        return tostring(amount)
    end
end

-- TODO: On client, hook RemoteEvent "StardustUpdated" to call SetLocalBalance.
-- TODO: Provide helper to format Stardust amounts for GUI.

return CurrencyController

