# CurrencyGui

Stardust currency display UI.

## UI Structure (Create in Roblox Studio)

**StardustGui** (ScreenGui)
- **CurrencyFrame** (Frame) - Main container
  - **StardustIcon** (ImageLabel) - Stardust icon
  - **StardustAmount** (TextLabel) - Current Stardust balance
  - **EarningIndicator** (Frame) - Shows when earning Stardust
    - **EarningText** (TextLabel) - "+X Stardust" animation

## Scripts

- **Scripts/Stardust.client.lua** - Stardust display controller

## Notes

- Create ScreenGui in Roblox Studio
- Add UI elements as documented above
- Connect to CurrencyController for balance updates
- Update display when StardustUpdated RemoteEvent fires

