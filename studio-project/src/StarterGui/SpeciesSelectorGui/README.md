# Species Selector GUI

Let the player choose which cat species to spawn as.

## Structure

```
SpeciesSelectorGui/
   SpeciesSelectorScreenGui (ScreenGui)
      └── Frame_SpeciesList
            ├── SpeciesButton_Template
            ├── ScrollList (ScrollingFrame with UIListLayout)
            ├── ConfirmButton
            └── CloseButton
   Scripts/
     └── SpeciesSelector.client.lua
```

## Wireframe

```
 -----------------------------------------------------
|                  SELECT YOUR SPECIES               |
| --------------------------------------------------- |
| [Galaxy Kitten]     [Cosmo Shorthair]               |
| [Lunar Lynx]         (locked - cost: 250 Stardust)   |
| [Nebula Panther]     (locked - cost: 500)            |
| [Solar Tiger]        (premium)                       |
|                                                         |
|                    [ CONFIRM ]                        |
|                     [ CLOSE ]                         |
 ---------------------------------------------------------
```

## Icons

Species icons come from:
```
ReplicatedStorage/CosmoCatsModels/SPECIES_ID/icon.png
```

## Behavior

- **Click species** → Highlight selected
- **If locked** → Show purchase popup (handled by Currency system)
- **ConfirmButton** → Calls `RequestSetSpecies:FireServer(selectedSpeciesId)`
- **CloseButton** → Closes GUI

## Script

See `Scripts/SpeciesSelector.client.lua` for implementation.


