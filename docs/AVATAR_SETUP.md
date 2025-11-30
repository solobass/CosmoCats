# Avatar Model Setup Guide 🐱

This guide explains how to add your 11 character models (FBX files) to the CosmoCat game.

## 📁 Where to Put Your FBX Files

### Source Files (For Organization)
Store your original FBX files in:
```
assets/avatars/
```

You can organize them like this:
```
assets/avatars/
├── CosmoKitten.fbx
├── StellarWhisker.fbx
├── NebulaPaws.fbx
├── GalaxyTail.fbx
├── CosmicWhisker.fbx
├── AstroClaws.fbx
├── VoidHunter.fbx
├── StarChaser.fbx
├── LunarShadow.fbx
├── CosmoMaster.fbx
└── CelestialGuardian.fbx
```

**Note:** These are just for organization. FBX files must be manually imported into Roblox Studio.

## 🎮 Manual Import Process (Required)

Since Rojo doesn't sync FBX files, you must import them manually into Roblox Studio:

### Step 1: Import FBX into Roblox Studio

**Important:** Import the **main `.fbx` file** (the one that contains/holds the other files). If your Meshy AI export has:
- A main `.fbx` file (e.g., `CharacterName_texture.fbx`)
- Texture files (`.png` files for diffuse, normal, metallic, roughness)
- A `.fbm` folder (with additional textures)

**You only need to import the main `.fbx` file** - Roblox Studio will automatically handle embedded textures.

1. **Open Roblox Studio** with your `CosmoCat.rbxl` file
2. **Connect to Rojo** (if not already connected)
3. **In the Explorer window**, navigate to `ReplicatedStorage` and select it (click on it)
4. **Click the "Import 3D Model" icon** in the toolbar at the top
   - This is the easiest method! Look for the 3D model import icon in the toolbar
   - **Alternative:** You can also use **File** → **Import** from the top menu
   - **Note:** The right-click menu shows "Insert Part", "Insert Object", "Import Roblox Model" - but for FBX files, use the **Import 3D Model** toolbar button or **File → Import**
5. **Select the main FBX file** (e.g., `CosmoKitten.fbx` or `CosmoKitten_texture.fbx`)
   - This is the file that contains the mesh and references the textures
   - You do NOT need to import the individual texture files separately
6. **Choose import settings** (you can usually keep the defaults)
   - **If you see a warning about polygon count > 20,000**: This is just a warning, not an error
   - You can still import the model - it will work fine
   - Roblox recommends < 20,000 triangles for optimal performance, but higher counts are allowed
   - For character models, slightly higher counts are usually acceptable
7. **After import**, the model will appear in your workspace
   - **Drag the imported model** into `ReplicatedStorage` if it didn't go there automatically
   - The model should now be in `ReplicatedStorage` with textures applied

### Step 2: Configure the Model

After importing, you need to ensure each model has the required components:

1. **Rename the Model** to match the expected name:
   - `CosmoKitten` (Level 1)
   - `StellarWhisker` (Level 2)
   - `NebulaPaws` (Level 3)
   - `GalaxyTail` (Level 4)
   - `CosmicWhisker` (Level 5)
   - `AstroClaws` (Level 6)
   - `VoidHunter` (Level 7)
   - `StarChaser` (Level 8)
   - `LunarShadow` (Level 9)
   - `CosmoMaster` (Level 10)
   - `CelestialGuardian` (Level 11)
   - `BlackHoleCat` (Level 12)

2. **Add Humanoid** (if not already present):
   - Right-click the Model → **Insert Object** → **Humanoid**
   - Set properties:
     - `DisplayName`: Will be set automatically by the game
     - `WalkSpeed`: 16 (default, can be customized)
     - `JumpPower`: 50 (default, can be customized)
     - `MaxHealth`: 100
     - `Health`: 100

