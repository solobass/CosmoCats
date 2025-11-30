# 💡 Roblox Studio Lighting Settings Guide

## ⭐ Step-by-Step Instructions

---

## 📍 Step 1: Open Explorer

1. **View** → **Explorer** (or press `Ctrl+1` / `Cmd+1`)
2. The Explorer panel should appear on the right side

---

## 📍 Step 2: Find Lighting

1. **In Explorer**, scroll down to find **"Lighting"**
2. It's usually near the bottom of the service list
3. **Click on "Lighting"** to select it

---

## 📍 Step 3: Set Technology to Future

1. **With Lighting selected**, look at the **Properties** panel (usually on the right)
2. If Properties isn't visible: **View** → **Properties** (or press `Ctrl+2` / `Cmd+2`)
3. **Find "Technology"** in the Properties panel
4. **Click the dropdown** next to Technology
5. **Select "Future"** from the dropdown

---

## 📍 Step 4: Enable GlobalShadows

1. **Still in Properties panel** (with Lighting selected)
2. **Find "GlobalShadows"** (might be called "Shadows" or "Global Shadows")
3. **Check the box** or **set to "true"** to enable it

---

## 📍 Step 5: Add ColorCorrection

1. **Right-click on "Lighting"** in Explorer
2. **Insert Object** → **ColorCorrection**
3. A new "ColorCorrection" object should appear under Lighting
4. **Leave it with default settings** for now (you can customize later)

---

## 📍 Step 6: Add Bloom

1. **Right-click on "Lighting"** in Explorer
2. **Insert Object** → **Bloom**
3. A new "Bloom" object should appear under Lighting
4. **Leave it with default settings** for now

---

## 📍 Step 7: Add DepthOfField (Optional)

1. **Right-click on "Lighting"** in Explorer
2. **Insert Object** → **DepthOfField**
3. A new "DepthOfField" object should appear under Lighting
4. **This is optional** - only needed for photo mode

---

## ✅ Verification Checklist

After completing all steps, your Explorer should show:

```
Lighting
├── ColorCorrection
├── Bloom
└── DepthOfField (optional)
```

And in Properties (with Lighting selected):
- **Technology:** Future
- **GlobalShadows:** Enabled/True

---

## 🎯 Quick Visual Guide

**Explorer Panel:**
```
Workspace
ReplicatedStorage
ServerScriptService
...
Lighting ← Click here
├── ColorCorrection ← Should appear after adding
├── Bloom ← Should appear after adding
└── DepthOfField ← Should appear after adding (optional)
```

**Properties Panel (with Lighting selected):**
```
Technology: [Future ▼]
GlobalShadows: ☑ (checked)
Brightness: 1.5
...
```

---

## 🆘 Troubleshooting

### Can't find Lighting in Explorer?
- Make sure you're looking at the **service list** (not Workspace contents)
- Lighting is a **service**, not a part/model
- Try scrolling down in Explorer

### Can't find "Insert Object"?
- Make sure you're **right-clicking on "Lighting"** (the service name)
- Not right-clicking on a part or folder
- The menu should show "Insert Object" as an option

### Properties panel not showing?
- **View** → **Properties** (or `Ctrl+2` / `Cmd+2`)
- Make sure **Lighting is selected** in Explorer
- Properties panel should be visible on the right side

---

## ✅ You're Done!

Once you've completed these steps, your lighting is configured for Cosmo Cats!

**Next:** Continue with folder creation or code generation.

