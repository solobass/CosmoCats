# Stardust Currency GUI

Always visible Stardust counter (top right corner).

## Structure

```
CurrencyGui/
   StardustGui (ScreenGui)
      └── Frame
           └── StardustLabel
   Scripts/
     └── Stardust.client.lua
```

## Wireframe

```
 ---------------------
| ★ Stardust: 312     |
 ---------------------
```

Star icon optional.

## Behavior

- **Auto-updates** via `CurrencyController.OnUpdated`
- **Initial load** → `CurrencyController.RequestBalance()`
- **Real-time updates** → Server broadcasts balance changes

## Integration

Uses `CurrencyController` module for balance management.

## Script

See `Scripts/Stardust.client.lua` for implementation.


