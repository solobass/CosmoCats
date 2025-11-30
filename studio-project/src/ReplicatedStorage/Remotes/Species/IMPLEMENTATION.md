# Species System Implementation

## ✅ Files Created

1. **SpeciesData.lua** - Complete species definitions
2. **SpeciesController.lua** - Shared validation logic
3. **SpeciesServer.lua** - Authoritative server logic
4. **SpeciesClient.client.lua** - Client-side UI handler

## 🔧 Setup Required in Roblox Studio

### 1. Create RemoteEvents and RemoteFunctions

In Roblox Studio, navigate to:
```
ReplicatedStorage → Remotes → Species
```

Create the following:

**RemoteEvents:**
- `RequestSetSpecies` (RemoteEvent)
- `ConfirmSpecies` (RemoteEvent)

**RemoteFunctions:**
- `GetPlayerSpecies` (RemoteFunction)

### 2. Create CosmoCatsModels Folder

In Roblox Studio, navigate to:
```
ReplicatedStorage
```

Create a folder named `CosmoCatsModels`

Inside it, create folders for each species:
- `GALAXY_KITTEN/`
- `COSMO_SHORTHAIR/`
- `LUNAR_LYNX/`

Each folder should contain:
- `Model` (Model) - The species model (.rbxm)

### 3. TODO Items

The code includes TODO comments for:
- SaveSystem integration (uncomment when SaveSystem is ready)
- CurrencyServer integration (uncomment when CurrencyServer is ready)
- UI button connections (connect when UI is created)

## 🎮 How It Works

1. **Player joins** → `SpeciesServer` loads their species from data
2. **Character spawns** → Default R15 body removed, Space Cat model cloned
3. **Player selects species** → Client sends request, server validates
4. **Server confirms** → Character respawns with new species

## 🔒 Security Features

- Server-side validation
- Unlock checking
- Premium species game pass verification
- Species existence validation

## 📝 Next Steps

1. Create RemoteEvents/RemoteFunctions in Studio
2. Import species models to `CosmoCatsModels/`
3. Connect UI buttons to `onSpeciesChosen()` function
4. Uncomment SaveSystem integration when ready
5. Uncomment CurrencyServer integration when ready


