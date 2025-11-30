# Travel Network / Fast Travel System

Complete travel network connecting all biomes in Cosmo Cats.

## 🗺️ Travel Connections

### Primary Paths

1. **Nebula Forest** → **Lunar Caverns**
   - **Type:** Cave path
   - **Location:** Small caves in Forest
   - **Visual:** Glowing crystal entrance

2. **Nebula Forest** → **Starfall Desert**
   - **Type:** Star-lit canyon
   - **Location:** Eastern edge of Forest
   - **Visual:** Canyon with star particles

3. **Starfall Desert** → **Aurora Tundra**
   - **Type:** Secret crack in meteor
   - **Location:** Hidden in meteor crater
   - **Visual:** Glowing crack in meteor wall

4. **Lunar Caverns** → **Void Temple**
   - **Type:** Descending crystal path
   - **Location:** Deepest part of Caverns
   - **Visual:** Crystal staircase descending

5. **Comet Shores** → **Outer Rim**
   - **Type:** Stargate portal
   - **Location:** Central platform on Shores
   - **Visual:** Glowing portal circle

6. **Void Temple** → **Rift Fragment**
   - **Type:** Hidden teleport seal
   - **Location:** Dark altar in Temple
   - **Visual:** Glitch portal effect

### Circular World Structure

The world forms a **circular loop** with optional shortcuts.

## 🚪 Portal/Path Implementation

### Portal Types

1. **Cave Entrance** - Simple entrance with visual marker
2. **Canyon Path** - Open path with visual guide
3. **Secret Entrance** - Hidden, requires discovery
4. **Crystal Path** - Staircase or ramp with crystals
5. **Stargate Portal** - Teleportation portal
6. **Glitch Portal** - Special effect teleport

### Visual Markers

Each connection should have:
- Clear visual indicator
- Particle effects
- Sound cues
- UI prompt (optional)

## 🎮 Player Experience

### Discovery
- Players discover paths naturally
- Secret paths require exploration
- Visual cues guide players

### Fast Travel (Future)
- Unlock fast travel points
- Teleport between discovered locations
- Requires Stardust or unlock

## 📍 Spawn Points

Each biome has a spawn point:
- `ForestSpawn` - Nebula Forest
- `CavernSpawn` - Lunar Caverns
- `DesertSpawn` - Starfall Desert
- `ShoresSpawn` - Comet Shores
- `TempleSpawn` - Void Temple
- `OuterRimSpawn` - Outer Rim

## 🔧 Implementation

### For Cursor:
1. Create portal models/parts
2. Add visual effects
3. Implement teleportation logic
4. Set up spawn points

### For Roblox Studio:
1. Place portal parts in each biome
2. Add particle effects
3. Configure teleportation
4. Test travel paths

---

**Last Updated:** Travel Network Documentation  
**Status:** Ready for implementation ✅
