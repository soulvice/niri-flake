# Niri Home-Manager Module Generator Architecture

This document describes the architecture and implementation details of the automated niri home-manager module generator.

## Overview

The system automatically generates a NixOS home-manager module for the niri Wayland compositor by parsing its Rust source code and converting configuration structures into Nix options with full type safety and validation.

## Architecture Components

### 1. Generator Core (`generator/`)

The generator consists of several modular components:

#### `parser.nix` - Rust Source Parser
- **Purpose**: Parse Rust source files to extract struct and enum definitions
- **Input**: Niri source code from GitHub (14 configuration files)
- **Output**: Structured representation of configuration types
- **Implementation**: Pure Nix using regex and string manipulation
- **Files Parsed**:
  - `lib.rs` - Main configuration structure
  - `input.rs` - Input device configuration
  - `output.rs` - Display/monitor configuration
  - `layout.rs` - Window layout settings
  - `animations.rs` - Animation parameters
  - `binds.rs` - Keyboard/mouse bindings
  - `gestures.rs` - Gesture configuration
  - `window_rule.rs` - Per-window rules
  - `layer_rule.rs` - Layer shell rules
  - `workspace.rs` - Workspace definitions
  - `recent_windows.rs` - MRU window switcher
  - `appearance.rs` - Colors, gradients, borders, shadows
  - `debug.rs` - Debug settings
  - `misc.rs` - Miscellaneous settings (cursor, screenshots, etc.)
  - `utils.rs` - Utility types (FloatOrInt, Flag, RegexEq)
- **Key Features**:
  - Parses `#[derive(Decode)]` structs
  - Extracts field names, types, and documentation
  - Handles knuffel attributes for KDL parsing
  - Supports nested struct relationships
  - Comprehensive coverage of all niri configuration types

#### `type-mapper.nix` - Type System Bridge
- **Purpose**: Convert Rust types to equivalent Nix types
- **Input**: Parsed Rust struct definitions
- **Output**: Nix type definitions with validation
- **Key Mappings**:
  - `bool` → `types.bool`
  - `String` → `types.str`
  - `u32`, `i32` → `types.int`
  - `f64` → `types.float`
  - `Vec<T>` → `types.listOf T`
  - `Option<T>` → `types.nullOr T`
  - `FloatOrInt<MIN, MAX>` → `types.numbers.between MIN MAX`
  - Custom enums → `types.enum [variants...]`

#### `validation.nix` - Type Validation System
- **Purpose**: Provide comprehensive validation for niri-specific types
- **Features**:
  - Color validation (hex, CSS names, rgb/rgba functions)
  - Numeric range validation
  - Regex pattern validation
  - Cross-option reference validation
  - Enum value validation
- **Custom Types**:
  - `colorType` - Validates color formats
  - `cornerRadiusType` - Validates corner radius values
  - `gradientType` - Complex gradient validation
  - Animation parameter types with constraints

#### `kdl-generator.nix` - Configuration File Generator
- **Purpose**: Convert Nix attribute sets to KDL (KDL Document Language) format
- **Input**: User configuration from Nix options
- **Output**: Valid KDL configuration file for niri
- **Features**:
  - Proper KDL syntax formatting
  - String escaping and quoting
  - Special handling for niri-specific sections (binds, window-rules, etc.)
  - Support for nested structures and lists

#### `module-generator.nix` - Home-Manager Module Builder
- **Purpose**: Generate the final home-manager module
- **Input**: Type mappings and KDL generator
- **Output**: Complete home-manager module with options and configuration
- **Features**:
  - Option definitions with descriptions and examples
  - Configuration file management
  - Actions library for keybindings
  - Environment variable setup
  - Validation assertions

### 2. Automation System

#### GitHub Actions Workflow (`.github/workflows/update-niri-module.yml`)
- **Trigger**: Daily schedule + manual dispatch
- **Process**:
  1. Check for niri repository updates
  2. Update flake.nix with new commit/sha256
  3. Regenerate the module using the updated source
  4. Run validation tests
  5. Commit and push changes
  6. Create releases for significant updates

#### Continuous Integration Features
- **Update Detection**: Monitors niri repository for changes
- **Automatic Regeneration**: Updates module when niri config changes
- **Validation**: Ensures generated module is valid
- **Versioning**: Tags releases with niri commit information

