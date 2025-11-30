-- CurrencyServer.lua
-- Authoritative server-side management of Stardust currency.
-- Handles earning, saving, spending, and broadcasting updated balances.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local GameConfig = require(Modules:WaitForChild("Config"):WaitForChild("GameConfig"))
local UnlockablesConfig = require(Modules:WaitForChild("Config"):WaitForChild("UnlockablesConfig"))

local SaveSystem = require(ServerStorage:WaitForChild("BackendModules"):WaitForChild("SaveSystem"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Currency")
local CurrencyUpdated = Remotes:WaitForChild("CurrencyUpdated")
local RequestPurchaseUnlock = Remotes:WaitForChild("RequestPurchaseUnlock")
local GetStardustBalance = Remotes:WaitForChild("GetStardustBalance")

local CurrencyServer = {}

-- Internal cache
local playerStardust = {}
local stardustLoops = {} -- Track running loops for cleanup

----------------------------------------
-- INITIALIZATION
----------------------------------------

local function loadPlayerStardust(player)
    local data = SaveSystem.LoadPlayerData(player)
    local amount = data.Stardust or 0
    playerStardust[player] = amount
    
    -- Send to client
    task.defer(function()
        CurrencyUpdated:FireClient(player, playerStardust[player])
    end)
end

local function savePlayerStardust(player)
    local data = SaveSystem.LoadPlayerData(player)
    data.Stardust = playerStardust[player] or 0
    SaveSystem.SavePlayerData(player, data)
end

----------------------------------------
-- CORE API
----------------------------------------

function CurrencyServer.GetBalance(player)
    return playerStardust[player] or 0
end

function CurrencyServer.AddStardust(player, amount)
    if amount <= 0 then 
        warn("[CurrencyServer] Invalid amount:", amount)
        return 
    end
    
    local newAmount = CurrencyServer.GetBalance(player) + amount
    playerStardust[player] = newAmount
    
    -- Broadcast to client
    CurrencyUpdated:FireClient(player, newAmount)
    
    -- Save to DataStore
    savePlayerStardust(player)
end

function CurrencyServer.TryPurchase(player, unlockId)
    local unlockData = UnlockablesConfig.Get(unlockId)
    if not unlockData then
        warn("[CurrencyServer] Invalid unlock ID:", unlockId)
        return false
    end

    local data = SaveSystem.LoadPlayerData(player)

    -- Check if already owned
    local saveField = unlockData.saveField
    if data[saveField] and data[saveField][unlockId] then
        warn("[CurrencyServer] Player already owns unlock:", unlockId, player.Name)
        return false
    end

    local cost = unlockData.cost
    local current = CurrencyServer.GetBalance(player)

    if current < cost then
        warn("[CurrencyServer] Insufficient Stardust:", current, "<", cost, player.Name)
        return false
    end

    -- Deduct Stardust
    current = current - cost
    playerStardust[player] = current
    CurrencyUpdated:FireClient(player, current)

    -- Save unlock
    data[saveField] = data[saveField] or {}
    data[saveField][unlockId] = true
    
    -- Save all data (includes Stardust and unlocks)
    SaveSystem.SavePlayerData(player, data)

    print("[Cosmo Cats] Purchase success:", unlockId, "for", player.Name)
    return true
end

----------------------------------------
-- TIMED REWARD LOOP
----------------------------------------

local function beginTimedRewards(player)
    -- Stop existing loop if player rejoined
    if stardustLoops[player] then
        stardustLoops[player] = false -- Signal to stop
        stardustLoops[player] = nil
    end
    
    -- Create a flag to track if loop should continue
    local shouldContinue = true
    stardustLoops[player] = shouldContinue
    
    task.spawn(function()
        while player.Parent and shouldContinue do
            task.wait(GameConfig.StardustIntervalSeconds or 90)
            
            -- Check if we should continue (player might have left)
            if not stardustLoops[player] then
                break
            end
            
            -- Anti-AFK detection (simple version)
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local hrp = character.HumanoidRootPart
                if hrp.Velocity.Magnitude > 0.5 then
                    CurrencyServer.AddStardust(player, GameConfig.StardustPerInterval or 5)
                end
            end
        end
        
        -- Clean up
        if stardustLoops[player] == shouldContinue then
            stardustLoops[player] = nil
        end
    end)
end

----------------------------------------
-- REMOTES
----------------------------------------

RequestPurchaseUnlock.OnServerEvent:Connect(function(player, unlockId)
    local success = CurrencyServer.TryPurchase(player, unlockId)
    if not success then
        warn("[CurrencyServer] Purchase failed:", unlockId, player.Name)
    end
end)

GetStardustBalance.OnServerInvoke = function(_, player)
    return CurrencyServer.GetBalance(player)
end

----------------------------------------
-- PLAYER HANDLERS
----------------------------------------

Players.PlayerAdded:Connect(function(player)
    loadPlayerStardust(player)
    beginTimedRewards(player)
end)

Players.PlayerRemoving:Connect(function(player)
    -- Stop the stardust loop
    if stardustLoops[player] then
        stardustLoops[player] = false
        stardustLoops[player] = nil
    end
    
    savePlayerStardust(player)
    playerStardust[player] = nil
end)

----------------------------------------

return CurrencyServer

