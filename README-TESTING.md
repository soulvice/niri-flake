# Testing the Niri Home-Manager Module Generator

This document provides comprehensive instructions for testing the niri home-manager module generator in various scenarios.

## Quick Start

The generator includes several testing methods depending on your needs and network availability:

### 🚀 Full Network Test (Recommended)

```bash
# Generate module and docs from real niri source
./test-generator.sh
```

This script:
1. ✅ Tests flake evaluation
2. 🔄 Fetches real niri source from GitHub
3. 🏗️ Generates complete home-manager module
4. 📚 Generates comprehensive documentation
5. 🧪 Tests complex configuration scenarios
6. 📊 Provides detailed analysis and statistics

**Note:** Currently requires fixing the niri source commit in `flake.nix` due to placeholder values.

### 🔧 Local Component Test

```bash
# Test individual components without network
./test-without-network.sh
```

This script:
- ✅ Tests parser logic with mock niri source
- ✅ Tests type mapping functionality
- ✅ Tests documentation generation
- ✅ Tests module generation components
- ✅ Validates configuration examples syntax

### 📖 Documentation Viewer

```bash
# Interactive documentation browser
./view-docs.sh

# Or quick views:
./view-docs.sh --stats    # Show doc statistics
./view-docs.sh --toc      # Show table of contents
./view-docs.sh --search term  # Search documentation
./view-docs.sh --html     # Convert to HTML
```

## Test Structure Overview

### Generated Test Files

```
test-results/                 # Full network test results
├── niri-module/             # Generated home-manager module
├── niri-docs                # Generated markdown documentation
├── test-config.nix          # Complex configuration test
├── flake-check.log          # Flake evaluation results
├── module-build.log         # Module generation logs
└── docs-build.log           # Documentation generation logs

test-results-local/           # Local component test results
├── mock-niri/               # Mock niri source structure
├── parser-test.out          # Parser component test
├── type-mapper-test.out     # Type mapping test
├── test-docs                # Sample documentation
└── *.log                    # Component test logs
```

### Configuration Examples

The generator includes comprehensive test configurations:

#### `test/complex-config-examples.nix`
- **Gaming Setup**: Multi-monitor, high-refresh rate, optimized for gaming
- **Development Setup**: IDE-friendly layout, multiple workspaces, dev tools
- **Streaming Setup**: Content creation workflow, OBS integration, multi-output

#### `examples/basic-config.nix`
- Simple starter configuration
- Common keybindings
- Basic input/output setup

#### `examples/advanced-config.nix`
- Complete feature showcase
- Advanced animations and effects
- Complex window rules and workspace management

## Manual Testing Approaches

### 1. Test Individual Components

```bash
# Enter Nix REPL to explore generator
nix repl flake.nix

# Available components:
# lib.niri-generator.parser        # Rust source parser
# lib.niri-generator.typeMapper    # Type mapping system
# lib.niri-generator.kdlGenerator  # KDL configuration generator
# lib.niri-generator.moduleGenerator  # Home-manager module generator
# lib.niri-generator.docsGenerator    # Documentation generator
```

### 2. Test Parser with Real Niri Source

```bash
# Parse actual niri repository (requires network)
nix-instantiate --eval --expr '
  let
    pkgs = import <nixpkgs> {};
    src = pkgs.fetchFromGitHub {
      owner = "soulvice";
      repo = "niri";
      rev = "RECENT_COMMIT_SHA";  # Use actual commit
      sha256 = "COMPUTED_SHA256";   # Use actual sha256
    };
    generator = (import ./flake.nix).lib.niri-generator;
    result = generator.parser.parseNiriConfig src;
  in
  result
'
```

### 3. Test Documentation Generation

```bash
# Generate docs with custom types
nix-build --expr '
  let
    pkgs = import <nixpkgs> {};
    generator = (import ./flake.nix).lib.niri-generator;

    # Define your test types
    testTypes = {
      Config = {
        type = "struct";
        fields = {
          input = { type = "Input"; docs = ["Input device configuration"]; };
          layout = { type = "Layout"; docs = ["Window layout settings"]; };
        };
      };
    };

    docs = generator.generateDocs {
      nixTypes = testTypes;
      actionsLib = { spawn = "spawn"; quit = "quit"; };
    };
  in
  pkgs.writeText "custom-docs.md" docs
'
```

### 4. Test Module Generation

