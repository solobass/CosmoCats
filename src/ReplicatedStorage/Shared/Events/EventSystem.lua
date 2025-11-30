--[[
	EventSystem.lua
	Centralized event system for decoupled communication between systems.
	Provides type-safe events and easy debugging.
]]

local EventSystem = {}
EventSystem.__index = EventSystem

-- Create a new event
function EventSystem.new(name: string)
	local self = setmetatable({}, EventSystem)
	
	self.Name = name
	self._connections = {}
	self._connectionCount = 0
	
	return self
end

-- Connect a callback to this event
function EventSystem:Connect(callback: (any) -> ())
	local connection = {
		Callback = callback,
		Disconnect = function()
			-- Remove from connections
			for i, conn in ipairs(self._connections) do
				if conn == connection then
					table.remove(self._connections, i)
					self._connectionCount = self._connectionCount - 1
					break
				end
			end
		end
	}
	
	table.insert(self._connections, connection)
	self._connectionCount = self._connectionCount + 1
	
	return connection
end

-- Fire the event to all connected callbacks
function EventSystem:Fire(...)
	for _, connection in ipairs(self._connections) do
		task.spawn(function()
			connection.Callback(...)
		end)
	end
end

-- Wait for the event to fire once
function EventSystem:Wait()
	local thread = coroutine.running()
	local connection
	
	connection = self:Connect(function(...)
		connection:Disconnect()
		task.spawn(thread, ...)
	end)
	
	return coroutine.yield()
end

-- Get the number of connections
function EventSystem:GetConnectionsCount()
	return self._connectionCount
end

-- Disconnect all connections
function EventSystem:DisconnectAll()
	self._connections = {}
	self._connectionCount = 0
end

return EventSystem


