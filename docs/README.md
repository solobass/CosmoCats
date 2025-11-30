# Documentation

Game design documentation for Cosmo Cats.

**Purpose:** Storage for game design documents, species sheets, pattern library references, animation timelines, UI wireframes, and roadmaps.

## Structure

```
docs/
├── DESIGN_OVERVIEW.md
├── SPECIES_SPECS.md
├── 3D_PIPELINE.md
├── 📁 species/              # Species documentation
├── 📁 pipeline/             # Pipeline documentation
│   └── CHARACTER_PIPELINE.md
├── 📁 ui/                   # UI documentation
│   └── UI_WIREFRAMES/
├── 📁 MAP_LAYOUTS/          # Map layouts
└── 📁 prompts/              # Cursor prompts for code generation
```

## Usage with Claude Code Pro

Claude Code Pro excels at:
- **"Update SPECIES_SPECS.md for the new Nebula Tiger."**
- Maintaining documentation consistency
- Generating technical specs automatically
- Reviewing and updating design docs

## Documentation Types

- **Game Design Documents** - Overall game design and vision
- **Species Sheets** - Individual species specifications
- **Pattern Library References** - Pattern documentation
- **Animation Timelines** - Animation planning and specs
- **UI Wireframes** - User interface designs
- **Roadmaps** - Development roadmaps and milestones

## Cursor Prompts

The `prompts/` folder contains curated prompts for Cursor to generate:
- New controllers
- Modules
- UI systems
- Test files

Use these prompts in Cursor to automatically generate code following the project structure.
