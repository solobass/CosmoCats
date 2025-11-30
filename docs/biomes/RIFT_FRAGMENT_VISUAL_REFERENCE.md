# Rift Fragment - Visual Reference Guide

## 🌌 Core Visual Themes

**Atmosphere:** A secret void room where reality fractures. Floating fragments of space-time, dark energy rifts, and cosmic anomalies create an otherworldly, mysterious environment. The most secret and dangerous-looking biome.

**Mood:** Mysterious, dangerous, otherworldly, cosmic chaos, void energy

**Key Visual Elements:**
- Floating space fragments
- Dark energy rifts (cracks in reality)
- Void particles and dark matter
- Glowing anomaly cores
- Distorted space effects
- Deep void darkness with bright accents

---

## 🎨 Color Palette

### Primary Colors
- **Void Black**: `#0A0014` - Deep space background
- **Rift Red**: `#FF0040` - Energy rifts and cracks
- **Anomaly Purple**: `#8B00FF` - Glowing anomaly cores
- **Dark Matter Blue**: `#1A0A3D` - Void energy
- **Crack Orange**: `#FF6B00` - Rift edges

### Secondary Colors
- **Deep Void**: `#000000` - Absolute darkness
- **Energy Cyan**: `#00FFFF` - Bright energy accents
- **Distortion Pink**: `#FF00AA` - Space distortion effects

### Avoid
- ✘ Natural colors (greens, browns)
- ✘ Bright, cheerful colors
- ✘ Earth-like materials

---

## 🏗️ Visual Elements

### Terrain
- **Floating Platforms**: Dark, angular platforms suspended in void
- **Rift Cracks**: Glowing red cracks in space (ground and air)
- **Void Pits**: Deep black holes with energy edges
- **Fractured Ground**: Broken, floating pieces
- **Energy Bridges**: Glowing bridges connecting platforms

### Structures
- **Rift Portals**: Large, glowing red portals
- **Anomaly Cores**: Floating purple energy orbs
- **Void Spires**: Dark, angular spires reaching upward
- **Fracture Points**: Central areas where rifts converge
- **Distortion Zones**: Areas with visual warping effects

### Atmospheric Effects
- **Void Particles**: Dark, swirling particles
- **Rift Energy**: Red energy beams from cracks
- **Anomaly Glow**: Purple energy pulses
- **Space Distortion**: Visual warping effects
- **Dark Matter Clouds**: Swirling dark energy

---

## 🎮 Roblox Studio Implementation

### Lighting Preset
```lua
-- Rift Fragment Lighting
Ambient = Color3.fromRGB(20, 10, 30) -- Deep purple ambient
Brightness = 0.3 -- Very dark
FogColor = Color3.fromRGB(10, 0, 20) -- Dark purple fog
FogEnd = 200 -- Close fog for claustrophobic feel
OutdoorAmbient = Color3.fromRGB(15, 5, 25) -- Dark outdoor light
```

### Materials
- **Platforms**: Neon (for glowing edges), Metal (for dark surfaces)
- **Rift Cracks**: Neon with high brightness (red)
- **Anomaly Cores**: Neon (purple, pulsing)
- **Void Pits**: Black, non-reflective
- **Energy**: Neon with high brightness

### Particle Effects
- **Void Particles**: Dark particles with low visibility
- **Rift Energy**: Beam attachments (red)
- **Anomaly Glow**: PointLight with purple tint, pulsing
- **Space Distortion**: Use PostEffectGui for warping (if possible)

---

## 📐 Layout Guidelines

### Central Features
1. **Fracture Point** (Center) - Main convergence of rifts
2. **Anomaly Core Cluster** (North) - Group of floating energy orbs
3. **Void Pit** (South) - Deep black hole with energy rim
4. **Rift Portal** (East/West) - Large portal entrances

### Spawn Point
- Position: Edge of Fracture Point
- Elevation: Floating platform
- Lighting: Dark with red rift glow nearby

### Travel Connections
- **From**: Void Temple (Secret connection)
- **To**: Aurora Tundra (Hidden path)
- **Secret**: Only accessible via special means

---

## ✨ Specific Biome Features

### Rift Cracks
- **Appearance**: Glowing red cracks in space
- **Size**: 1-3 studs wide, varying lengths
- **Material**: Neon with high brightness
- **Effect**: Pulsing red energy
- **Location**: Ground, walls, and floating in air

### Anomaly Cores
- **Size**: 2-4 studs diameter
- **Color**: Purple (#8B00FF) with pulsing glow
- **Movement**: Slow floating/rotation
- **Effect**: Energy pulses outward
- **Light**: PointLight with purple tint

### Floating Platforms
- **Shape**: Angular, geometric
- **Material**: Dark metal or Neon (dark)
- **Size**: 10-20 studs across
- **Elevation**: Varying heights (10-50 studs)
- **Edges**: Glowing energy edges (red or purple)

### Void Pits
- **Depth**: Appears infinite (use fog)
- **Edge**: Glowing energy rim (red or orange)
- **Effect**: Pulling/distortion effect
- **Size**: 5-15 studs diameter

### RP Zones
1. **Fracture Point** - Central dramatic area
2. **Anomaly Core Cluster** - Mysterious energy zone
3. **Floating Platform Network** - Multiple connected platforms
4. **Rift Portal** - Portal entrance/exit

---

## 🎯 Visual Consistency Checklist

- [ ] Dark, void-like atmosphere
- [ ] Red rift cracks throughout
- [ ] Purple anomaly cores
- [ ] Floating platforms
- [ ] Deep darkness with bright accents
- [ ] Cosmic/void energy theme
- [ ] Dangerous, mysterious feel
- [ ] Space-time fracture effects
- [ ] Secret/hidden biome aesthetic
- [ ] Otherworldly, non-natural appearance

---

## ⚠️ Special Considerations

### Player Experience
- **Visibility**: Very dark, players may need to adjust brightness
- **Navigation**: Floating platforms require careful movement
- **Atmosphere**: Intentionally disorienting and mysterious
- **Access**: Should feel like a secret discovery

### Performance
- **Particle Effects**: Use sparingly (void particles)
- **Lighting**: Minimal PointLights (only on cores/portals)
- **Geometry**: Keep platforms simple, use effects for detail
- **Fog**: Close fog distance for performance and atmosphere

---

**Last Updated:** Rift Fragment Visual Reference  
**Status:** Complete ✅
