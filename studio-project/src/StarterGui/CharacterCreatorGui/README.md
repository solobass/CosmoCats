# Character Creator GUI

Apply colors, patterns, effects, and cosmetics.

## Structure

```
CharacterCreatorGui/
   CharacterCreatorScreenGui (ScreenGui)
      ├── TabBar
      │     ├── Tab_Colors
      │     ├── Tab_Patterns
      │     ├── Tab_Accessories
      │     ├── Tab_Effects
      │     └── Tab_Info
      └── ContentFrame
           ├── Frame_Colors
           ├── Frame_Patterns
           ├── Frame_Accessories
           ├── Frame_Effects
           ├── Frame_Info
           └── PreviewViewportFrame
   Scripts/
     └── CharacterCreator.client.lua
```

## Wireframe

```
 ---------------------------------------------------------
|   COLORS | PATTERNS | ACCESSORIES | EFFECTS | INFO     |
| ------------------------------------------------------- |
|   • Primary Color Picker                                 |
|   • Secondary Color Picker                               |
|   • Detail Color Picker                                  |
|                                                         |
|                         [ 3D PREVIEW ]                   |
|                                                         |
|                 [ APPLY ]   [ CLOSE ]                    |
 -----------------------------------------------------------
```

## Behavior

- **Tabs** → Toggle visibility of content frames
- **Color Pickers** → Update preview model in real-time
- **Pattern Selection** → Show available patterns (check ownership)
- **Accessories** → Show owned accessories
- **Effects** → Show owned effects
- **PreviewViewportFrame** → 3D model preview
- **ApplyButton** → Fires `AppearanceUpdated:FireServer(appearanceData)`
- **CloseButton** → Closes GUI

## Integration

Uses `CharacterCreator.ApplyAppearance(previewModel, tempData)` for preview.

## Script

See `Scripts/CharacterCreator.client.lua` for implementation.


