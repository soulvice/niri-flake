# Niri Home-Manager Module Generator

An automated system to generate NixOS home-manager modules for the niri wayland compositor by parsing the niri Rust configuration structures.

## Overview

This project automatically generates a comprehensive home-manager module for [niri](https://github.com/soulvice/niri) by:

1. Fetching the latest niri source code from GitHub
2. Parsing Rust configuration structures using pure Nix
3. Converting Rust types to appropriate Nix option types
4. Generating validation rules and constraints
5. Creating KDL configuration file generators
6. Packaging everything as a home-manager module

## Features

- **Automatic synchronization**: Stays up-to-date with niri configuration changes
- **Comprehensive validation**: Type, range, enum, and cross-option validation
- **Complete coverage**: All 14 niri configuration files parsed for 100% option coverage
- **Pure Nix implementation**: No external dependencies
- **Auto-generated documentation**: Complete markdown wiki documentation of all options
- **GitHub Actions integration**: Automated updates when niri changes

## Structure

- `generator/` - Core Nix-based generator code
- `module/` - Generated home-manager module
- `.github/workflows/` - GitHub Actions for automation
- `examples/` - Example configurations
- `docs/` - Generated documentation and guides

## Usage

```nix
{
  programs.niri = {
    enable = true;
    settings = {
      input.keyboard.xkb = {
        layout = "us";
        variant = "";
      };
      input.keyboard.repeat-delay = 600;
      layout = {
        gaps = 16;
        center-focused-column = "never";
        focus-ring = {
          enable = true;
          active-color = "#7fc8ff";
        };
      };
      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "alacritty";
        "Mod+Q".action = close-window;
        "Mod+F".action = fullscreen-window;
      };
    };
  };
}
```

### Option Naming Convention

All option names use **kebab-case** (dash-separated) to provide a consistent, readable interface:

- `repeat-delay` instead of `repeat_delay`
- `focus-ring` instead of `focus_ring`
- `center-focused-column` instead of `center_focused_column`
- `window-rules` instead of `window_rules`

The generated KDL configuration automatically converts these back to the snake_case format that niri expects.

## Documentation

Comprehensive documentation is automatically generated from the niri source code:

```bash
# Generate the documentation
nix build .#niri-docs

# View the generated documentation
cat result  # or open in your browser/markdown viewer
```

The generated documentation includes:
- Complete option reference with types and descriptions
- Actions library documentation
- Custom type definitions and validation rules
- Configuration examples and troubleshooting guides

## Development

This module is automatically generated from the niri source code. Manual changes to the generated module will be overwritten during updates.

### Available Commands

```bash
# Generate the module
nix build .#niri-module

# Generate documentation
nix build .#niri-docs

# Run tests
./run-tests.sh

# Development environment
nix develop
```