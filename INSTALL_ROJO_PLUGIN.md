# 🔌 Installing Rojo Plugin - Step by Step

## ✅ Current Status

- **Rojo CLI:** ✅ Installed (v7.6.0)
- **Plugin:** ⏳ Needs installation

---

## 🎯 Installation Method: Manual Download

Since `rojo plugin install` timed out, use manual installation:

### Step 1: Download the Plugin File

1. **Go to:** https://github.com/rojo-rbx/rojo/releases
2. **Find the latest release** (or v7.6.0 to match your CLI)
3. **Download:** `Rojo.rbxm` file
   - Look for "Assets" section
   - Download `Rojo.rbxm` (not the source code)

### Step 2: Install in Roblox Studio

**macOS Location:**
```
~/Library/Application Support/Roblox/Plugins/
```

**Steps:**
1. **Open Finder**
2. **Press `Cmd + Shift + G`** (Go to Folder)
3. **Paste:** `~/Library/Application Support/Roblox/Plugins/`
4. **Copy `Rojo.rbxm` into this folder**
5. **Restart Roblox Studio**

### Step 3: Verify Installation

1. **Open Roblox Studio**
2. **Check Plugins menu:**
   - Should see **"Rojo"** option
   - Click **Plugins → Rojo → Connect**

---

## 🚀 Alternative: Try CLI Install Again

If you want to retry the CLI method:

```bash
# Make sure you're connected to the internet
rojo plugin install
```

If it still times out, use the manual method above.

---

## ✅ After Installation

Once the plugin is installed:

1. **Start Rojo server:**
   ```bash
   cd studio-project
   rojo serve
   ```

2. **In Roblox Studio:**
   - **Plugins → Rojo → Connect**
   - Should connect successfully!

---

## 📝 Notes

- **Uninstall "Rojo Boatly"** first if you still have it installed
- The plugin file is just a `.rbxm` file that needs to be in the Plugins folder
- Restart Studio after installing the plugin


