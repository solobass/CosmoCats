# StarterPlayer Structure

Client-side scripts that run for each player.

## Structure

### StarterPlayerScripts/
Client scripts that run when a player joins:
- **PlayerLoader.client.lua** - Main entry point, bootstraps all client systems
- **SpeciesClient.client.lua** - Client-side species management and UI
- **EmoteClient.client.lua** - Client-side emote handling and input
- **CharacterCreatorClient.client.lua** - Client-side character creator UI
- **ClanClient.client.lua** - Client-side clan UI and interactions
- **CurrencyClient.client.lua** - Client-side currency display and updates
- **BedClient.client.lua** - Client-side bed interaction and UI

### StarterCharacterScripts/
Scripts that run on the character model:
- **AnimationController.lua** - Character animation management and playback
  - Purpose: Manages character animations (idle, walk, run, emotes)
  - Status: Scaffolded, ready for implementation
  
- **ZeroGravityController.lua** - Zero gravity movement and physics for space environment
  - Purpose: Handles zero-gravity movement mechanics for space gameplay
  - Status: Scaffolded, ready for implementation

### StarterCharacter/
Character-specific scripts:
- **Animate.lua** - Character animation script
- **CosmoKitten.model.lua** - Avatar model script

