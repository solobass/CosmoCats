# 🔧 Rojo Server Workaround

## ⚠️ Current Issue

Rojo can read the project file, but times out when reading source files in `src/src/`. This is a filesystem-level issue affecting the entire directory.

---

## ✅ Solution: Use Your Editor to Verify Files

**The files exist and are valid** - the issue is macOS filesystem timeouts when Rojo tries to read them.

### Option 1: Try Starting Rojo from Your Editor Terminal

1. **Open Cursor/VS Code**
2. **Open Terminal** (View → Terminal)
3. **Run:**
   ```bash
   cd studio-project
   rojo serve --port 34872 rojo.project.json
   ```

**Sometimes running from the editor's terminal works better than system terminal.**

### Option 2: Move Project to Desktop (Temporary Test)

To test if it's a location-specific issue:

```bash
# Copy project to Desktop
cp -r "/Users/allanschenkel/Documents/Roblox Projects/CosmoCat/studio-project" ~/Desktop/CosmoCat-Rojo

# Try running from Desktop
cd ~/Desktop/CosmoCat-Rojo
rojo serve --port 34872 rojo.project.json
```

**If this works:** The issue is with the original directory location.

### Option 3: Restart Your Mac

**Sometimes a simple restart clears filesystem cache issues:**

1. **Save all work**
2. **Restart your Mac**
3. **Try starting Rojo again**

---

## 🎯 Quick Test: Verify Files Are Accessible

**In Cursor/VS Code:**

1. **Open:** `studio-project/src/src/ReplicatedStorage/Shared/GameConfig.lua`
2. **If it opens and displays:** Files are fine, it's a Rojo/filesystem interaction issue
3. **If it doesn't open:** There's a deeper filesystem problem

---

## 💡 Alternative: Manual File Sync (Temporary)

If Rojo won't work, you can manually sync files:

1. **Edit files in Cursor**
2. **Copy/paste into Roblox Studio manually** (temporary workaround)
3. **Or use Roblox Studio's built-in file sync** if available

---

## 📞 Next Steps

1. **Try Option 1 first** (run from editor terminal)
2. **If that fails, try Option 2** (move to Desktop)
3. **If still failing, restart Mac** (Option 3)

The files are valid - we just need to work around the filesystem timeout issue.


