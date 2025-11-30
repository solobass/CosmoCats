# Main Menu GUI

Entry point when players join. Leads them to species selection or character creator presets.

## Structure

```
MainMenuGui/
   MainMenuScreenGui (ScreenGui)
   └── Frame_MainMenu
         ├── TitleLabel
         ├── PlayButton
         ├── CharacterCreatorButton
         ├── ClansButton
         ├── SettingsButton
         └── VersionLabel
   Scripts/
     └── MainMenu.client.lua
```

## Wireframe

```
 -----------------------------------------------------
|                    COSMO CATS                      |
|               ★ Space Feline Adventure ★           |
|                                                     |
|                 [ PLAY ]                            |
|        [ CHARACTER CREATOR ]                        |
|                [ CLANS ]                             |
|               [ SETTINGS ]                           |
|                                                     |
|                              v1.0.0                 |
 -----------------------------------------------------
```

## Behavior

- **PlayButton** → Opens Species Selector GUI
- **CharacterCreatorButton** → Opens Character Creator GUI
- **ClansButton** → Opens Clan GUI
- **SettingsButton** → Opens Settings GUI

## Script

See `Scripts/MainMenu.client.lua` for implementation.


