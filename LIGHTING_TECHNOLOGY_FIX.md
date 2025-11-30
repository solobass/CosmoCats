# 🔧 Finding Lighting Technology Setting

## ⚠️ Technology Property Not Visible?

The "Technology" property location can vary by Roblox Studio version. Here are alternative ways to find it:

---

## 📍 Method 1: Check if Already Set

**Technology might already be set to "Future" by default in newer Studio versions.**

**To check:**
1. Select **Lighting** in Explorer
2. In Properties panel, look for any property that mentions:
   - "Tech"
   - "Rendering"
   - "Shadow"
   - "LightingMode"

---

## 📍 Method 2: Use Command Bar

1. **View** → **Command Bar** (or press `Ctrl+/` / `Cmd+/`)
2. Type: `game.Lighting.Technology = Enum.Technology.Future`
3. Press **Enter**
4. This sets Technology to Future via script

---

## 📍 Method 3: Check Different Property Names

**In Properties panel (with Lighting selected), look for:**

- **"LightingTechnology"** (might be the property name)
- **"RenderingTechnology"**
- **"ShadowTechnology"**
- **"LightingMode"**

If you find any of these, set them to **"Future"** or **"Voxel"** (Future is the newer name).

---

## 📍 Method 4: Create a Setup Script (Easiest)

**If you can't find the property, we can set it via script:**

1. In Explorer, right-click **ServerScriptService**
2. **Insert Object** → **Script**
3. Name it: `LightingSetup`
4. Double-click to open
5. Paste this code:

```lua
-- Set Lighting Technology to Future
game.Lighting.Technology = Enum.Technology.Future

-- Enable GlobalShadows
game.Lighting.GlobalShadows = true

-- Add ColorCorrection if it doesn't exist
if not game.Lighting:FindFirstChild("ColorCorrection") then
	local colorCorrection = Instance.new("ColorCorrection")
	colorCorrection.Parent = game.Lighting
end

-- Add Bloom if it doesn't exist
if not game.Lighting:FindFirstChild("Bloom") then
	local bloom = Instance.new("Bloom")
	bloom.Parent = game.Lighting
end

-- Add DepthOfField if it doesn't exist
if not game.Lighting:FindFirstChild("DepthOfField") then
	local depthOfField = Instance.new("DepthOfField")
	depthOfField.Parent = game.Lighting
end

print("✅ Lighting setup complete!")
```

6. **Save** the script
7. **Run** the game (Play button) - the script will execute once
8. **Stop** the game
9. **Check Explorer** - you should see ColorCorrection, Bloom, DepthOfField under Lighting
10. **Check Properties** - Technology should now be set to Future

---

## 📍 Method 5: Check Studio Version

**What version of Roblox Studio are you using?**

1. **Help** → **About Roblox Studio**
2. Note the version number
3. In newer versions, Technology might be:
   - Already set to Future by default
   - Located in a different settings panel
   - Named differently

---

## ✅ Quick Test

**Try this to see if Technology is already Future:**

1. Select **Lighting** in Explorer
2. In **Properties**, look for any dropdown that says:
   - "Legacy"
   - "ShadowMap" 
   - "Voxel"
   - "Future"

If you see "Future" selected, you're already good!

---

## 🎯 Recommended: Use Method 4 (Script)

**The script method (Method 4) is the easiest and most reliable way to set all lighting properties at once.**

Just create the script, run the game once, and everything will be configured!

---

## 🆘 Still Can't Find It?

**Tell me:**
1. What properties DO you see when Lighting is selected?
2. What version of Roblox Studio? (Help → About)
3. Can you see "GlobalShadows" in Properties?

I'll help you find the exact location!

