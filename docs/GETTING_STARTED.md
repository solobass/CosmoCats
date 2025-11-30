# Getting Started with CosmoCat 🐱🚀

Welcome back! This guide will help you get back into the CosmoCat project.

## 📋 Project Summary

**CosmoCat** is a Roblox game where players:
- Play as cats in space
- Collect "CatTreats" (shooting star collectibles)
- Level up by collecting points
- Eventually battle other players in PvP

### Current Status

**✅ COMPLETED:**
- ✅ Phase 1: Basic setup (movement, camera, controls)
- ✅ Phase 2: Collectibles & scoring system (CatTreats spawn and can be collected)
- ✅ Phase 3: Cat avatar system (CosmoKitten model integration)

**🎯 NEXT PRIORITIES:**
1. Level-based avatar switching (different cats per level)
2. Multiplayer PvP mechanics
3. Special abilities for each cat type
4. Enhanced space environment

---

## 🚀 Quick Start Guide

### 1. Start Development Environment

```bash
# Start Rojo server (syncs code to Roblox Studio)
./start-rojo.sh

# OR manually:
aftman run rojo serve default.project.json
```

### 2. Open Roblox Studio
- Open `CosmoCat.rbxl` in Roblox Studio
- Connect to Rojo server (should appear in Rojo plugin)

### 3. Test the Game
1. Click **Play** in Studio
2. You should see:
   - Your character spawns (with CosmoKitten avatar if model is available)
   - 25 yellow CatTreats fall from the sky
   - UI shows "Meow: 0" in bottom left
   - Move with WASD, jump with Space

### 4. Collect CatTreats
- Walk into falling CatTreats to collect them
- Score increases and displays in UI
- Level up notifications appear when you reach new levels

---

## 📁 Key Files Overview

### Client-Side (`StarterPlayer/StarterPlayerScripts/`)
- **`MainClient.client.lua`** - Main client logic
  - CatTreat collection detection
  - UI updates (score, level notifications)
  - Movement controls (WASD + arrow keys)
  - Third-person camera setup
  - UI cleanup (removes unwanted elements)

### Server-Side (`ServerScriptService/`)
- **`MainScript.server.lua`** - Main server logic
  - Spawns 25 CatTreats that fall from sky
  - Handles CatTreat collection requests from clients
  - Initializes CatAvatarManager system

- **`BaseplateSetup.server.lua`** - Creates game world (baseplate, sky)

- **`AvatarTest.server.lua`** - Avatar system testing

### Shared (`ReplicatedStorage/Shared/`)
- **`GameConfig.lua`** - Game configuration
  - 10 levels with point requirements
  - Level names (Cosmo Kitten, Stellar Whisker, etc.)
  - Game settings

- **`CatAvatarManager.lua`** - Avatar system
  - Handles CosmoKitten model loading
  - Manages avatar switching per level
  - Creates fallback character if model not found

---

## 🎮 Current Game Mechanics

### Scoring
- **CatTreat**: 1 point each
- Score displayed as "Meow: X" in bottom left
- Score persists per session

### Level Progression
- **Level 1**: 0 points (Cosmo Kitten)
- **Level 2**: 1 point (Stellar Whisker)
- **Level 3**: 2 points (Nebula Paws)
- And so on... (check `GameConfig.lua` for full list)

### Controls
- **WASD** or **Arrow Keys**: Movement
- **Space**: Jump
- **E**: Special ability (not yet fully implemented per level)

---

## 🐛 Known Issues / Setup Notes

### Avatar Model Setup
The game expects a `CosmoKitten` model in `ReplicatedStorage`. 

**If you don't have the model yet:**
- The game will create a fallback orange cat character
- You can import your FBX model later (see `CATTREAT_SETUP.md`)

**To add CosmoKitten model:**
1. Import your FBX model in Roblox Studio
2. Place it in: `ReplicatedStorage > CosmoKitten`
3. Ensure it has `Humanoid` and `HumanoidRootPart`
4. The avatar system will automatically use it

### CatTreat Models
- If no CatTreat model is found, yellow placeholder blocks spawn instead
- See `CATTREAT_SETUP.md` for how to add real CatTreat models

---

## 🔧 Development Workflow

1. **Make code changes** in the `src/` folder
2. **Save files** - Rojo automatically syncs to Studio
3. **Test in Studio** - Click Play to test
4. **Check console** - Both client and server output helpful messages

### Testing Checklist
- [ ] Character spawns correctly
- [ ] Movement works (WASD)
- [ ] CatTreats spawn and fall
- [ ] Can collect CatTreats by walking into them
- [ ] Score updates in UI
- [ ] Level notifications appear
- [ ] Camera follows character

---

## 📝 Next Steps

### Immediate (High Priority)
1. **Verify everything works** - Run through testing checklist
2. **Add CosmoKitten model** if you haven't already
3. **Test level progression** - Collect treats, see if levels update

### Short Term
1. **Level-based avatar switching** - Different cat models per level
2. **Special abilities** - Implement unique abilities for each level
3. **CatTreat respawning** - Make treats respawn after collection

### Medium Term
1. **PvP mechanics** - Player vs player combat
2. **Enhanced environment** - Better space visuals
3. **More collectible types** - Fish, FurBall, etc.

---

## 🆘 Troubleshooting

### Rojo not syncing?
- Check that Rojo server is running
- Verify connection in Studio (Rojo plugin should show connected)
- Try restarting both Rojo and Studio

### Character not moving?
- Check console for errors
- Verify Humanoid exists on character
- Check WalkSpeed is > 0

### CatTreats not spawning?
- Check server console for errors
- Verify `MainScript.server.lua` is running
- Check that workspace is accessible

### UI not showing?
- Check PlayerGui exists
- Verify `MainClient.client.lua` is in StarterPlayerScripts
- Check console for UI creation messages

---

## 📚 Documentation Files

- **`README.md`** - Main project overview
- **`PHASE1_README.md`** - Phase 1 implementation details
- **`DEBUGGING_GUIDE.md`** - Debugging information
- **`CATTREAT_SETUP.md`** - How to add CatTreat models
- **`GETTING_STARTED.md`** - This file!

---

## 🎯 What Should I Work On?

Based on your priorities, here are some good starting points:

1. **Want to add features?** → Work on level-based avatar switching or special abilities
2. **Want to polish?** → Improve UI, add sound effects, enhance environment
3. **Want to fix bugs?** → Test everything, fix any issues you find
4. **Want to expand?** → Add PvP mechanics, more collectibles, power-ups

**Happy coding! 🐱✨**


