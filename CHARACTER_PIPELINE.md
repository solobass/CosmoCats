# Cosmo Cats - Character Pipeline

Standardized character pipeline for all species (starter, unlockable, premium).

## 1. Pipeline Overview

Cosmo Cats uses a standardized character pipeline so all species work across:
- ✅ Shared animations
- ✅ Species swapping
- ✅ Character creator
- ✅ Pattern libraries
- ✅ Accessory libraries
- ✅ Effects & particles

### Benefits

This pipeline ensures:
- **EVERY Space Cat uses a compatible standardized rig**
- **Meshy outputs are processed the same way**
- **Cursor scripts can automatically spawn any species**
- **You can add new cats in 2 minutes** (see Section 13: Species Addition Workflow)
- **Scales to dozens of cats** (see Section 14: Pipeline Philosophy)

---

## 2. Required Model Format (Meshy Output)

You will generate every species using Meshy AI, following these rules:

### 2.1 Pose Requirement

**T-Pose**
- Arms positioned horizontally (straight out)
- Legs straight
- Spine straight
- Tail straight or slightly curved

✨ **If you generate quadruped poses, use "Standing Cat T-Pose (anthro)" to ensure humanoid animation compatibility.**

### 2.2 File Format Requirements (Meshy Export)

**Export settings for Meshy:**

- ✔ **Export file type:**
  - **FBX** (recommended)
  - Or **GLB** (Roblox supports both)

- ✔ **Embedded textures:**
  - **Yes** (Meshy toggles allow this)

- ✔ **Single mesh:**
  - **Yes**

- ✔ **Skeleton included:**
  - **Yes**

---

## 3. Rig Specification (Critical for Roblox)

Cosmo Cats uses a **Humanoid-compatible rig → R15 hierarchy**.

### 3.1 Required Bone Hierarchy

```
HumanoidRootPart
  ├── LowerTorso
  │     ├── LeftUpperLeg
  │     ├── RightUpperLeg
  │     └── UpperTorso
  │           ├── LeftUpperArm
  │           │     ├── LeftLowerArm
  │           │           └── LeftHand
  │           ├── RightUpperArm
  │           │     ├── RightLowerArm
  │           │           └── RightHand
  │           └── Head
  │
  ├── LeftFoot
  └── RightFoot
```

### 3.2 Optional Parts (Tails & Ears)

If present, they should follow this hierarchy:

**Head**
```
Head
  ├── LeftEar
  └── RightEar
```

**Tail**
```
LowerTorso
  └── TailBase
        ├── TailMid
        └── TailTip
```

### 3.3 Mesh Requirements

**Every species MUST be a single SkinnedMesh.**
- ❌ No separate body parts
- ❌ No accessories baked into the main mesh

### 3.4 Facial Rig

**Optional, but recommended:**
- Jaw bone
- Eye bones (optional)

**Note:** If Meshy does not generate them, it's fine — we use face textures instead.

### 3.5 Scale Requirements

All models must follow:
- **1 Roblox Stud ≈ 1 meter**
- **Adult cat height: ~2.8–3.3 studs**
- **Kitten variants: scale 0.6–0.75**
- **Premium species: may scale to 1.2–1.3**

**Scale is applied via:**
```lua
-- Get HumanoidDescription and set scale properties
local humanoidDescription = humanoid:GetAppliedDescription()
humanoidDescription.HeadScale = scale
humanoidDescription.DepthScale = scale
humanoidDescription.HeightScale = scale
humanoidDescription.ProportionScale = scale
humanoidDescription.WidthScale = scale
humanoid:ApplyDescription(humanoidDescription)
```

**Note:** This is implemented in `SpeciesServer.lua` in the `spawnAsSpecies()` function.

---

## 4. Processing Workflow

### Step 1: Generate in Meshy AI
- Use T-Pose (or "Standing Cat T-Pose (anthro)")
- Ensure single SkinnedMesh output
- **Export Settings:**
  - File type: FBX (recommended) or GLB
  - Embedded textures: Yes
  - Single mesh: Yes
  - Skeleton included: Yes
- Export the model

### Step 2: Import to Roblox Studio
- Import FBX or GLB model
- Verify R15 hierarchy
- Check Humanoid compatibility
- Convert to Model format (.rbxm)

### Step 3: Add to Game (Roblox Studio Import Convention)

**Upload all species as:**

