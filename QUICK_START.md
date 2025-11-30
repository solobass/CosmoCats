# 🚀 Cosmo Cats — Quick Start Guide

**Get your project running in 5 minutes!**

---

## Step 1: Roblox Studio Setup (5 minutes)

### 1.1 Create Base Project
1. Open **Roblox Studio**
2. Click **"Baseplate"**
3. **File → Save As** → `CosmoCats_MainPlace`
4. Save to: `/Users/allanschenkel/Documents/Roblox Projects/CosmoCat/studio-project/`

### 1.2 Enable Settings
**Home → Game Settings → Security:**
- ✔ Enable Studio Access to API Services
- ✔ Allow HTTP Requests

**Explorer → Lighting:**
- Technology → **Future**
- Enable **GlobalShadows**
- Add **ColorCorrection**, **Bloom**, **DepthOfField**

### 1.3 Create Folder Structure
**See:** `ROBOX_STUDIO_SETUP.md` for complete folder checklist

**Quick version:** Create these main folders:
- `ReplicatedStorage/CosmoCats/`
- `ServerScriptService/`
- `ServerStorage/`
- `StarterPlayer/StarterPlayerScripts/`
- `StarterGui/UI/`
- `Workspace/Biomes/`
- `Lighting/`

---

## Step 2: Rojo Setup (2 minutes)

### 2.1 Install Rojo (if needed)
```bash
npm install -g rojo
```

### 2.2 Start Rojo Server
```bash
cd "/Users/allanschenkel/Documents/Roblox Projects/CosmoCat/studio-project"
rojo serve
```

### 2.3 Connect in Roblox Studio
1. Install **Rojo Plugin** from Roblox
2. **Rojo → Connect**
3. Should show "Connected"

---

## Step 3: Use Cursor to Generate Code (10 minutes)

### 3.1 Open Cursor
Open the project in Cursor:
```bash
cd "/Users/allanschenkel/Documents/Roblox Projects/CosmoCat"
cursor .
```

### 3.2 Use Implementation Prompts
1. Open `docs/CURSOR_IMPLEMENTATION_PROMPTS.md`
2. Copy **T1** prompt
3. Paste into Cursor
4. Let Cursor generate folder structure
5. Repeat with **T2**, **T3**, etc.

### 3.3 Recommended Order
1. **T1** - Folder structure
2. **T2** - Core architecture
3. **T10** - DataStore (critical)
4. **T3** - Species system
5. Continue with remaining prompts

---

## Step 4: Test in Roblox Studio

### 4.1 Verify Sync
- Files should appear in Roblox Studio Explorer
- Check that scripts are in correct locations

### 4.2 Test Play
- Click **Play** in Roblox Studio
- Check Output for errors
- Verify basic functionality

---

## ✅ You're Ready!

**Next Steps:**
1. Follow **T1-T16** in Cursor Implementation Prompts
2. Reference system Bibles for detailed specs
3. Test each system as you build
4. Iterate and refine

**Need Help?**
- See `ROBOX_STUDIO_SETUP.md` for detailed setup
- See `docs/CURSOR_IMPLEMENTATION_PROMPTS.md` for code generation
- See `docs/MASTER_GAME_ARCHITECTURE.md` for overview

---

**Let's build Cosmo Cats! 🌌**

---

## ⚠️ Troubleshooting

### Rojo Plugin Error

**If you see:** `Failed to load plugin type=Local filepath=RojoManagedPlugin.rbxm`

**Quick Fix:**
1. Close Roblox Studio
2. Reinstall Rojo plugin from marketplace
3. Restart Studio
4. Try connecting again

**See:** `ROJO_TROUBLESHOOTING.md` for complete troubleshooting guide.

---

