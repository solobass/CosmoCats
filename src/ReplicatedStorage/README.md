# ReplicatedStorage Structure

This folder contains all shared code, assets, and remotes that are accessible to both client and server.

## Structure

- **Modules/** - Shared module scripts (Species, Emotes, Currency, etc.)
- **Shared/** - Shared utilities, events, configs, and types
- **Remotes/** - RemoteEvents and RemoteFunctions for client-server communication
- **CosmoCatsModels/** - Species model storage (each species in its own folder)
- **CosmoCatsAnimations/** - Species-specific animation overrides (optional, falls back to SharedAnimations)
- **CosmoCatsAccessories/** - Accessory storage (separate MeshParts for character customization)
- **CosmoCatsEffects/** - Particle effects and visual effects (attached to HumanoidRootPart, TailTip, or Head)
- **Assets/** - Models, animations, sounds, and other assets
- **SharedAnimations/** - Common animations used across all species (default animation set)

