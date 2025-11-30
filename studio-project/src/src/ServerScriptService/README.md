# ServerScriptService Structure

Server-side scripts for Cosmo Cats game logic.

## Main Server Scripts

- **SpeciesServer.lua** - Handles server-side species logic: load/save, validation, character spawning
- **EmoteServer.lua** - Handles server-side emote validation and replication
- **CurrencyServer.lua** - Handles Stardust balances, time-based rewards, and purchase validation
- **ClanServer.lua** - Handles server-side clan management, validation, and data persistence
- **BedServer.lua** - Handles server-side bed interaction validation and rest system
- **DataServer.lua** - Handles server-side data management and persistence
- **VIPServer.lua** - Handles server-side VIP/Game Pass management and benefits

## Systems Folder

Core system modules:
- **DataStoreManager.server.lua** - Data persistence system
- **PlayerDataManager.server.lua** - Player data management
- **EconomyManager.server.lua** - Currency management
- **ShopManager.server.lua** - Shop and purchase handling

## Additional Scripts

- **Main.server.lua** - Main server entry point
- **MainScript.server.lua** - Legacy main script
- **BaseplateSetup.server.lua** - World setup
- **AvatarTest.server.lua** - Avatar testing

