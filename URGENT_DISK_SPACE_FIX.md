# 🚨 URGENT: Disk Space Issue

## ⚠️ Problem Identified

**Your disk is 95% full!** This is causing filesystem timeouts when Rojo tries to read files.

**Current Status:**
- **Used:** 861 GB
- **Available:** 53 GB
- **Capacity:** 95%

When a drive is nearly full, macOS filesystem operations become extremely slow and can timeout.

---

## ✅ Immediate Fix: Free Up Disk Space

### Quick Wins (Free up 10-20 GB quickly):

1. **Empty Trash**
   ```bash
   rm -rf ~/.Trash/*
   ```

2. **Clear Browser Caches**
   - Chrome: Settings → Privacy → Clear browsing data
   - Safari: Develop → Empty Caches
   - Firefox: Preferences → Privacy → Clear Data

3. **Clear System Caches**
   ```bash
   # Clear user caches (safe)
   rm -rf ~/Library/Caches/*
   ```

4. **Remove Old Downloads**
   - Check `~/Downloads` for large files
   - Delete old installers, DMG files, etc.

5. **Clear Xcode Derived Data** (if you have Xcode)
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData/*
   ```

6. **Clear Docker/VM Images** (if applicable)
   ```bash
   docker system prune -a  # If you use Docker
   ```

### Check Large Files:

```bash
# Find large files (>1GB) in your home directory
find ~ -type f -size +1G -exec ls -lh {} \; 2>/dev/null | head -20
```

---

## 🎯 Target: Get Below 85% Capacity

**Aim for at least 100-150 GB free space** for smooth operation.

---

## 🚀 After Freeing Space: Start Rojo

Once you've freed up space:

```bash
cd studio-project
rojo serve --port 34872
```

**Then in Roblox Studio:**
- **Plugins → Rojo → Connect**

---

## 💡 Alternative: Work from External Drive

If you can't free up space immediately:

1. **Move project to external drive** (if you have one)
2. **Or work from a different location** with more space

---

## 📊 Check Current Space

```bash
df -h ~
```

**You want to see at least 15-20% free space.**


