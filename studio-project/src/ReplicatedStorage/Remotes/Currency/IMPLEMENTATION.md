# Stardust Currency System Implementation

## ✅ Files Created/Updated

1. **UnlockablesConfig.lua** - Central registry of purchasable items
2. **CurrencyServer.lua** - Authoritative server logic
3. **CurrencyController.lua** - Client-side mirror
4. **Stardust.client.lua** - UI update handler
5. **GameConfig.lua** - Stardust earning configuration

## 🔧 Setup Required in Roblox Studio

### 1. Create RemoteEvents and RemoteFunctions

In Roblox Studio, navigate to:
```
ReplicatedStorage → Remotes → Currency
```

Create the following:

**RemoteEvents:**
- `CurrencyUpdated` (RemoteEvent) - Server broadcasts balance updates
- `RequestPurchaseUnlock` (RemoteEvent) - Client requests purchases

**RemoteFunctions:**
- `GetStardustBalance` (RemoteFunction) - Client requests balance

### 2. Create Stardust GUI

In Roblox Studio, navigate to:
```
StarterGui → CurrencyGui
```

Create:
- `StardustGui` (ScreenGui)
  - `StardustLabel` (TextLabel) - Displays "Stardust: X"

### 3. Update PlayerData Structure

Ensure PlayerData includes:
```lua
PlayerData = {
    Stardust = number,
    UnlockedSpecies = { [speciesId] = true },
    OwnedBeds = { "BLANKET", "BOX" },
    OwnedPatterns = { "STARFIELD" },
    OwnedEffects = { "NEBULA_AURA" },
}
```

## 🎮 How It Works

### Earning Stardust
1. Player moves (velocity > 0.5)
2. Every 90 seconds (configurable), server awards 5 Stardust
3. Server broadcasts update to client
4. UI updates automatically

### Purchasing Unlocks
1. Client calls `CurrencyController.RequestPurchase(unlockId)`
2. Server validates cost and ownership
3. Server deducts Stardust
4. Server saves unlock to PlayerData
5. Server broadcasts updated balance
6. Client UI updates

## 🔒 Anti-Cheat Features

- ✅ Purchases only applied on server
- ✅ Timed rewards tied to Humanoid movement (anti-AFK)
- ✅ Cost validation and ownership checks
- ✅ Server is authoritative over balance
- ✅ No client-side modification allowed

## 📝 Integration Points

### Species Unlocks
- Handled by `UnlockablesConfig` → `CurrencyServer` → `SaveSystem`
- SpeciesServer checks `UnlockedSpecies` when validating species access

### Beds/Patterns/Effects
- Follow same unlock flow
- CharacterCreator reads from `OwnedPatterns` and `OwnedEffects`

### UI Shop
- Calls `CurrencyController.RequestPurchase(unlockId)`
- Server handles validation and purchase

## 🔄 End-to-End Flow Example

1. **Player walks** → earns Stardust
   - `CurrencyServer.AddStardust(player, 5)`
   - Client UI updates via `CurrencyUpdated`

2. **Player buys Lunar Lynx**
   - UI calls `RequestPurchaseUnlock("LUNAR_LYNX")`
   - Server checks cost (250 Stardust)
   - Server deducts Stardust
   - Server saves `UnlockedSpecies["LUNAR_LYNX"] = true`
   - Player can now play as Lunar Lynx

## ⚠️ TODO Items

The code includes TODO comments for:
- SaveSystem integration (uncomment when SaveSystem is ready)
- Advanced anti-cheat (rate limits, movement validation)
- VIP bonuses (multiplier for Stardust earnings)

## 🚀 Next Steps

1. Create RemoteEvents/RemoteFunctions in Studio
2. Create Stardust GUI in StarterGui
3. Uncomment SaveSystem integration when ready
4. Connect shop UI buttons to `CurrencyController.RequestPurchase()`
5. Test timed rewards and purchases