### 3. Module Structure

#### Generated Module Features
- **Type-Safe Options**: All options have proper Nix types with validation
- **Documentation**: Extracted from Rust doc comments
- **Default Values**: Inherited from Rust `Default` implementations
- **Actions Library**: Convenient keybinding actions
- **Configuration Management**: Automatic KDL file generation
- **Environment Setup**: Required environment variables for Wayland

#### Option Hierarchy
```
programs.niri
├── enable: boolean
├── package: package
├── settings: attrset
│   ├── input: attrset
│   │   ├── keyboard: attrset
│   │   ├── touchpad: attrset
│   │   ├── mouse: attrset
│   │   └── ...
│   ├── layout: attrset
│   ├── animations: attrset
│   ├── binds: attrset
│   ├── outputs: listOf attrset
│   ├── window_rules: listOf attrset
│   └── ...
└── finalConfigFile: path (read-only)
```

## Data Flow

1. **Source Fetching**: Nix fetches latest niri source from GitHub
2. **Parsing**: Parser extracts struct definitions from Rust files
3. **Type Mapping**: Rust types converted to Nix types with validation
4. **Module Generation**: Complete home-manager module created
5. **User Configuration**: User provides configuration via Nix options
6. **Validation**: Comprehensive validation of user input
7. **KDL Generation**: Configuration converted to KDL format
8. **File Management**: KDL file placed in correct location

## Key Design Decisions

### Pure Nix Implementation
- **Rationale**: No external dependencies, works anywhere Nix works
- **Benefits**: Reproducible, cacheable, no build-time dependencies
- **Trade-offs**: More complex parsing logic, limited by Nix capabilities

### Two-Phase Parsing
- **Phase 1**: Extract structure from Rust code
- **Phase 2**: Convert to Nix types with validation
- **Benefits**: Modular, testable, maintainable

### Comprehensive Validation
- **Type-level**: Using Nix's type system
- **Range-level**: Custom validation functions
- **Cross-option**: Validate references between options
- **Benefits**: Catches errors early, provides good error messages

### Automatic Updates
- **GitHub Actions**: Monitor source repository
- **Incremental**: Only update when changes detected
- **Tested**: Validation before deployment

## Extension Points

### Adding New Types
1. Add parsing logic to `parser.nix`
2. Add type mapping to `type-mapper.nix`
3. Add validation if needed to `validation.nix`
4. Add KDL formatting if needed to `kdl-generator.nix`

### Custom Validation
- Add validation functions to `validation.nix`
- Use `types.addCheck` for type-level validation
- Add cross-validation to module assertions

### KDL Formatting
- Add special cases to `kdl-generator.nix`
- Handle complex niri-specific syntax
- Maintain proper escaping and formatting

## Testing Strategy

### Unit Testing
- Individual component testing in `test.nix`
- Mock data for isolated testing
- Pure function testing

### Integration Testing
- Full pipeline testing
- Real configuration examples
- Module evaluation testing

### Validation Testing
- Type validation testing
- Error condition testing
- Edge case handling

## Performance Considerations

### Parsing Performance
- Regex-based parsing for speed
- Incremental parsing for large files
- Caching of parsed results

### Generation Performance
- Lazy evaluation where possible
- Minimal rebuilds
- Efficient type checking

### Runtime Performance
- Fast module evaluation
- Efficient KDL generation
- Minimal home-manager rebuild impact

## Future Enhancements

### Possible Improvements
1. **AST-based Parsing**: More robust than regex-based parsing
2. **Incremental Updates**: Only regenerate changed parts
3. **Custom Validation DSL**: Domain-specific validation language
4. **IDE Support**: LSP for niri configuration in Nix
5. **Migration Tools**: Automatic config migration between niri versions

### Extensibility
- Plugin system for custom types
- User-defined validation rules
- Custom KDL formatting options
- Integration with other Wayland compositors

## Maintenance

### Regular Tasks
- Monitor niri development for breaking changes
- Update GitHub Actions for security
- Review and update documentation
- Test with new NixOS/home-manager versions

### Version Management
- Tag releases with niri version info
- Maintain compatibility with multiple niri versions
- Provide migration guides for breaking changes