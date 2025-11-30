# 🔧 Rojo Filesystem Timeout Fix

## ⚠️ Current Issue

Rojo cannot read `default.project.json` due to filesystem timeouts. This is a system-level issue, not a Rojo problem.

---

## 🔍 Diagnosis

**Symptoms:**
- `Operation timed out (os error 60)` when Rojo tries to read the project file
- File exists and has normal permissions
- Even `cat` command times out reading the file

**Possible Causes:**
1. **Network Drive:** The folder might be on a network mount that's slow/disconnected
2. **File System Corruption:** macOS filesystem cache issue
3. **Security Software:** Antivirus or security software blocking access
4. **File Lock:** Another process has the file locked

---

## ✅ Quick Fixes to Try

### Fix 1: Verify File in Your Editor

1. **Open Cursor/VS Code**
2. **Open:** `studio-project/default.project.json`
3. **Check if it opens and displays correctly**
4. **If it opens fine:** The file is valid, it's a system access issue
5. **If it doesn't open:** The file might be corrupted

### Fix 2: Recreate the Project File

**In your editor (Cursor/VS Code):**

1. **Delete** `studio-project/default.project.json` (if you can)
2. **Create a new file** with the same name
3. **Paste this content:**

```json
{
	"name": "CosmoCats",
	"tree": {
		"$className": "DataModel",
		"ReplicatedStorage": {
			"$className": "ReplicatedStorage",
			"$path": "src/src/ReplicatedStorage"
		},
		"ServerScriptService": {
			"$className": "ServerScriptService",
			"$path": "src/src/ServerScriptService"
		},
		"ServerStorage": {
			"$className": "ServerStorage",
			"$path": "src/src/ServerStorage"
		},
		"StarterPlayer": {
			"$className": "StarterPlayer",
			"StarterPlayerScripts": {
				"$className": "StarterPlayerScripts",
				"$path": "src/src/StarterPlayer/StarterPlayerScripts"
			},
			"StarterCharacterScripts": {
				"$className": "StarterCharacterScripts",
				"$path": "src/src/StarterPlayer/StarterCharacterScripts"
			}
		},
		"StarterGui": {
			"$className": "StarterGui",
			"$path": "src/src/StarterGui"
		},
		"Workspace": {
			"$className": "Workspace",
			"$path": "src/src/Workspace"
		},
		"Lighting": {
			"$className": "Lighting",
			"$path": "src/src/Lighting"
		}
	}
}
```

4. **Save the file**

### Fix 3: Check if Directory is on Network Drive

```bash
df "/Users/allanschenkel/Documents/Roblox Projects/CosmoCat"
```

**If it shows a network mount:**
- Try moving the project to a local drive
- Or ensure the network connection is stable

### Fix 4: Clear macOS File System Cache

```bash
# Restart your Mac (simplest fix)
# Or try:
sudo purge  # Clears memory cache (requires password)
```

### Fix 5: Move Project to Different Location

**Try moving the project temporarily:**

```bash
# Create a test location
mkdir -p ~/Desktop/CosmoCat-Test
cp -r studio-project ~/Desktop/CosmoCat-Test/

# Try running Rojo from there
cd ~/Desktop/CosmoCat-Test/studio-project
rojo serve --port 34872
```

**If this works:** The issue is with the original directory location.

---

## 🚀 After Fixing: Start Rojo Server

Once the file is accessible:

```bash
cd studio-project
rojo serve --port 34872
```

**Expected output:**
```
Rojo 7.6.0
Listening on 127.0.0.1:34872
```

**Then in Roblox Studio:**
- **Plugins → Rojo → Connect**

---

## 📞 If Nothing Works

**Last resort options:**

1. **Restart your Mac** (clears filesystem cache)
2. **Check Activity Monitor** for processes locking files
3. **Try a different project location** (Desktop, Documents root, etc.)
4. **Check macOS Console.app** for filesystem errors

---

## 💡 Alternative: Use Different Project File Name

If `default.project.json` is problematic, you can use a custom name:

```bash
# Create custom.project.json instead
# Then run:
rojo serve --port 34872 custom.project.json
```