```bash
# Generate a test module
nix-build --expr '
  let
    pkgs = import <nixpkgs> {};
    generator = (import ./flake.nix).lib.niri-generator;

    # Mock some types for testing
    nixTypes = {
      Config = {
        type = "struct";
        fields = {
          enable = {
            type = "bool";
            nixType = pkgs.lib.types.bool;
            docs = ["Enable niri compositor"];
          };
        };
      };
    };

    module = generator.moduleGenerator.generateModule {
      inherit nixTypes;
      kdlGenerator = generator.kdlGenerator;
    };
  in
  pkgs.writeText "test-module.nix" (builtins.toJSON module)
'
```

## Testing with Home-Manager

### 1. Local Testing

```bash
# Copy generated module to home-manager config
cp -r ./test-results/niri-module ~/.config/nixpkgs/modules/

# Add to home.nix:
# imports = [ ./modules/niri-module ];
```

### 2. Configuration Validation

```bash
# Test your niri configuration
home-manager build --flake . -v

# Test specific configuration file
nix-instantiate --eval --expr '
  let
    config = import ./your-niri-config.nix;
  in
  config.programs.niri.settings
'
```

### 3. KDL Output Validation

```bash
# Check generated KDL configuration
home-manager build
cat ~/.config/niri/config.kdl

# Validate KDL syntax (if you have niri installed)
niri validate ~/.config/niri/config.kdl
```

## Troubleshooting

### Common Issues

#### 1. Network Errors
```
❌ Unable to download from GitHub
```
**Solution:** Check network connectivity, or use local testing mode

#### 2. SHA256 Mismatches
```
❌ Hash mismatch for fetched source
```
**Solution:** Update the rev/sha256 in flake.nix with actual values

#### 3. Parser Errors
```
❌ Failed to parse Rust source
```
**Solution:** Ensure niri source has expected file structure, check parser regex patterns

#### 4. Module Evaluation Errors
```
❌ Failed to evaluate generated module
```
**Solution:** Check module syntax, ensure all required Nix functions are available

### Debug Mode

Enable verbose output for debugging:

```bash
# Debug flake evaluation
nix flake check --verbose

# Debug build with full trace
nix build .#niri-module --verbose --show-trace

# Debug parser with specific file
nix-instantiate --eval --expr '
  let parser = (import ./flake.nix).lib.niri-generator.parser;
  in parser.parseRustFile "test.rs" (builtins.readFile ./test.rs)
' --show-trace
```

### Performance Testing

```bash
# Time full generation process
time nix build .#niri-module

# Memory usage monitoring
nix build .#niri-module --option system-features benchmark

# Profile Nix evaluation
nix-instantiate --eval --expr '...' --option allow-unsafe-native-code-during-evaluation true
```

## CI/CD Testing

The project includes GitHub Actions for automated testing:

- **Daily updates**: Checks for niri changes and regenerates module
- **PR validation**: Tests all components on pull requests
- **Release automation**: Creates releases with generated modules

### Local CI Testing

```bash
# Test the same checks CI runs
nix flake check --all-systems
nix build .#niri-module
nix build .#niri-docs

# Lint and format
nixfmt-rfc-style *.nix generator/*.nix
statix check .
deadnix .
```

## Integration Testing

### With Real Home-Manager

```bash
# Test in a VM or container
nixos-rebuild switch --flake .

# Test with home-manager standalone
home-manager switch --flake .
```

### With Real Niri

```bash
# Install and test niri
nix shell nixpkgs#niri

# Test configuration loading
niri validate ~/.config/niri/config.kdl

# Test compositor startup
niri --help
```

## Contributing Test Cases

When contributing new features, ensure:

1. **Add test cases** to `test/complex-config-examples.nix`
2. **Update parser** if adding new Rust structure support
3. **Add documentation** examples for new options
4. **Test backwards compatibility** with existing configs
5. **Update this testing guide** with new testing procedures

## Test Coverage Goals

- ✅ **Parser**: All 14 niri configuration files covered
- ✅ **Type Mapping**: Complete Rust → Nix type coverage
- ✅ **Validation**: Comprehensive input validation
- ✅ **KDL Generation**: Proper output formatting
- ✅ **Documentation**: Auto-generated complete reference
- ✅ **Integration**: Home-manager compatibility
- ⏳ **Performance**: Large configuration handling
- ⏳ **Error Handling**: Graceful failure modes

---

## Quick Commands Reference

```bash
# Full test suite
./test-generator.sh

# Local component testing
./test-without-network.sh

# View documentation
./view-docs.sh

# Manual builds
nix build .#niri-module
nix build .#niri-docs

# Development shell
nix develop

# Flake commands
nix flake check
nix flake update
```

For more information, see the main [README.md](./README.md) and [ARCHITECTURE.md](./docs/ARCHITECTURE.md).