# ServerStorage Structure

Server-only storage for data stores, configurations, and backend modules.

## Structure

### DataStores/
Data store configuration modules:
- **PlayerDataStore.lua** - Player data store configuration and helpers
- **ClanDataStore.lua** - Clan data store configuration

### InternalConfigs/
Internal server configuration (not exposed to clients):
- **ServerConfig.lua** - Internal server configuration

### BackendModules/
Backend system modules:
- **SaveSystem.lua** - Backend save system for data persistence
- **AutoBackup.lua** - Automatic data backup system

## Notes

- These modules are server-only (not replicated to clients)
- DataStore modules define configuration, actual logic is in ServerScriptService/Systems
- InternalConfigs contain sensitive server settings
- BackendModules handle background processes

