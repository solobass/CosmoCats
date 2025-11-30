# Tests

Automated tests for Cosmo Cats game systems.

**Used by Cursor for automated unit/static tests.**

## Structure

```
tests/
├── unit/                # Unit tests for modules
│   ├── test_species_controller.lua
│   └── test_currency_controller.lua
│
├── integration/         # Integration tests for systems
└── validation/          # Model/asset validation tests
```

## Usage

Cursor can generate automated tests for:
- Module functionality
- System integration
- Model validation
- Asset validation

## Test Types

- **Unit Tests**: Test individual modules in isolation
  - Example: `test_species_controller.lua`
  - Example: `test_currency_controller.lua`
- **Integration Tests**: Test system interactions
- **Validation Tests**: Validate models, animations, textures

## Running Tests

Tests can be run via:
- Roblox Studio test framework
- Automated CI/CD pipeline
- Manual validation scripts

