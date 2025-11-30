--[[
	CurrencyClient.client.lua
	Client-side currency display and updates.
	Connects CurrencyController to UI and RemoteEvents.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local CurrencyController = require(ReplicatedStorage.Modules.Currency.CurrencyController)

local CurrencyClient = {}

-- Get or create RemoteEvents
local function getRemotes()
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotesFolder then
		remotesFolder = Instance.new("Folder")
		remotesFolder.Name = "Remotes"
		remotesFolder.Parent = ReplicatedStorage
	end
	
	local currencyRemotes = remotesFolder:FindFirstChild("CurrencyRemotes")
	if not currencyRemotes then
		currencyRemotes = Instance.new("Folder")
		currencyRemotes.Name = "CurrencyRemotes"
		currencyRemotes.Parent = remotesFolder
	end
	
	local stardustUpdated = currencyRemotes:FindFirstChild("StardustUpdated")
	if not stardustUpdated then
		stardustUpdated = Instance.new("RemoteEvent")
		stardustUpdated.Name = "StardustUpdated"
		stardustUpdated.Parent = currencyRemotes
	end
	
	local getStardustBalance = currencyRemotes:FindFirstChild("GetStardustBalance")
	if not getStardustBalance then
		getStardustBalance = Instance.new("RemoteFunction")
		getStardustBalance.Name = "GetStardustBalance"
		getStardustBalance.Parent = currencyRemotes
	end
	
	return stardustUpdated, getStardustBalance
end

function CurrencyClient:Init()
	local stardustUpdated, getStardustBalance = getRemotes()
	
	-- Listen for Stardust updates from server
	stardustUpdated.OnClientEvent:Connect(function(newBalance: number)
		CurrencyController.SetLocalBalance(newBalance)
		-- TODO: Update UI with new balance
		print("[CurrencyClient] Stardust updated:", CurrencyController.FormatStardust(newBalance))
	end)
	
	-- Request initial balance
	task.spawn(function()
		local success, balance = pcall(function()
			return getStardustBalance:InvokeServer()
		end)
		
		if success and balance then
			CurrencyController.SetLocalBalance(balance)
			print("[CurrencyClient] Initial Stardust balance:", CurrencyController.FormatStardust(balance))
		end
	end)
	
	print("[CurrencyClient] Initialized")
end

CurrencyClient:Init()