```
ReplicatedStorage/
    CosmoCatsModels/
        GALAXY_KITTEN/
            Model.rbxm          (required - the rigged model)
            icon.png            (optional - for species selector GUI)
            thumbnail.png        (optional)
            metadata.json       (optional - for automated pipeline)
        COSMO_SHORTHAIR/
            Model.rbxm
            icon.png
            thumbnail.png
            metadata.json
        LUNAR_LYNX/
            Model.rbxm
            ...
```

**Folder Structure:**
- Each species gets its own folder named with the species ID (uppercase)
- Each folder contains:
  - **Model.rbxm** (required) - The rigged model
  - **icon.png** (optional) - Icon for species selector GUI
  - **thumbnail.png** (optional) - Thumbnail image
  - **metadata.json** (optional) - Metadata for automated pipeline
- All species folders are under `ReplicatedStorage/CosmoCatsModels/`

**Loading Species in Code:**
```lua
local model = ReplicatedStorage.CosmoCatsModels[speciesId].Model:Clone()
```

**Example:**
- Species ID: `GALAXY_KITTEN` → Folder: `ReplicatedStorage/CosmoCatsModels/GALAXY_KITTEN/`
- Model: `ReplicatedStorage.CosmoCatsModels.GALAXY_KITTEN.Model`
- Icon: `ReplicatedStorage.CosmoCatsModels.GALAXY_KITTEN.icon` (if exists)

### Step 4: Update Species Data
- Update `SpeciesData.lua` with new species
- Set `modelFolder` to match the folder name (e.g., "GALAXY_KITTEN")
- Cursor will use `modelFolder` to auto-spawn the right model

### Step 5: Test
- Verify animations work (Idle, Walk, Run)
- Test emote animations
- Verify character creator compatibility
- Verify scale is applied correctly

---

## 5. Species Data Configuration

When adding a new species, update `SpeciesData.lua`:

```lua
NEW_SPECIES = {
    id = "NEW_SPECIES",
    displayName = "New Species",
    category = "Starter" | "Unlockable" | "Premium",
    unlockCost = 0, -- Stardust cost
    gamePassId = nil, -- Robux gamepass if premium
    modelFolder = "NEW_SPECIES", -- Must match folder name in CosmoCatsModels/
    defaultScale = 1.0, -- Use scale guidelines below
    movementProfile = "Default",
    allowedEmotes = { "SIT", "LAY", "LOAF", "GROOM", "MEOW" },
    abilities = { "ZERO_G_HOVER" },
}
```

**Important:** The `modelFolder` must match the folder name in `ReplicatedStorage/CosmoCatsModels/`. Cursor will use `modelFolder` to auto-spawn the right model.

### Scale Guidelines for defaultScale:

- **Adult cats**: `1.0` (base scale, 2.8-3.3 studs height)
- **Kitten variants**: `0.6` to `0.75` (smaller scale)
- **Premium species**: `1.2` to `1.3` (larger, more impressive)
- **Custom sizes**: Adjust based on species design

**Note:** Scale is applied via `Humanoid:ApplyDescriptionScale()` in the spawning system.

---

## 6. Compatibility Checklist

Before adding a new species, verify:

- [ ] Model is in T-Pose
- [ ] Single SkinnedMesh (no separate parts)
- [ ] R15 hierarchy matches specification
- [ ] Humanoid exists and is configured
- [ ] Scale is correct (2.8-3.3 studs for adults, or appropriate for variant)
- [ ] Scale applied via `Humanoid:ApplyDescriptionScale()`
- [ ] Animations work (test Idle, Walk, Run)
- [ ] Emotes work (test Sit, Lay, Loaf)
- [ ] Character creator can apply patterns/colors
- [ ] Accessories can attach correctly
- [ ] Effects can attach correctly
- [ ] Species data added to SpeciesData.lua with correct `modelFolder` and `defaultScale`

**Note:** See Section 15 for detailed pre-import validation checklist for Meshy models.

---

## 7. Troubleshooting

### Issue: Animations don't play
- **Solution**: Verify R15 hierarchy matches exactly
- **Solution**: Check Humanoid is properly configured

### Issue: Model looks wrong
- **Solution**: Ensure T-Pose was used in Meshy
- **Solution**: Verify single SkinnedMesh (not separate parts)

### Issue: Accessories don't attach
- **Solution**: Check attachment points exist
- **Solution**: Verify model scale is correct

