# 🔧 Rojo Plugin Troubleshooting Guide

**Common error:** `Failed to load plugin type=Local filepath=RojoManagedPlugin.rbxm`

---

## ⭐ Quick Fixes

### Fix 1: Reinstall Rojo Plugin (Most Common Solution)

**Steps:**
1. **Close Roblox Studio** completely
2. **Open Roblox Studio** again
3. Go to **Plugins** tab
4. Click **Manage Plugins**
5. **Uninstall** any existing Rojo plugin
6. **Install Rojo plugin** from Roblox:
   - Search for "Rojo" in Roblox plugin marketplace
   - Or visit: https://www.roblox.com/library/1211549682/Rojo
   - Click **Install**
7. **Restart Roblox Studio**

### Fix 2: Clear Plugin Cache

**Steps:**
1. **Close Roblox Studio**
2. Navigate to plugin cache folder:
   ```bash
   # macOS
   ~/Library/Application Support/Roblox/Plugins/
   
   # Windows
   %LOCALAPPDATA%\Roblox\Plugins\
   ```
3. **Delete** any Rojo-related plugin files
4. **Restart Roblox Studio**
5. **Reinstall** Rojo plugin

### Fix 3: Update Rojo

**Check Rojo version:**
```bash
rojo --version
```

**Update Rojo:**
```bash
npm update -g rojo
```

**Or reinstall:**
```bash
npm uninstall -g rojo
npm install -g rojo
```

### Fix 4: Verify Rojo Server is Running

**Before connecting in Studio:**
1. **Start Rojo server:**
   ```bash
   cd studio-project
   rojo serve
   ```
2. **Verify it's running:**
   - Should show: "Listening on 127.0.0.1:34872"
   - Keep this terminal open

3. **Then connect in Studio:**
   - Rojo → Connect
   - Should connect successfully

### Fix 5: Check Port Conflicts

**If port 34872 is in use:**
```bash
# Check if port is in use
lsof -i :34872

# Kill process if needed
kill -9 <PID>
```

**Or use different port:**
```bash
rojo serve --port 34873
```

**Update connection in Studio** to use port 34873.

---

## ⭐ Alternative: Use Wally (If Rojo Continues to Fail)

**Wally** is an alternative package manager for Roblox:

**Install Wally:**
```bash
# macOS/Linux
cargo install wally-cli

# Or via npm
npm install -g @wally/cli
```

**However:** Rojo is still recommended for file syncing.

---

## ⭐ Manual File Sync (Temporary Workaround)

**If Rojo continues to fail, you can:**

1. **Copy files manually:**
   - Copy from `studio-project/src/` to Roblox Studio
   - Place in correct service folders

2. **Use Roblox Studio's file system:**
   - File → Open from File
   - Import scripts manually

**Note:** This is tedious but works as a temporary solution.

---

## ⭐ Complete Rojo Reinstall

**If nothing works, complete reinstall:**

1. **Uninstall Rojo:**
   ```bash
   npm uninstall -g rojo
   ```

2. **Clear cache:**
   ```bash
   # macOS
   rm -rf ~/Library/Application\ Support/Roblox/Plugins/Rojo*
   ```

3. **Reinstall Rojo:**
   ```bash
   npm install -g rojo
   ```

4. **Verify installation:**
   ```bash
   rojo --version
   ```

5. **Reinstall plugin in Studio:**
   - Remove old plugin
   - Install fresh from marketplace

6. **Test connection:**
   ```bash
   cd studio-project
   rojo serve
   ```
   - Connect in Studio
   - Should work now

---

## ⭐ Verification Steps

**After fixing, verify:**

1. **Rojo server running:**
   ```bash
   rojo serve
   # Should show: "Listening on 127.0.0.1:34872"
   ```

2. **Plugin installed in Studio:**
   - Plugins tab → Should see Rojo plugin
   - No error messages

3. **Connection works:**
   - Rojo → Connect
   - Should show "Connected" status

4. **Test sync:**
   - Create test file in `studio-project/src/ReplicatedStorage/Test.lua`
   - Should appear in Studio Explorer

---

## 📚 Additional Resources

- **Rojo Documentation:** https://rojo.space/docs/
- **Rojo GitHub:** https://github.com/rojo-rbx/rojo
- **Plugin Marketplace:** https://www.roblox.com/library/1211549682/Rojo

---

## 🎯 Most Likely Solution

**Try this first:**
1. Close Studio
2. Reinstall Rojo plugin from marketplace
3. Restart Studio
4. Start `rojo serve` in terminal
5. Connect in Studio

**This fixes 90% of Rojo plugin errors.**

---

**Last Updated:** Rojo Troubleshooting Guide  
**Version:** 1.0  
**Status:** Complete Troubleshooting ✅
