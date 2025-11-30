-- PlayerLoader.client.lua
-- Entry point client script that bootstraps Cosmo Cats systems on the client.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local Modules = ReplicatedStorage:WaitForChild("Modules")

local SpeciesController = require(Modules.Species.SpeciesController)
local EmoteController = require(Modules.Emotes.EmoteController)
local CurrencyController = require(Modules.Currency.CurrencyController)
local ClanController = require(Modules.Clans.ClanController)
local BedController = require(Modules.Beds.BedController)
local GameConfig = require(Modules.Config.GameConfig)

-- Wait for Remotes to exist
local function waitForRemotes()
	local remotesFolder = ReplicatedStorage:WaitForChild("Remotes", 10)
	if not remotesFolder then
		warn("[PlayerLoader] Remotes folder not found - some features may not work")
		return nil
	end
	
	return {
		SpeciesRemotes = remotesFolder:FindFirstChild("SpeciesRemotes"),
		CurrencyRemotes = remotesFolder:FindFirstChild("CurrencyRemotes"),
		ClanRemotes = remotesFolder:FindFirstChild("ClanRemotes"),
		BedRemotes = remotesFolder:FindFirstChild("BedRemotes"),
	}
end

-- Connect RemoteEvents to local controllers
local function connectRemotes(remotes)
	if not remotes then
		return
	end
	
	-- Species updates
	if remotes.SpeciesRemotes then
		local speciesUpdated = remotes.SpeciesRemotes:FindFirstChild("SpeciesUpdated")
		if speciesUpdated then
			speciesUpdated.OnClientEvent:Connect(function(speciesId: string)
				print("[PlayerLoader] Species updated to:", speciesId)
				-- SpeciesController will handle this
			end)
		end
	end
	
	-- Currency updates
	if remotes.CurrencyRemotes then
		local stardustUpdated = remotes.CurrencyRemotes:FindFirstChild("StardustUpdated")
		if stardustUpdated then
			stardustUpdated.OnClientEvent:Connect(function(balance: number)
				CurrencyController.SetLocalBalance(balance)
				print("[PlayerLoader] Stardust updated:", CurrencyController.FormatStardust(balance))
			end)
		end
	end
	
	-- Clan updates
	if remotes.ClanRemotes then
		local clanUpdated = remotes.ClanRemotes:FindFirstChild("ClanUpdated")
		if clanUpdated then
			clanUpdated.OnClientEvent:Connect(function(clanData: table?)
				ClanController.SetMyClan(clanData)
				print("[PlayerLoader] Clan updated")
			end)
		end
	end
end

-- Initialize UI systems
local function initializeUI()
	-- Wait for UI to load
	task.wait(1)
	
	-- Find and show main menu if it exists
	local mainMenuGui = StarterGui:FindFirstChild("MainMenuGui")
	if mainMenuGui then
		local screenGui = mainMenuGui:FindFirstChild("MainMenuScreenGui")
		if screenGui then
			screenGui.Enabled = true
			print("[PlayerLoader] Main menu UI enabled")
		end
	end
	
	-- Find species selector
	local speciesSelectorGui = StarterGui:FindFirstChild("SpeciesSelectorGui")
	if speciesSelectorGui then
		local screenGui = speciesSelectorGui:FindFirstChild("SpeciesSelectorScreenGui")
		if screenGui then
			-- Don't enable by default - let game logic decide
			print("[PlayerLoader] Species selector UI found")
		end
	end
end

-- Main initialization
local function initialize()
	print("[Cosmo Cats] PlayerLoader initializing...")
	
	-- Wait for remotes
	local remotes = waitForRemotes()
	
	-- Connect remotes to controllers
	connectRemotes(remotes)
	
	-- Initialize UI after a delay
	task.spawn(function()
		task.wait(2) -- Wait for everything to load
		initializeUI()
	end)
	
	print("[Cosmo Cats] PlayerLoader initialized")
end

-- Start initialization
initialize()

-- Example: open the main menu GUI automatically after a short delay
-- local StarterGui = game:GetService("StarterGui")
-- TODO: show MainMenuScreenGui and hook buttons to spawn flow.

return {}

