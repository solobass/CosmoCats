# Studio Project

This folder contains all Roblox Studio files and mirrors the Roblox Explorer window exactly.

## Structure

```
studio-project/
└── src/                   # Mirrors Roblox Studio Explorer
    ├── ReplicatedStorage/
    ├── StarterPlayer/
    ├── StarterGui/
    ├── ServerScriptService/
    ├── ServerStorage/
    ├── Workspace/
    └── Lighting/
```

## Usage

- **Cursor** will create matching scripts inside these folders
- **Rojo** syncs these files to Roblox Studio
- Only `.lua` and `.rbxm` files are synced to GitHub (not `.rbxl` binary)

## Why This Works

- Cursor can generate real Roblox code
- You sync only `.lua` and `.rbxm` files to GitHub
- Not the `.rbxl` binary file
- Clean, version-controlled codebase


