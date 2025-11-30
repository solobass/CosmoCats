# Settings GUI

Optional but recommended settings menu for player preferences.

## Structure

```
SettingsGui/
   SettingsScreenGui (ScreenGui)
      ├── Frame_Settings
      │     ├── Toggle_Particles
      │     ├── Toggle_Nametags
      │     ├── Toggle_Music
      │     ├── Toggle_SoundEffects
      │     └── CloseButton
      └── Frame_About
            ├── VersionLabel
            └── CreditsLabel
   Scripts/
     └── Settings.client.lua
```

## Behavior

- **Toggles** → Stored locally (client-side only)
- **Visual preferences** → Applied client-side
- **CloseButton** → Closes GUI

## Settings

- **Particles** → Toggle particle effects
- **Nametags** → Toggle player nametags
- **Music** → Toggle background music
- **Sound Effects** → Toggle sound effects

## Script

See `Scripts/Settings.client.lua` for implementation.


