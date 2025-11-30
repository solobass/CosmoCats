# 🚀 Rojo Server Setup - Manual Steps

## ⚠️ Current Issue

There's a filesystem timeout preventing automatic creation of `default.project.json`. Follow these manual steps:

---

## 📝 Step 1: Create the Project File

**Location:** `studio-project/default.project.json`

**Content:**
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

**How to create:**
1. Open your text editor (VS Code, Cursor, etc.)
2. Create new file: `studio-project/default.project.json`
3. Paste the JSON content above
4. Save the file

---

## 🎯 Step 2: Kill Any Process on Port 34872

```bash
# Find and kill process on port 34872
lsof -ti:34872 | xargs kill -9 2>/dev/null || echo "Port 34872 is free"
```

---

## 🚀 Step 3: Start Rojo Server

```bash
cd studio-project
rojo serve --port 34872
```

**Expected output:**
```
Rojo 7.6.0
Listening on 127.0.0.1:34872
```

**Keep this terminal open!** The server needs to stay running.

---

## 🔌 Step 4: Connect in Roblox Studio

1. **Open Roblox Studio**
2. **Plugins → Rojo → Connect**
3. **Should connect successfully!**

---

## ✅ Verification

**Check if server is running:**
```bash
lsof -ti:34872
```

**If you see a process ID, the server is running!**

---

## 🐛 Troubleshooting

### Port Already in Use
```bash
# Kill process on port 34872
lsof -ti:34872 | xargs kill -9
```

### Filesystem Timeout
If you get "Operation timed out" errors:
- Try creating the file in a different location first
- Then move it to `studio-project/default.project.json`
- Or use a different text editor

### Connection Failed
- Make sure Rojo server is running (`lsof -ti:34872`)
- Check that you're using the correct "Rojo" plugin (not "Rojo Boatly")
- Restart Roblox Studio

---

## 📚 Next Steps

Once connected:
- Edit files in `studio-project/src/src/`
- Changes will sync automatically to Roblox Studio
- Test your game in Studio!


