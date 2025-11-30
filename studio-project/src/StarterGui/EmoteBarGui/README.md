# Emote Bar GUI

Let players express themselves with animations.

## Structure

```
EmoteBarGui/
   EmoteBarScreenGui (ScreenGui)
      └── Frame_EmoteButtons
            ├── EmoteButton_Template
            ├── Emote1 (SIT)
            ├── Emote2 (LAY)
            ├── Emote3 (LOAF)
            ├── Emote4 (GROOM)
            ├── Emote5 (MEOW)
            ├── Emote6 (TAIL_FLICK)
            ├── Emote7 (ROLL)
            ├── Emote8 (STRETCH)
            └── Emote9 (CUSTOM)
   Scripts/
     └── EmoteBar.client.lua
```

## Wireframe

```
 -----------------------------------------------------------
| SIT | LAY | LOAF | GROOM | MEOW | TAIL | ROLL | STRETCH |
 -----------------------------------------------------------
```

## Behavior

- **Each button** → Calls `EmoteController.PlayEmote(emoteId)`
- **Number keys 1–9** → Map to the first 9 emotes
- **Buttons show emote icons** → Visual representation

## Emote IDs

- SIT
- LAY
- LOAF
- GROOM
- MEOW
- TAIL_FLICK
- ROLL
- STRETCH

## Script

See `Scripts/EmoteBar.client.lua` for implementation.


