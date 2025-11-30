# CharacterCreatorGui

Character customization UI for editing cat appearance.

## UI Structure (Create in Roblox Studio)

**CharacterCreatorScreenGui** (ScreenGui)
- **CreatorFrame** (Frame) - Main container
  - **PreviewFrame** (ViewportFrame) - 3D character preview
  - **CustomizationPanel** (Frame) - Customization options
    - **ColorPicker** (Frame) - Color selection
    - **PatternSelector** (ScrollingFrame) - Pattern selection
    - **AccessorySelector** (ScrollingFrame) - Accessory selection
    - **EffectSelector** (ScrollingFrame) - Effect selection
  - **SaveButton** (TextButton) - Save appearance
  - **CloseButton** (TextButton) - Close creator

## Scripts

- **Scripts/CharacterCreator.client.lua** - Character creator controller

## Notes

- Create ScreenGui in Roblox Studio
- Add UI elements as documented above
- Connect to CharacterCreator module