3. **Add HumanoidRootPart** (if not already present):
   
   **Option A: Rename an existing part (Recommended)**
   - The FBX import should have created parts (MeshParts or Parts)
   - In Explorer, expand your Model to see its children
   - Look for the main body/torso part (usually the largest or most central part)
   - Right-click that part → **Rename**
   - Change the name to exactly: `HumanoidRootPart` (case-sensitive!)
   - This part will serve as the character's root for movement
   
   **Option B: Create a new Part (if no parts exist)**
   - Right-click the Model in Explorer → **Insert Object** → **Part**
   - The new Part will appear in the Model
   - Right-click the new Part → **Rename** → Change to: `HumanoidRootPart`
   - **Important:** Make sure the Part's Parent is the Model, NOT the Humanoid
     - If it's under Humanoid, drag it out to be directly under the Model
     - Correct structure: `Model → HumanoidRootPart` (not `Model → Humanoid → HumanoidRootPart`)
   - In Properties panel, set:
     - `Size`: `2, 2, 1` (or adjust to match your character size)
     - `Anchored`: `false` (important for movement!)
     - `CanCollide`: `true`
     - `Position`: `0, 0, 0` (or center it within your character)
   - **Note:** If you create a new Part, you may want to make it invisible:
     - Set `Transparency` to `1` (fully transparent)
     - Or set `Size` to be very small and position it at the character's center

4. **Set PrimaryPart**:
   - Select the Model in Explorer (click on the Model itself, not its children)
   - In the Properties panel (usually on the right side)
   - Find the `PrimaryPart` property
   - Click the dropdown or field next to `PrimaryPart`
   - Select `HumanoidRootPart` from the list
   - **Alternative method:** Right-click the Model → **Set Primary Part** → Select `HumanoidRootPart`

### Step 3: Verify Model Location

Each model should be directly in `ReplicatedStorage`:
```
ReplicatedStorage/
├── CosmoKitten (Model)
├── StellarWhisker (Model)
├── NebulaPaws (Model)
├── GalaxyTail (Model)
├── CosmicWhisker (Model)
├── AstroClaws (Model)
├── VoidHunter (Model)
├── StarChaser (Model)
├── LunarShadow (Model)
├── CosmoMaster (Model)
├── CelestialGuardian (Model)
└── Shared (Folder)
    ├── GameConfig (ModuleScript)
    └── CatAvatarManager (ModuleScript)
```

## ✅ Verification Checklist

After importing each model, verify:

- [ ] Model is in `ReplicatedStorage` with correct name
- [ ] Model has a `Humanoid` child
- [ ] Model has a `HumanoidRootPart` child
- [ ] `HumanoidRootPart` is set as the Model's `PrimaryPart`
- [ ] **`HumanoidRootPart.Anchored = false`** (CRITICAL - if true, character will fall!)
- [ ] Model's mesh/textures are visible (check in Studio)
- [ ] Model is properly scaled (not too large/small)

## 🧪 Testing

1. **Start the game** in Studio (Play button)
2. **Check the console** for messages like:
   - `"Found CosmoKitten model in ReplicatedStorage, using it directly"`
   - `"CosmoKitten model has all required components - using directly"`
3. **Collect CatTreats** to level up and test avatar switching
4. **Verify** that the correct model appears at each level

## 🐛 Troubleshooting

### Model Not Appearing
- **Check console** for error messages
- **Verify model name** matches exactly (case-sensitive)
- **Check model location** is in `ReplicatedStorage`, not a subfolder
- **Verify Humanoid and HumanoidRootPart** exist

### Character Falling Through the World
**Common causes and fixes:**

**Issue 1: HumanoidRootPart is anchored**
1. **Select `HumanoidRootPart`** in Explorer
2. **In Properties panel**, find `Anchored`
3. **Make sure `Anchored = false`** (unchecked)
   - If it's `true`, the character can't move and will fall

**Issue 2: Mesh parts not connected to HumanoidRootPart**
If your FBX imported a large mesh part (like `input` MeshPart) that's far from HumanoidRootPart:
1. **Select the large mesh part** (e.g., `input` MeshPart)
2. **Check its position** - if it's far from (0, 0, 0), you need to:
   - **Option A:** Move it to be centered on HumanoidRootPart
     - Select the mesh part
     - In Properties, set `Position` to match HumanoidRootPart (or close to it)
   - **Option B:** Weld it to HumanoidRootPart
     - Select both parts
     - Right-click → **Group** (creates a WeldConstraint automatically)
   - **Option C:** Make mesh parts non-colliding
     - Select all mesh parts (not HumanoidRootPart)
     - Set `CanCollide = false` for all mesh parts
     - Only `HumanoidRootPart` should have `CanCollide = true`