### Issue: Character creator doesn't work
- **Solution**: Ensure model has proper part structure
- **Solution**: Check pattern/color application points

---

## 8. Supported Species Data Format (Cursor Integration)

All species must be defined in `SpeciesData.lua` using this schema:

```lua
{
    id = "GALAXY_KITTEN",
    displayName = "Galaxy Kitten",
    category = "Starter",
    unlockCost = 0,
    gamePassId = nil,
    modelFolder = "GALAXY_KITTEN",
    defaultScale = 1.0,
    movementProfile = "Default",
    allowedEmotes = { "SIT", "LOAF", "GROOM" },
    abilities = { "ZERO_G_HOVER" }
}
```

**Key Fields:**
- `id` - Unique species identifier (uppercase, underscores)
- `displayName` - Display name for UI
- `category` - "Starter" | "Unlockable" | "Premium"
- `unlockCost` - Stardust cost (0 for starter/premium)
- `gamePassId` - Roblox game pass ID if premium (nil otherwise)
- `modelFolder` - **Must match folder name in CosmoCatsModels/** (Cursor uses this to auto-spawn)
- `defaultScale` - Scale multiplier (1.0 = normal, see scale guidelines)
- `movementProfile` - Movement configuration reference
- `allowedEmotes` - Array of emote IDs this species can use
- `abilities` - Array of special abilities

**Cursor Integration:**
Cursor will use `modelFolder` to automatically load and spawn the correct model:
```lua
local model = ReplicatedStorage.CosmoCatsModels[speciesData.modelFolder].Model:Clone()
```

---

## 9. Pattern & Texture Pipeline

Each cat species supports multiple patterns and primary/secondary/detail colors.

### 9.1 UV Layout

Meshy produces consistent UVs. Ensure the UV maps:

- **Do NOT overlap** - Each body part should have its own UV space
- **Use clear torso/limb separation** - Torso, arms, legs, head should be clearly separated
- **Support multiple mask layers** - Allow for pattern overlays and color masks

**UV Requirements:**
- Head: Separate UV island
- Torso: Separate UV island
- Limbs: Separate UV islands for arms and legs
- Tail: Separate UV island (if present)
- Ears: Separate UV islands (if present)

### 9.2 Pattern Library Format

Patterns are stored in `ReplicatedStorage/Modules/Character/PatternLibrary.lua`:

```lua
local Patterns = {
    STARFIELD = "rbxassetid://XXXXXXXX",
    NEBULA_SWIRL = "rbxassetid://XXXXXXXX",
    COMET_TABS = "rbxassetid://XXXXXXXX",
    -- Add more patterns as needed
}
```

**Pattern IDs:**
- Use uppercase with underscores (e.g., `STARFIELD`, `NEBULA_SWIRL`)
- Each pattern must have a valid Roblox asset ID
- Patterns can be applied to head, body, or both

**Cursor Pattern Application:**
Cursor will apply patterns using:

```lua
-- Simple texture application
head.TextureID = Patterns[patternId]
body.TextureID = Patterns[patternId]

-- Or use SurfaceAppearance for complex patterns with multiple layers
local surfaceAppearance = Instance.new("SurfaceAppearance")
surfaceAppearance.ColorMap = Patterns[patternId]
surfaceAppearance.NormalMap = normalMapId -- optional
surfaceAppearance.MetalnessMap = metalnessMapId -- optional
part:FindFirstChildOfClass("SurfaceAppearance"):Destroy()
surfaceAppearance.Parent = part
```

**Color Application:**
- Primary color: Base body color
- Secondary color: Accent/pattern color
- Detail color: Highlights/details

---

## 10. Animations Pipeline

All cats use the same animation set, stored at `ReplicatedStorage/SharedAnimations/`.

### 10.1 Shared Animations

All species use these shared animations by default:

```
ReplicatedStorage/SharedAnimations/
    Idle.anim
    Walk.anim
    Run.anim
    Sit.anim
    Lay.anim
    Loaf.anim
    Groom.anim
    TailFlick.anim
```

**Animation Usage:**
- All species can use these animations
- Animations are compatible with R15 rig hierarchy
- Animations work with the standardized character pipeline

### 10.2 Premium Species Animation Overrides

Premium species may have custom animation overrides stored at:

```
ReplicatedStorage/CosmoCatsAnimations/
    BLACK_HOLE_CAT/
        Idle.anim
        Float.anim
    [SPECIES_ID]/
        [AnimationName].anim
```

**Override System:**
- Species-specific animations override shared animations
- If an animation is missing for a species → fallback to shared animation
- Folder name must match species ID (e.g., `BLACK_HOLE_CAT`)

**Animation Loading Logic:**
```lua
-- Cursor animation loading pattern
local function getAnimation(animationName: string, speciesId: string?): Animation?
    local sharedAnimations = ReplicatedStorage:WaitForChild("SharedAnimations")
    local sharedAnim = sharedAnimations:FindFirstChild(animationName)
    
    -- Check for species-specific override
    if speciesId then
        local speciesAnimations = ReplicatedStorage:FindFirstChild("CosmoCatsAnimations")
        if speciesAnimations then
            local speciesFolder = speciesAnimations:FindFirstChild(speciesId)
            if speciesFolder then
                local overrideAnim = speciesFolder:FindFirstChild(animationName)
                if overrideAnim then
                    return overrideAnim
                end
            end
        end
    end
    
    -- Fallback to shared animation
    return sharedAnim
end
```

**Animation Naming:**
- Use PascalCase (e.g., `Idle.anim`, `Walk.anim`)
- Match the shared animation names for consistency
- Custom animations can have unique names (e.g., `Float.anim`)

---

## 11. Accessory Pipeline (Future-Proof)

Accessories are separate cosmetic items that can be attached to cat characters.

### 11.1 Accessory Requirements

Accessories must be:
- **Separate MeshParts** - Not part of the main character mesh
- **Unskinned** - Independent mesh parts (not skinned to bones)
- **Attached via WeldConstraints or Accessory attachment points** - Standard Roblox attachment system

### 11.2 Accessory Storage Format

Accessories are stored as:

```
ReplicatedStorage/CosmoCatsAccessories/
    STAR_COLLAR/
        MeshPart.rbxm
    EAR_CRYSTALS/
        MeshPart.rbxm
    [ACCESSORY_ID]/
        MeshPart.rbxm
```

**Folder Structure:**
- Each accessory gets its own folder named with the accessory ID (uppercase, underscores)
- Each folder contains a `MeshPart.rbxm` file
- All accessory folders are under `ReplicatedStorage/CosmoCatsAccessories/`

### 11.3 Accessory Attachment

**Cursor's CharacterCreator will weld them automatically:**

```lua
-- Cursor accessory attachment pattern
local function attachAccessory(character: Model, accessoryId: string)
    local accessoriesFolder = ReplicatedStorage:WaitForChild("CosmoCatsAccessories")
    local accessoryFolder = accessoriesFolder:FindFirstChild(accessoryId)
    if not accessoryFolder then
        warn("Accessory not found:", accessoryId)
        return
    end
    
    local meshPart = accessoryFolder:FindFirstChild("MeshPart"):Clone()
    
    -- Find attachment point on character (e.g., "Neck" for collars, "Head" for ear accessories)
    local attachmentPoint = character:FindFirstChild("Neck", true) -- or appropriate attachment
    if attachmentPoint then
        -- Use WeldConstraint or Attachment system
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = attachmentPoint.Parent
        weld.Part1 = meshPart
        weld.Parent = meshPart
        
        meshPart.Parent = character
    end
end
```

**Attachment Points:**
- Collars: Attach to `Neck` or `UpperTorso`
- Ear accessories: Attach to `Head` or specific ear attachments
- Tail accessories: Attach to `LowerTorso` or tail base
- Body accessories: Attach to `UpperTorso` or `LowerTorso`

### 11.4 Accessory Library Format

Accessories are defined in `ReplicatedStorage/Modules/Character/AccessoriesLibrary.lua`:

```lua
local Accessories = {
    STAR_COLLAR = {
        id = "STAR_COLLAR",
        displayName = "Star Collar",
        attachmentPoint = "Neck",
        category = "Common",
    },
    EAR_CRYSTALS = {
        id = "EAR_CRYSTALS",
        displayName = "Ear Crystals",
        attachmentPoint = "Head",
        category = "Rare",
    },
}
```

---

## 12. Effects / Particle Library

Effects are particle systems and visual effects that enhance character appearance.

### 12.1 Effects Storage Format

Effects are stored as:

```
ReplicatedStorage/CosmoCatsEffects/
    NebulaAura.rbxm
    StarTrail.rbxm
    QuantumGlitch.rbxm
    SolarFlare.rbxm
    [EFFECT_NAME].rbxm
```

**File Structure:**
- Each effect is a separate `.rbxm` file (Model containing particle effects)
- Effects are named in PascalCase (e.g., `NebulaAura.rbxm`)
- All effects are stored directly in `ReplicatedStorage/CosmoCatsEffects/`

### 12.2 Effect Attachment Points

Cursor attaches them automatically to different parts depending on effect type:

- **Aura effects** (e.g., `NebulaAura`, `SolarFlare`): Attach to `HumanoidRootPart`
- **Trail effects** (e.g., `StarTrail`): Attach to `TailTip` (or tail end)
- **Head effects** (e.g., `QuantumGlitch`): Attach to `Head`

**Effect Attachment Logic:**
```lua
-- Cursor effect attachment pattern
local function attachEffect(character: Model, effectId: string)
    local effectsFolder = ReplicatedStorage:WaitForChild("CosmoCatsEffects")
    local effectModel = effectsFolder:FindFirstChild(effectId)
    if not effectModel then
        warn("Effect not found:", effectId)
        return
    end
    
    local clonedEffect = effectModel:Clone()
    
    -- Determine attachment point based on effect type
    local attachmentPoint = nil
    if effectId:find("Aura") or effectId:find("Flare") then
        attachmentPoint = character:FindFirstChild("HumanoidRootPart")
    elseif effectId:find("Trail") then
        attachmentPoint = character:FindFirstChild("TailTip", true) or character:FindFirstChild("HumanoidRootPart")
    elseif effectId:find("Glitch") or effectId:find("Head") then
        attachmentPoint = character:FindFirstChild("Head")
    else
        -- Default to HumanoidRootPart
        attachmentPoint = character:FindFirstChild("HumanoidRootPart")
    end
    
    if attachmentPoint then
        clonedEffect.Parent = attachmentPoint
        -- Optionally use WeldConstraint or Attachment for precise positioning
    end
end
```

### 12.3 Effects Library Format

Effects are defined in `ReplicatedStorage/Modules/Character/EffectsLibrary.lua`:

```lua
local Effects = {
    NEBULA_AURA = {
        id = "NEBULA_AURA",
        displayName = "Nebula Aura",
        fileName = "NebulaAura",
        attachmentPoint = "HumanoidRootPart",
        category = "Rare",
    },
    STAR_TRAIL = {
        id = "STAR_TRAIL",
        displayName = "Star Trail",
        fileName = "StarTrail",
        attachmentPoint = "TailTip",
        category = "Epic",
    },
    QUANTUM_GLITCH = {
        id = "QUANTUM_GLITCH",
        displayName = "Quantum Glitch",
        fileName = "QuantumGlitch",
        attachmentPoint = "Head",
        category = "Legendary",
    },
}
```

**Effect Properties:**
- `id` - Unique effect identifier (uppercase, underscores)
- `displayName` - Display name for UI
- `fileName` - Name of the .rbxm file (PascalCase)
- `attachmentPoint` - Where to attach ("HumanoidRootPart", "TailTip", "Head")
- `category` - Rarity category

---

## 13. Species Addition Workflow (2 Minutes)

Quick workflow for adding new cat species to Cosmo Cats.

### Step-by-Step Process

**1. Generate T-Pose in ChatGPT**
- Use ChatGPT to generate a T-pose reference image or description
- Ensure T-Pose: arms horizontal, legs straight, spine straight, tail straight

**2. Create 3D Model in Meshy**
- Import T-pose reference into Meshy AI
- Generate 3D model following pipeline requirements:
  - T-Pose (or "Standing Cat T-Pose (anthro)")
  - Single SkinnedMesh
  - R15-compatible rig hierarchy
  - Proper UV layout (no overlaps, clear separation)

**3. Export FBX**
- Export settings:
  - File type: **FBX** (recommended) or GLB
  - Embedded textures: **Yes**
  - Single mesh: **Yes**
  - Skeleton included: **Yes**

**4. Import into Roblox Studio**
- Import FBX model into Roblox Studio
- Verify R15 hierarchy
- Check Humanoid compatibility
- Convert to Model format (.rbxm)

**5. Rename Folder to SPECIES_ID**
- Create folder with species ID (uppercase, underscores)
- Example: `AURORA_COON`, `NEBULA_PANTHER`, `SOLAR_TIGER`
- Place model as `Model.rbxm` inside the folder

**6. Place in CosmoCatsModels**
- Location: `ReplicatedStorage/CosmoCatsModels/[SPECIES_ID]/`
- Structure:
  ```
  ReplicatedStorage/CosmoCatsModels/
      AURORA_COON/
          Model.rbxm
  ```

**7. Add Entry to SpeciesData.lua**
- Open `ReplicatedStorage/Modules/Species/SpeciesData.lua`
- Add new species definition:
  ```lua
  AURORA_COON = {
      id = "AURORA_COON",
      displayName = "Aurora Coon",
      category = "Starter", -- or "Unlockable" | "Premium"
      unlockCost = 0, -- Stardust cost
      gamePassId = nil, -- Roblox game pass ID if premium
      modelFolder = "AURORA_COON", -- Must match folder name
      defaultScale = 1.0, -- Adjust based on size
      movementProfile = "Default",
      allowedEmotes = { "SIT", "LAY", "LOAF", "GROOM", "MEOW" },
      abilities = { "ZERO_G_HOVER" },
  },
  ```

**8. Run Species Selector GUI to Test**
- Test in-game species selector
- Verify model loads correctly
- Check animations work
- Test character creator compatibility

### Quick Checklist

- [ ] T-Pose model generated
- [ ] FBX exported with correct settings
- [ ] Model imported into Roblox Studio
- [ ] Folder created: `CosmoCatsModels/[SPECIES_ID]/`
- [ ] Model placed as `Model.rbxm`
- [ ] Entry added to `SpeciesData.lua`
- [ ] `modelFolder` matches folder name
- [ ] Tested in species selector GUI

**Total Time: ~2 minutes** (after initial setup)

---

## 14. Pipeline Philosophy

The Cosmo Cats character pipeline is designed around core principles that enable scaling to dozens of cats efficiently.

### Core Principles

**1. All Species Share the Same Animation Rig**
- Every cat uses the R15 Humanoid hierarchy
- All animations work across all species
- No species-specific animation requirements
- Shared animation set in `ReplicatedStorage/SharedAnimations/`
- Premium species can have overrides, but fallback to shared animations

**2. All Cosmetic Differences = Textures, Effects, Accessories**
- Visual variety comes from:
  - **Patterns** - Different texture patterns (stored in PatternLibrary)
  - **Colors** - Primary, secondary, and detail colors
  - **Effects** - Particle effects (auras, trails, glitches)
  - **Accessories** - Separate MeshParts (collars, crystals, etc.)
- No need for unique skeletons or rigs
- Cosmetic customization is data-driven, not model-driven

**3. Premium Cats Get Extra VFX, Not Extra Power**
- Premium species are visually distinct, not mechanically superior
- Extra visual effects (particles, animations, accessories)
- Same gameplay mechanics for all species
- Fairness and balance maintained across all tiers

**4. Avoid Dependencies on Unique Skeletons**
- No species-specific bone structures
- No custom animation requirements per species
- Standardized rig ensures compatibility
- Easy to add new species without breaking existing systems

### Why This Works

**Scalability:**
- Add new species in 2 minutes (see Section 13)
- No need to create custom animations per species
- Patterns, effects, and accessories are reusable
- Data-driven approach means less code, more content

**Maintainability:**
- Single animation set to maintain
- Shared systems work for all species
- Bugs affect all species equally (easier to fix)
- Consistent behavior across the game

**Performance:**
- Shared animations reduce memory usage
- Reusable assets (patterns, effects) reduce duplication
- Standardized rigs optimize rendering
- Efficient content pipeline

**Player Experience:**
- Consistent gameplay across all species
- Fair monetization (premium = visual, not power)
- Easy to understand and balance
- Smooth species switching

### This is How We Scale to Dozens of Cats

By following these principles:
- ✅ **10 cats** = Same effort as 1 cat (after initial setup)
- ✅ **50 cats** = Still manageable with shared systems
- ✅ **100+ cats** = Possible with automated pipeline tools

The pipeline philosophy ensures that adding more cats doesn't mean more complexity—it means more variety with the same underlying systems.

---

## 15. Checklist for Each Meshy Model

Before importing any Meshy model into Roblox Studio, verify all requirements are met.

### Pre-Import Validation Checklist

**☑ T-Pose**
- Arms positioned horizontally (straight out)
- Legs straight
- Spine straight
- Tail straight or slightly curved
- No bent joints or awkward poses

**☑ Single Skinned Mesh**
- Model is a single SkinnedMesh (not separate parts)
- No separate body parts or accessories
- All geometry is part of one mesh
- No unskinned geometry

**☑ R15 Bone Names Applied**
- Bone hierarchy matches R15 specification:
  - `HumanoidRootPart`
  - `LowerTorso`, `UpperTorso`
  - `LeftUpperLeg`, `RightUpperLeg`
  - `LeftUpperArm`, `RightUpperArm`
  - `LeftLowerArm`, `RightLowerArm`
  - `LeftHand`, `RightHand`
  - `Head`
  - `LeftFoot`, `RightFoot`
- Optional: `TailBase`, `TailMid`, `TailTip` for tail
- Optional: `LeftEar`, `RightEar` for ears

**☑ Scale Correct**
- Adult cat height: ~2.8–3.3 studs
- Kitten variants: scale 0.6–0.75
- Premium species: scale 1.2–1.3
- 1 Roblox Stud ≈ 1 meter

**☑ No Extra Objects**
- No hidden geometry
- No duplicate meshes
- No unnecessary parts
- No accessories baked into mesh
- Clean model structure

**☑ UV Maps Sane**
- UVs do NOT overlap
- Clear torso/limb separation
- Support multiple mask layers
- Head: Separate UV island
- Torso: Separate UV island
- Limbs: Separate UV islands
- Tail: Separate UV island (if present)
- Ears: Separate UV islands (if present)

**☑ No Broken Normals**
- All normals face outward
- No inverted faces
- Smooth shading works correctly
- No visual artifacts

**☑ Tail + Ears Present if Needed**
- Tail bones present if species has tail
- Ear bones present if species has ears
- Optional bones properly named
- Attachment points exist if needed

**☑ Exported as FBX**
- File type: **FBX** (recommended) or GLB
- Embedded textures: **Yes**
- Single mesh: **Yes**
- Skeleton included: **Yes**

### Import Decision

**If everything passes → import into Roblox Studio**

**If any item fails → fix in Meshy or modeling software before importing**

### Post-Import Checks

After importing, verify:
- [ ] Model appears correctly in Roblox Studio
- [ ] Humanoid exists and is configured
- [ ] R15 hierarchy is intact
- [ ] Animations can be loaded
- [ ] Scale looks correct
- [ ] Textures/UVs display properly

---

## 16. Cursor + Claude Integration

The Cosmo Cats pipeline leverages both Cursor and Claude Code Pro for different aspects of development and runtime operations.

### Cursor Responsibilities (Runtime Operations)

Cursor handles all runtime operations for spawning and customizing cat characters:

**1. Load Species Model from Folder**
```lua
-- Cursor loads species models automatically
local model = ReplicatedStorage.CosmoCatsModels[speciesData.modelFolder].Model:Clone()
```

**2. Weld Accessories**
- Load accessories from `CosmoCatsAccessories/[ACCESSORY_ID]/MeshPart.rbxm`
- Find attachment points on character
- Create WeldConstraints to attach accessories
- Parent accessories to character

**3. Apply Textures & Patterns**
- Load patterns from `PatternLibrary.lua`
- Apply textures to head and body parts
- Use `TextureID` or `SurfaceAppearance` for complex patterns
- Apply primary, secondary, and detail colors

**4. Attach Effects**
- Load effects from `CosmoCatsEffects/[EFFECT_NAME].rbxm`
- Determine attachment point based on effect type:
  - Aura effects → `HumanoidRootPart`
  - Trail effects → `TailTip`
  - Head effects → `Head`
- Clone and parent effects to character

**5. Handle R15-Compatible Animations**
- Load animations with fallback system:
  - Check species-specific: `CosmoCatsAnimations[speciesId][animationName]`
  - Fallback to shared: `SharedAnimations[animationName]`
- Load animations into Humanoid
- Play animations based on character state

**6. Spawn Cat Character on Server**
- Replace default R15 character with species model
- Apply scale via `Humanoid:ApplyDescription()`
- Apply appearance data (colors, patterns, accessories, effects)
- Set up animations
- Configure movement profile

### Claude Code Pro Responsibilities (Development & Maintenance)

Claude Code Pro handles development, maintenance, and documentation tasks:

**1. Maintain Documentation of Every Species**
- Update `CHARACTER_PIPELINE.md` with new species
- Document species properties and requirements
- Maintain species data schemas
- Update workflow documentation

**2. Refactor Large Modules**
- Break down complex systems into smaller modules
- Improve code organization and structure
- Optimize performance across modules
- Ensure consistent patterns

**3. Convert Meshy Bone Names to Standard**
- Map Meshy-generated bone names to R15 standard names
- Ensure compatibility with animation system
- Fix bone hierarchy issues
- Validate rig structure

**4. Validate Rig Errors**
- Check R15 hierarchy compliance
- Verify bone structure matches specification
- Validate attachment points exist
- Check for missing or misnamed bones
- Ensure Humanoid compatibility

**5. Rewrite Scripts Across Multiple Files if Needed**
- Refactor code across entire codebase
- Update multiple files for consistency
- Migrate to new patterns or APIs
- Fix breaking changes across systems
- Update all references when structure changes

### Workflow Integration

**Development Phase (Claude Code Pro):**
1. Claude creates/updates species documentation
2. Claude validates rig structure and bone names
3. Claude refactors modules as needed
4. Claude updates scripts across multiple files

**Runtime Phase (Cursor):**
1. Cursor loads species model from folder
2. Cursor applies all customization (accessories, patterns, effects)
3. Cursor handles animations with fallback system
4. Cursor spawns complete cat character

**Maintenance Phase (Claude Code Pro):**
1. Claude maintains documentation
2. Claude refactors for scalability
3. Claude fixes rig errors and bone name issues
4. Claude updates scripts when needed

### Benefits of This Division

- **Cursor**: Fast, focused runtime operations
- **Claude**: Comprehensive development and maintenance
- **Clear Responsibilities**: Each tool handles what it's best at
- **Scalability**: Easy to add new species without breaking existing systems
- **Maintainability**: Documentation and refactoring keep codebase healthy

---

## 17. File Locations

- **Species Models**: `ReplicatedStorage/CosmoCatsModels/[SPECIES_ID]/Model.rbxm`
  - Example: `ReplicatedStorage/CosmoCatsModels/GALAXY_KITTEN/Model.rbxm`
  - Optional: `icon.png`, `thumbnail.png`, `metadata.json` in same folder
- **Species Data**: `ReplicatedStorage/Modules/Species/SpeciesData.lua`
- **Species Config**: `ReplicatedStorage/Modules/Species/DefaultSpeciesConfig.lua`
- **Shared Animations**: `ReplicatedStorage/SharedAnimations/`
  - Default animations for all species: `Idle.anim`, `Walk.anim`, `Run.anim`, `Sit.anim`, `Lay.anim`, `Loaf.anim`, `Groom.anim`, `TailFlick.anim`
- **Species Animation Overrides**: `ReplicatedStorage/CosmoCatsAnimations/[SPECIES_ID]/`
  - Optional species-specific animations (fallback to shared if missing)
- **Accessories**: `ReplicatedStorage/CosmoCatsAccessories/[ACCESSORY_ID]/MeshPart.rbxm`
  - Example: `ReplicatedStorage/CosmoCatsAccessories/STAR_COLLAR/MeshPart.rbxm`
  - Separate MeshParts (unskinned) attached via WeldConstraints
- **Effects**: `ReplicatedStorage/CosmoCatsEffects/[EFFECT_NAME].rbxm`
  - Example: `ReplicatedStorage/CosmoCatsEffects/NebulaAura.rbxm`
  - Particle effects attached to HumanoidRootPart, TailTip, or Head

**Code Reference:**
```lua
-- Load species model
local model = ReplicatedStorage.CosmoCatsModels[speciesId].Model:Clone()

-- Load optional icon
local icon = ReplicatedStorage.CosmoCatsModels[speciesId]:FindFirstChild("icon")
```

---

## 18. Quick Reference

**Pose**: T-Pose (arms horizontal, legs straight)  
**Mesh**: Single SkinnedMesh  
**Rig**: R15 Humanoid hierarchy  
**Format**: FBX from Meshy AI  
**Scale**: 
  - Adult: 1.0 (2.8-3.3 studs height)
  - Kitten: 0.6-0.75
  - Premium: 1.2-1.3
**Scale Application**: `Humanoid:ApplyDescriptionScale()`  
**Processing**: Standardized pipeline  

---

**Last Updated**: Pipeline specification documented  
**Status**: Ready for species creation ✅

