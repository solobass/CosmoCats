# 🌌 Cosmo Cats — Audio & SFX Style Guide (Sound Identity Bible)

**For Roblox Studio + Cursor**

This is the official sound bible for Cosmo Cats — a complete audio identity system inspired by:
- Journey (PS4)
- Ori and the Will of the Wisps
- Sky: Children of the Light
- No Man's Sky ambience
- Feather Family's gentle minimalism

This guide ensures your game has a beautiful, consistent soundscape, even as you add new species, biomes, effects, and emotes.

---

## 🎵 1. OVERALL AUDIO PHILOSOPHY

Cosmo Cats uses a **dreamy, ethereal audio style**.

### Every sound in the game should feel:
- ✔ **Soft** - Gentle, not harsh
- ✔ **Lightweight** - Airy, not heavy
- ✔ **Magical** - Enchanted, mystical
- ✔ **Cosmic** - Space-themed, ethereal
- ✔ **Cute but elegant** - Friendly, refined
- ✔ **Non-intrusive** - Background, ambient
- ✔ **Ambient** - Atmospheric, immersive

### NO sound should feel:
- ✘ **Harsh** - Aggressive, sharp
- ✘ **Mechanical** - Robotic, industrial
- ✘ **Metallic** - Clangy, clinky
- ✘ **Cartoonish** - Over-the-top, silly
- ✘ **Loud / aggressive** - Intrusive, jarring

**This is a gentle, atmospheric RP experience, not an action game.**

---

## 🎼 2. CORE SOUND SIGNATURES

All audio should be built from these signature sound families:

### A. Soft Synth Pads
- **Characteristics**: Warm, smooth, slight reverb
- **Use**: Ambience and UI transitions
- **Feel**: Gentle, atmospheric, enveloping

### B. Glassy Bell Tones
- **Characteristics**: Quiet, chime-like, lovely
- **Use**: UI clicks, species unlocks, pickups
- **Feel**: Delicate, magical, pleasant

### C. Shimmering High Frequencies
- **Characteristics**: Sparkles, tiny star-like glints
- **Use**: Magical effects, particles, glows
- **Feel**: Ethereal, twinkling, cosmic

### D. Airy Wind / Whisper Textures
- **Characteristics**: Soft, flowing, atmospheric
- **Use**: Biome ambience (nebula forests, temple ruins)
- **Feel**: Gentle, natural, immersive

### E. Subtle Low Drones
- **Characteristics**: Deep, mysterious, non-scary
- **Use**: Void Temple, Rift Fragment
- **Feel**: Mysterious, atmospheric, grounding

---

## 🎵 3. SOUND CATEGORY BREAKDOWN

Each category has style requirements + implementation notes.

### 🎵 3.1 AMBIENCE (BIOME BACKGROUNDS)

Each biome gets a **layered looping ambience**, composed of:
- Base pad (soft chord)
- Environmental texture (wind, shimmer, water)
- Occasional sparkles

#### Nebula Forest
- **Soft purple pads** - Warm, atmospheric
- **Twinkling star sparkles** - Magical, ethereal
- **Very light wind** - Gentle, natural

#### Lunar Caverns
- **Crystal resonance** - Soft bell pings
- **Echoing reverb tail** - Long, spacious
- **Low blue drones** - Mysterious, cool

#### Starfall Desert
- **Warm wind** - Gentle, sandy
- **Falling star chimes** - Far in the distance
- **Occasional sandy whispers** - Subtle, atmospheric

#### Comet Shores
- **Gentle glowing-water wash** - Soft, flowing
- **Light bell tones** - Delicate, melodic
- **Minimal bass** - Light, airy

#### Void Temple
- **Deep drones** - Mysterious, grounding
- **Soft pulse** - Rhythmic, meditative
- **Faint ritual tones** - Sacred, ethereal

#### Outer Rim
- **"Space hum"** - Sci-fi airy drone
- **Sparkling orbital chimes** - Magical, cosmic
- **Occasional reverb sweeps** - Dynamic, spacious

### 🎵 3.2 FOOTSTEPS

**Cats don't stomp** — footsteps should be:
- Very quiet
- Gentle pads, puffs, soft taps
- Unique per biome surface

**Footstep Style by Biome:**

| Biome | Footstep Style |
|-------|----------------|
| Forest | Soft grass pad + tiny sparkle |
| Caverns | Light crystal tap |
| Desert | Sand puffs |
| Shores | Wet-soft glow sound |
| Temple | Gentle stone taps |
| Outer Rim | Zero-G "floaty woosh" |

### 🎵 3.3 EMOTE SOUNDS

#### SIT / LAY / LOAF
- **Soft cloth rustle** - Gentle, natural
- **Small chime** - Delicate, pleasant

#### GROOM
- **Quiet brushing sound** - Soft, gentle
- **No gross licking** - Keep it elegant

#### TAIL FLICK
- **Tiny whoosh** - Light, airy
- **Maybe a "ping"** - If magical tail

#### MEOW
**Rules:**
- Never realistic or harsh
- Soft, melodic, airy
- Slight reverb
- Not too frequent or long
- If you want a "cosmic meow," pitch-shift + add sparkle layer

### 🎵 3.4 INTERACTION SFX

#### Bed Interactions
- **"Poof" of soft nebula dust** - Gentle, magical
- **Gentle bell or shimmer** - Pleasant, ethereal

#### Eating Cosmic Berries
- **Subtle crunch + sparkle** - Light, magical
- **Not cartoon-chewy** - Keep it elegant

#### Crystal Nodes
- **Soft crystal resonance** - When approached
- **Bright chime** - When collected

#### Teleports
- **Reverse shimmer (swell)** - Entrance
- **Teleport burst** - Bell arpeggio + woosh

