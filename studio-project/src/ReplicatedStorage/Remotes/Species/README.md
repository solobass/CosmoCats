# Species Remotes

RemoteEvents and RemoteFunctions for species system communication.

## RemoteEvents

- **RequestSetSpecies** - Client requests to set a species
- **ConfirmSpecies** - Server confirms species change to client

## RemoteFunctions

- **GetPlayerSpecies** - Client requests current player species

## Usage

These remotes are used by:
- `SpeciesServer.lua` - Server-side handler
- `SpeciesClient.client.lua` - Client-side UI


