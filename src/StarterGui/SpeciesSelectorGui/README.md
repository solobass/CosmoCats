# SpeciesSelectorGui

Species selection UI for choosing cat species.

## UI Structure (Create in Roblox Studio)

**SpeciesSelectorScreenGui** (ScreenGui)
- **SelectorFrame** (Frame) - Main container
  - **Title** (TextLabel) - "Select Your Species"
  - **SpeciesGrid** (ScrollingFrame) - Grid of species cards
    - **SpeciesCardTemplate** (Frame) - Template for each species
      - **SpeciesImage** (ImageLabel) - Species preview
      - **SpeciesName** (TextLabel) - Species name
      - **SelectButton** (TextButton) - Select this species
  - **CloseButton** (TextButton) - Close selector

## Scripts

- **Scripts/SpeciesSelector.client.lua** - Species selector controller

## Notes

- Create ScreenGui in Roblox Studio
- Add UI elements as documented above
- Connect to SpeciesController for species data


