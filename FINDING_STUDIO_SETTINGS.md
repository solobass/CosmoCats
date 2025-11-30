# 🔍 Finding Security Settings in Roblox Studio

## ⚠️ Where to Find "Studio Access to API Services" and "Allow HTTP Requests"

The location of these settings can vary by Roblox Studio version. Here are all the places to check:

---

## 📍 Method 1: Game Settings (Most Common)

### Path:
1. **Home Tab** → **Game Settings** button (top toolbar)
2. **Security Tab** (left sidebar in the settings window)
3. Look for:
   - **"Enable Studio Access to API Services"** (checkbox)
   - **"Allow HTTP Requests"** (checkbox)

### Alternative Path:
1. **File** → **Game Settings**
2. **Security Tab**
3. Check the boxes

---

## 📍 Method 2: Home Tab → Settings

1. **Home Tab**
2. Look for **"Settings"** or **"Game Settings"** button
3. Click it
4. Navigate to **Security** tab

---

## 📍 Method 3: View Menu

1. **View** → **Game Settings**
2. **Security Tab**
3. Enable the checkboxes

---

## 📋 What to Look For:

### In the Security Tab, you should see:

**Checkboxes or toggles for:**
- ☐ **Enable Studio Access to API Services**
  - This allows scripts to use Roblox API services in Studio
  - Usually near the top of the Security tab

- ☐ **Allow HTTP Requests**
  - This allows scripts to make HTTP requests
  - Usually below the API Services option

---

## 🔄 If You Still Can't Find It:

### Option 1: Check Your Studio Version
- These settings might be in a different location in older/newer versions
- Try updating Roblox Studio to the latest version

### Option 2: Alternative Names
The settings might be named differently:
- "Enable Studio API Access"
- "HTTP Requests Enabled"
- "Allow External Requests"

### Option 3: They Might Already Be Enabled
- Some versions have these enabled by default
- Check if your scripts work without changing settings

---

## ✅ Quick Test:

**If you can't find the settings, try this:**
1. Create a simple script that uses HTTPService
2. If it works, the settings are already enabled
3. If it errors, the settings need to be enabled (and we'll find another way)

---

## 📸 Visual Guide:

**The Security tab should look something like this:**

```
Game Settings
├── General
├── Security ← Click here
│   ├── ☐ Enable Studio Access to API Services
│   ├── ☐ Allow HTTP Requests
│   └── (other security options)
├── Avatar
└── ...
```

---

## 🆘 Still Stuck?

**Tell me:**
1. What version of Roblox Studio are you using?
2. What do you see when you click "Game Settings"?
3. What tabs are available in the Game Settings window?

I'll help you find the exact location!

