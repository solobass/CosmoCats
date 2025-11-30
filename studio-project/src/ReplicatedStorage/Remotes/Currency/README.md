# Currency Remotes

RemoteEvents and RemoteFunctions for Stardust currency system.

## RemoteEvents

- **CurrencyUpdated** - Server broadcasts updated Stardust balance to client
- **RequestPurchaseUnlock** - Client requests to purchase an unlock (species, bed, pattern, effect)

## RemoteFunctions

- **GetStardustBalance** - Client requests current Stardust balance from server

## Usage

These remotes are used by:
- `CurrencyServer.lua` - Server-side handler
- `CurrencyController.lua` - Client-side controller
- `Stardust.client.lua` - UI update handler


