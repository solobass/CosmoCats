# EmoteBarGui

Emote selection bar UI for playing emotes.

## UI Structure (Create in Roblox Studio)

**EmoteBarScreenGui** (ScreenGui)
- **EmoteBarFrame** (Frame) - Main container
  - **EmoteGrid** (ScrollingFrame) - Grid of emote buttons
    - **EmoteButtonTemplate** (TextButton) - Template for each emote
      - **EmoteIcon** (ImageLabel) - Emote icon/image
      - **EmoteName** (TextLabel) - Emote name
  - **ToggleButton** (TextButton) - Toggle emote bar visibility

## Scripts

- **Scripts/EmoteBar.client.lua** - Emote bar controller

## Notes

- Create ScreenGui in Roblox Studio
- Add UI elements as documented above
- Connect to EmoteController for emote playback


