# 🔐 Fixing Rojo Script Injection Permission

## ⚠️ Error Message

```
Plugin "Rojo" was denied script injection permission. 
You can grant this permission in the Plugin Manager.
```

## ✅ Solution: Grant Permission in Plugin Manager

### Step 1: Open Plugin Manager

1. **In Roblox Studio**, go to:
   - **Home** tab → **Plugin Manager** button
   - OR: **Plugins** menu → **Plugin Manager**

### Step 2: Find Rojo Plugin

1. **Look for "Rojo"** in the plugin list
2. **Find the "Script Injection"** column or permission setting

### Step 3: Grant Permission

1. **Click the permission toggle** next to Rojo
2. **Enable "Script Injection"** or **"Allow Script Injection"**
3. **Confirm** if prompted

### Step 4: Reconnect Rojo

1. **In the Rojo plugin window**, click **"Connect"** again
2. **Enter port: `34872`**
3. **Click "Connect"**

---

## 📋 Alternative: Plugin Security Settings

If you don't see the option in Plugin Manager:

1. **File** → **Settings** → **Security**
2. Look for **"Plugin Script Injection"** or **"Plugin Permissions"**
3. **Enable** or **Allow** for Rojo

---

## ✅ Expected Result

After granting permission:
- ✅ Rojo connects successfully
- ✅ Files sync from `studio-project/src/src/` to Studio
- ✅ No more permission errors

---

## 🔒 Why This Permission is Needed

Rojo needs script injection permission to:
- Create and modify scripts in your Roblox project
- Sync your local files into Studio
- Update scripts when you edit them locally

This is a **normal and safe** permission for development tools like Rojo.