**Issue 3: All parts are anchored**
- Select all parts in the Model
- In Properties, set `Anchored = false` for all of them
- Keep `HumanoidRootPart.Anchored = false` especially

**Also verify:**
- `HumanoidRootPart.CanCollide = true` (should be checked)
- `PrimaryPart` is set to `HumanoidRootPart` on the Model
- `Humanoid` exists and is properly configured

### Fallback Character Appearing
If you see the orange fallback character instead of your model:
- Model is missing or incorrectly named
- Model is missing `Humanoid` or `HumanoidRootPart`
- Check console for specific error messages

### Model Too Large/Small
- Adjust the scale in the FBX file before importing
- Or scale the parts after import in Studio

### Polygon Count Warning (> 20,000 triangles)
- **This is just a warning, not an error** - you can still import the model
- The model will work fine, but may impact performance if used by many players
- **Options if you want to reduce polygons:**
  1. Re-export from Meshy AI with lower polygon count settings
  2. Use a 3D modeling tool (Blender, etc.) to decimate/reduce polygons
  3. Import anyway - for character models, slightly higher counts are usually acceptable
- **For now**: Click "Import" or "OK" to proceed - the model will work

### Textures Not Showing
- **If textures are embedded in the FBX**: They should import automatically with the main FBX file
- **If textures are separate files**: You may need to import them separately:
  1. Import the main `.fbx` file first
  2. Then import texture files (`.png`) into the same Model
  3. Apply textures manually to MeshParts if needed
- Check that texture files are properly referenced in the FBX
- Verify material properties in Studio (check MeshPart properties)
- Try re-importing if textures don't appear initially

## 📋 Model Names Reference

| Level | Display Name | Model Name (in ReplicatedStorage) |
|-------|-------------|-----------------------------------|
| 1 | Cosmo Kitten | `CosmoKitten` |
| 2 | Stellar Whisker | `StellarWhisker` |
| 3 | Nebula Paws | `NebulaPaws` |
| 4 | Galaxy Tail | `GalaxyTail` |
| 5 | Cosmic Whisker | `CosmicWhisker` |
| 6 | Astro Claws | `AstroClaws` |
| 7 | Void Hunter | `VoidHunter` |
| 8 | Star Chaser | `StarChaser` |
| 9 | Lunar Shadow | `LunarShadow` |
| 10 | Cosmo Master | `CosmoMaster` |
| 11 | Celestial Guardian | `CelestialGuardian` |
| 12 | Black Hole Cat | `BlackHoleCat` |

## 💡 Tips

1. **Import one at a time** - Test each model before importing the next
2. **Keep backups** - Save your `.rbxl` file frequently
3. **Use consistent naming** - Match the exact model names listed above
4. **Check textures** - Verify textures load correctly after import
5. **Test in-game** - Always test in Play mode, not just in Studio view

## 🎯 Quick Import Workflow

For each of your 11 FBX files:

1. **Import the main `.fbx` file** → `ReplicatedStorage`
   - Import only the main FBX file (the one that contains/holds the textures)
   - Don't import the individual texture files separately
2. Rename Model to match expected name
3. Add `Humanoid` (if missing)
4. Ensure `HumanoidRootPart` exists
5. Set `PrimaryPart` to `HumanoidRootPart`
6. **Verify textures** are visible in Studio
7. Test in Play mode
8. Repeat for next model

## 📦 Understanding Meshy AI FBX Exports

If your Meshy AI export contains multiple files (like 5 files), here's what they typically are:

1. **Main `.fbx` file** ← **Import this one!**
   - Contains the 3D mesh geometry
   - References/embeds the texture files
   - Example: `CharacterName_texture.fbx`

2. **Texture files** (usually 4-5 `.png` files):
   - Diffuse/Albedo texture (main color)
   - Normal map (surface details)
   - Metallic map (shininess)
   - Roughness map (surface smoothness)
   - Sometimes combined metallic-roughness map

3. **`.fbm` folder** (optional):
   - Contains additional texture resources
   - Usually referenced by the main FBX

**Answer: Yes, import the main `.fbx` file that holds/references the other files. The textures should come through automatically if they're embedded or properly referenced.**

---

**Note:** The game code is already set up to automatically use these models when they're in `ReplicatedStorage`. Just import them and they'll work! 🚀

