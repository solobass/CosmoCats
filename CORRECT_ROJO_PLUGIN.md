# 🔌 Installing the Official Rojo Plugin

**"Rojo Boatly" is NOT the official Rojo plugin.**

---

## ⭐ Official Rojo Plugin Installation

**The correct plugin is simply called "Rojo"** (by rojo-rbx)

**GitHub Repository:** https://github.com/rojo-rbx/rojo

---

## 📦 Step 1: Install the Rojo CLI (Required First)

You need the Rojo CLI installed before you can install the plugin. Choose one method:

### Method A: Install via Rokit (Recommended for Roblox projects)

1. **Create or edit `rokit.toml` in your project root:**
   ```toml
   [tools]
   rojo = "rojo-rbx/rojo@7.7.0-rc.1"
   ```

2. **Run:**
   ```bash
   rokit install
   ```

### Method B: Download from GitHub Release

1. **Go to:** https://github.com/rojo-rbx/rojo/releases
2. **Download the binary for macOS** (e.g., `rojo-macos.zip`)
3. **Extract and add to PATH:**
   ```bash
   # Example: Move to /usr/local/bin
   sudo mv rojo /usr/local/bin/
   chmod +x /usr/local/bin/rojo
   ```

### Method C: Install via Cargo (if you have Rust)

```bash
cargo install rojo --version 7.7.0-rc.1
```

**Verify CLI installation:**
```bash
rojo --version
```

---

## 🔌 Step 2: Install the Roblox Studio Plugin

Once you have the CLI installed, choose one method:

### Method 1: CLI Install (Easiest - Recommended)

```bash
rojo plugin install
```

This automatically installs the plugin into your Roblox Studio plugins folder.

### Method 2: Manual Download

1. **Download `Rojo.rbxm` from:** https://github.com/rojo-rbx/rojo/releases
2. **Place it in your Roblox Studio plugins folder:**
   - **macOS:** `~/Library/Application Support/Roblox/Plugins/`
   - **Windows:** `%LOCALAPPDATA%\Roblox\Plugins\`
3. **Restart Roblox Studio**

### Method 3: Roblox Library Link (Alternative)

1. **Open:** https://www.roblox.com/library/1211549682/Rojo
2. **Click "Get Plugin"** (requires being logged in)
3. **Roblox Studio will open and install it**

---

## ⚠️ Uninstall "Rojo Boatly" First

**Before installing the correct plugin:**

1. **Open Roblox Studio**
2. **Plugins → Manage Plugins**
3. **Find "Rojo Boatly"**
4. **Click "Uninstall" or remove it**
5. **Restart Roblox Studio**

---

## ✅ Verify Plugin Installation

**After installation, verify:**

1. **Open Roblox Studio**
2. **Check Plugins menu:**
   - Should see **"Rojo"** (not "Rojo Boatly")
   - Should have menu option: **Rojo → Connect**
3. **The correct plugin should:**
   - Be named simply "Rojo" (by rojo-rbx)
   - Show connection status when you click Connect
   - Work with `rojo serve` command

**If you see "Rojo → Connect" in the Plugins menu, you have the right one!**

---

## 🚀 Using Rojo After Installation

### 1. Start Rojo Server

```bash
cd studio-project
rojo serve
```

You should see:
```
Rojo 7.x.x
Listening on port 34872
```

### 2. Connect in Roblox Studio

1. **Open Roblox Studio**
2. **Plugins → Rojo → Connect**
3. **Should connect successfully** (you'll see a confirmation)

### 3. Test File Sync

- **Edit a file** in `studio-project/src/`
- **Save the file**
- **Check Roblox Studio** - changes should appear automatically!

---

## 📚 Official Rojo Resources

- **GitHub:** https://github.com/rojo-rbx/rojo
- **Documentation:** https://rojo.space/docs/
- **Releases:** https://github.com/rojo-rbx/rojo/releases

---

## 🎯 Quick Installation Command

**If you already have the CLI installed, just run:**

```bash
rojo plugin install
```

**Then restart Roblox Studio and you're ready to go!**
