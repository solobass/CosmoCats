# CosmoCatsEffects

Particle effects and visual effects storage for Cosmo Cats characters.

## Folder Structure

Effects are stored as separate Model files (.rbxm):

```
ReplicatedStorage/
    CosmoCatsEffects/
        NebulaAura.rbxm
        StarTrail.rbxm
        QuantumGlitch.rbxm
        SolarFlare.rbxm
        [EFFECT_NAME].rbxm
```

## Effect Format

- Each effect is a **Model** (.rbxm) containing particle systems
- Effects are named in **PascalCase** (e.g., `NebulaAura.rbxm`)
- Effects contain ParticleEmitters, Beams, or other visual effects

## Attachment Points

Cursor attaches effects automatically to different parts depending on type:

- **Aura effects** (e.g., `NebulaAura`, `SolarFlare`): Attach to `HumanoidRootPart`
- **Trail effects** (e.g., `StarTrail`): Attach to `TailTip` (or tail end)
- **Head effects** (e.g., `QuantumGlitch`): Attach to `Head`

## Loading Effects in Code

```lua
local effectsFolder = ReplicatedStorage:WaitForChild("CosmoCatsEffects")
local effectModel = effectsFolder:WaitForChild("NebulaAura"):Clone()

-- Attach to appropriate part based on effect type
effectModel.Parent = character:FindFirstChild("HumanoidRootPart")
```

## Effect Types

### Aura Effects
- Attach to `HumanoidRootPart`
- Examples: `NebulaAura`, `SolarFlare`, `CosmicGlow`
- Surround the character with particle effects

### Trail Effects
- Attach to `TailTip` or tail end
- Examples: `StarTrail`, `CometTrail`, `NebulaTrail`
- Follow the character's movement

### Head Effects
- Attach to `Head`
- Examples: `QuantumGlitch`, `StellarCrown`, `CosmicHalo`
- Visual effects around the head area

## Import Process

1. Create particle effect in Roblox Studio
2. Export or save as Model format (.rbxm)
3. Place in `CosmoCatsEffects/` folder
4. Name in PascalCase (e.g., `NebulaAura.rbxm`)
5. Update `EffectsLibrary.lua` with effect data

## Notes

- Effects are cosmetic particle systems
- They enhance character appearance and visual appeal
- Cursor's CharacterCreator handles automatic attachment
- Effects can be toggled on/off by players
- Multiple effects can be active simultaneously