### 🎵 3.5 ABILITY / SPECIAL EFFECTS

#### ZERO G HOVER (default ability)
- **Low hum** - Gentle, continuous
- **Small airy wind loop** - Light, floating

#### GLOW EYES
- **Tiny resonance** - Subtle, magical
- **High-pitched shimmer** - Ethereal, sparkly

#### STAR TRAIL
- **Light twinkling sound** - Delicate, cosmic
- **Subtle bell twirls** - Melodic, magical

#### NEBULA AURA
- **Constant low pad + shimmer particles** - Atmospheric, ethereal

#### QUANTUM GLITCH (premium)
- **Soft glitch texture** - Mysterious, not harsh
- **Pitch-shifted sparkles** - Magical, otherworldly
- **Reverse-delay effect** - Ethereal, unique

### 🎵 3.6 UI SOUNDS

UI should be:
- Soft
- Responsive
- Slight glow

#### Button Click
- **Single bell ping** - Quick, pleasant
- **Quick decay** - Not lingering

#### Hover
- **Tiny shimmer** - Subtle, responsive

#### Menu Open
- **Soft swell** - Gentle, welcoming

#### Menu Close
- **Gentle reverse shimmer** - Smooth, elegant

#### Species Unlock
- **Ascending 3-tone chime** - Celebratory, magical

---

## 🔊 4. MIXING & VOLUME GUIDELINES

### 4.1 Global Volumes

| Category | Volume Range |
|----------|--------------|
| Ambience | 0.2 – 0.3 |
| Footsteps | 0.04 – 0.08 |
| UI | 0.1 – 0.15 |
| Emotes | 0.1 – 0.2 |
| Abilities | 0.1 – 0.2 |
| Teleports | 0.25 max |

### 4.2 No Harsh Transients

All sounds should have:
- **Slow attack** - Gentle onset
- **Softened transients** - No sharp peaks
- **No clicky waveforms** - Smooth, rounded

### 4.3 Reverb

Use sparingly, but:
- **Lunar Caverns**: Long reverb (spacious, echoing)
- **Void Temple**: Medium reverb (mysterious, atmospheric)
- **Outer Rim**: Airy reverb (cosmic, spacious)

### 4.4 No Dry Sounds

Every sound should have:
- Some softness
- Texture
- Spatial feel
- Never completely dry or flat

---

## 🛠️ 5. IMPLEMENTATION PLAN (Cursor-Friendly)

### Folder Structure

```
ReplicatedStorage/
    CosmoCatsSounds/
        Ambience/
        Footsteps/
        Emotes/
        Interactions/
        Abilities/
        UI/
```

### Cursor Can Generate:
- Sound folders
- Script hooks
- Region-based ambience transitions
- Footstep handlers
- UI sound controller

**Note:** When you're ready, exact scripts can be provided.

---

## 📚 6. AUDIO SOURCING PLAN

### Free / Legal Sources:
- **Freesound.org** - Check licenses carefully
- **Kenney Assets** - UI sounds
- **Zapsplat** - Various SFX
- **Mixkit** - Free audio library
- **Pixabay Audio** - Royalty-free sounds

### AI-Generated:
ChatGPT & Claude can help create sound descriptions, then use:
- **Stable Audio** - AI sound generation
- **Suno SFX mode** - AI sound effects
- **ElevenLabs Sound Effects** - AI-generated SFX

**Example Prompt:**
"Soft cosmic bell chime, airy, cute, 0.5s, subtle sparkle"

---

## ✅ 7. FINAL CHECKLIST (EVERY SOUND MUST PASS)

Before adding any sound, verify:

- [ ] **Does it sound magical / cosmic?** - Maintains ethereal quality
- [ ] **Is it soft and non-intrusive?** - Gentle, background-friendly
- [ ] **Is it friendly, cute, and atmospheric?** - Matches game tone
- [ ] **Does it avoid harsh clicks / metallicness?** - Smooth, rounded
- [ ] **Does it fit the emotional tone of the biome or action?** - Contextually appropriate

**If not — discard it.**

---

## 🎯 8. SOUND DESIGN PRINCIPLES

### Core Principles:
1. **Atmosphere First** - Sounds create mood, not just information
2. **Layering** - Combine multiple elements for richness
3. **Spatial Awareness** - Sounds should feel 3D and immersive
4. **Consistency** - All sounds follow the same philosophy
5. **Subtlety** - Less is more, avoid over-saturation

### Emotional Goals:
- **Wonder** - Magical, awe-inspiring
- **Tranquility** - Peaceful, relaxing
- **Mystery** - Intriguing, not scary
- **Beauty** - Elegant, refined
- **Cosmic** - Space-themed, ethereal

---

## 📋 9. SOUND CATEGORY SUMMARY

### Quick Reference:

| Category | Style | Volume | Reverb |
|----------|-------|--------|--------|
| Ambience | Soft pads, textures | 0.2-0.3 | Biome-specific |
| Footsteps | Very quiet, gentle | 0.04-0.08 | Minimal |
| Emotes | Soft, melodic | 0.1-0.2 | Light |
| Interactions | Bell tones, shimmer | 0.1-0.15 | Light |
| Abilities | Low hums, sparkles | 0.1-0.2 | Medium |
| UI | Bell pings, shimmer | 0.1-0.15 | None |

---

## 🔗 10. INTEGRATION WITH ASSET STYLE GUIDE

Audio should complement visual style:
- **Soft visuals** → Soft sounds
- **Glowing elements** → Shimmering sounds
- **Cosmic themes** → Space ambience
- **Bioluminescence** → Sparkle sounds
- **Ethereal atmosphere** → Airy textures

---

**Last Updated:** Cosmo Cats Audio & SFX Style Guide  
**Status:** Complete Sound Identity Bible ✅  
**Version:** 1.0
