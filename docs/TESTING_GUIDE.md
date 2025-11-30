# CosmoCat Testing Guide 🧪

## ✅ Pre-Test Checklist

- [x] Rojo server is running (confirmed on port 34872)
- [x] All source files are in place
- [x] No linter errors detected
- [x] `CosmoCat.rbxl` file exists

## 🚀 Step-by-Step Testing Instructions

### 1. Open Roblox Studio
- Open Roblox Studio
- Open `CosmoCat.rbxl` file

### 2. Connect to Rojo
- Click the **Rojo** plugin button in Studio (usually in the toolbar)
- Click **"Connect"** or **"Sync"**
- It should connect to `localhost:34872`
- You should see "Connected to Rojo" or similar message
- Your code from `src/` will sync into Studio automatically

### 3. Verify Code Sync
- Check **Explorer** panel in Studio
- You should see:
  - `ServerScriptService` → `MainScript`, `BaseplateSetup`, `AvatarTest`
  - `StarterPlayer` → `StarterPlayerScripts` → `MainClient`, etc.
  - `ReplicatedStorage` → `Shared` → `GameConfig`, `CatAvatarManager`

### 4. Start Testing
- Click the **Play** button (▶️) in Studio
- Wait for the game to load

### 5. What to Check

#### ✅ Character Spawning
- [ ] Your character spawns (you see yourself in the game)
- [ ] Character has a visible appearance (either CosmoKitten model or fallback orange cat)
- [ ] You can see your character in the world

#### ✅ Movement
- [ ] Press **W/A/S/D** - character moves
- [ ] Press **Arrow Keys** - character moves (alternative)
- [ ] Press **Space** - character jumps
- [ ] Movement feels smooth and responsive

#### ✅ Camera
- [ ] Camera follows behind your character
- [ ] Camera moves smoothly as you move
- [ ] You can look around with mouse

#### ✅ Environment
- [ ] You're on a black baseplate (mostly invisible, but you can see it)
- [ ] Sky is dark/black (space theme)
- [ ] You don't fall through the floor

#### ✅ CatTreat Spawning
- [ ] Look in the **Output** console (View → Output)
- [ ] Should see messages like "=== CATTREAT SYSTEM STARTING ==="
- [ ] Should see "Spawned CatTreat X of 25" messages
- [ ] Wait a few seconds
- [ ] **Yellow blocks or CatTreat models** should fall from the sky
- [ ] They should land on the ground around you

#### ✅ CatTreat Collection
- [ ] Walk into a CatTreat (yellow block or model)
- [ ] It should disappear when you touch it
- [ ] Check **Output** console for "Collecting CatTreat" messages

#### ✅ UI System
- [ ] Look at bottom-left of screen
- [ ] Should see **"Meow: X"** score display
- [ ] Score should increase when you collect CatTreats
- [ ] Score display has dark background with white text

#### ✅ Level Progression
- [ ] Collect a CatTreat (gain 1 point)
- [ ] Score should update to "Meow: 1"
- [ ] Wait to see if level up notification appears
- [ ] Check **Output** for level-related messages

#### ✅ Console Output
- [ ] Open **Output** window (View → Output)
- [ ] Check for error messages (red text)
- [ ] Look for startup messages:
  - "=== CATTREAT COLLECTION & LEVEL SYSTEM STARTING ==="
  - "=== CATTREAT SYSTEM STARTING ==="
  - "=== SETTING UP BASEPLATE ==="

## 🐛 Common Issues & Solutions

### Issue: Can't see my character
**Solution:**
- Check Output for errors
- Make sure character spawned (check Workspace in Explorer)
- Try respawning (click Stop, then Play again)

### Issue: Can't move
**Solution:**
- Check if Humanoid exists on character
- Check Output for movement errors
- Verify `MainClient.client.lua` is in StarterPlayerScripts

### Issue: CatTreats not spawning
**Solution:**
- Check Output console for server messages
- Verify `MainScript.server.lua` is running
- Check for errors in Output

### Issue: Can't collect CatTreats
**Solution:**
- Make sure you're walking close enough (within 3 studs)
- Check Output for collection messages
- Verify RemoteEvents are created (check Output)

### Issue: UI not showing
**Solution:**
- Check PlayerGui in Explorer
- Look for "CosmoCatUI" ScreenGui
- Check Output for UI creation messages

### Issue: Rojo not syncing
**Solution:**
- Restart Rojo server
- Disconnect and reconnect Rojo plugin in Studio
- Check that Rojo is still running: `ps aux | grep rojo`

## 📊 Expected Test Results

### What Should Work ✅
1. Character spawns and you can move
2. 25 CatTreats spawn and fall from sky
3. You can collect CatTreats by walking into them
4. Score displays and updates in UI
5. Level notifications appear when leveling up
6. Camera follows character smoothly
7. Game world has dark space theme

### What Might Not Work Yet ⚠️
1. CosmoKitten model might not appear (fallback cat will show instead)
2. Level-based avatar switching (not implemented yet)
3. Special abilities per level (not fully implemented)
4. PvP mechanics (not implemented yet)

## 🎯 Quick Test Script

Run through this quickly:

1. **Start game** → Should spawn on baseplate
2. **Move with WASD** → Should move smoothly
3. **Wait 5 seconds** → CatTreats should fall from sky
4. **Walk into a CatTreat** → Should disappear and score +1
5. **Check UI** → Should show "Meow: 1"
6. **Collect more** → Score should keep increasing

## 📝 Testing Notes

Keep track of:
- Any errors in Output console
- Features that don't work as expected
- Things that work great
- Ideas for improvements

## 🔄 After Testing

Once you've tested:
1. Note any bugs or issues
2. Decide what to work on next
3. Check the **Next Steps** section in README.md

Happy testing! 🐱✨


