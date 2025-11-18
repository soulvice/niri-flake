# Niri Home-Manager Module Documentation

<!-- Generated on $(date -u +'%Y-%m-%d %H:%M:%S UTC') -->

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Module Options](#module-options)
- [Actions Library](#actions-library)
- [Custom Types](#custom-types)
- [Enums](#enums)
- [Validation](#validation)
- [Configuration Examples](#configuration-examples)
- [Troubleshooting](#troubleshooting)


## Overview

The niri home-manager module provides comprehensive, type-safe configuration for the niri Wayland compositor. This module is automatically generated from the niri source code to ensure complete coverage of all configuration options and maintain synchronization with niri development.

### Key Features

- **Type Safety**: All configuration options are strongly typed with comprehensive validation
- **Auto-Generated**: Automatically updated when niri configuration changes
- **Complete Coverage**: All niri configuration options supported
- **Documentation**: Rich documentation extracted from niri source code
- **Actions Library**: Convenient helpers for keybindings and window management
- **Validation**: Build-time validation prevents runtime configuration errors


## Installation

### Using Flakes

Add the niri flake to your system configuration:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    niri-flake.url = "github:your-username/niri-flake";
  };

  outputs = { nixpkgs, home-manager, niri-flake, ... }: {
    homeConfigurations.youruser = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        niri-flake.homeManagerModules.niri
        ./home.nix
      ];
    };
  };
}
```

### In Your Home Configuration

```nix
# home.nix
{
  programs.niri = {
    enable = true;
    settings = {
      # Your niri configuration here
    };
  };
}
```


## Module Options

Complete module options documentation will be generated from the actual niri configuration structures when the module is built with real niri source code.

### Core Options

#### `programs.niri.enable`
**Type:** boolean
**Default:** `false`

Whether to enable niri, a scrollable-tiling Wayland compositor.

#### `programs.niri.package`
**Type:** package
**Default:** `pkgs.niri`

The niri package to use.

#### `programs.niri.settings`
**Type:** attribute set
**Default:** `{}`

Niri configuration settings. This is where all niri configuration options are specified.

#### `programs.niri.finalConfigFile`
**Type:** path (read-only)

The generated KDL configuration file path. This file is automatically created from your Nix configuration.


## Actions Library

The niri module provides a convenient actions library accessible via `config.lib.niri.actions`. These actions can be used in keybindings to perform various operations.

### Usage in Bindings

```nix
binds = with config.lib.niri.actions; {
  "Mod+Return".action = spawn "alacritty";
  "Mod+Q".action = close_window;
  "Mod+F".action = fullscreen_window;
};
```

### Available Actions

### `close_window`

Close the focused window

**Usage:** `close_window`


### `focus_down`

Focus window below

**Usage:** `focus_down`


### `focus_left`

Focus window to the left

**Usage:** `focus_left`


### `focus_right`

Focus window to the right

**Usage:** `focus_right`


### `focus_up`

Focus window above

**Usage:** `focus_up`


### `focus_workspace_next`

Focus next workspace

**Usage:** `focus_workspace_next`


### `focus_workspace_previous`

Focus previous workspace

**Usage:** `focus_workspace_previous`


### `fullscreen_window`

Toggle window fullscreen

**Usage:** `fullscreen_window`


### `move_down`

Move window down

**Usage:** `move_down`


### `move_left`

Move window left

**Usage:** `move_left`


### `move_right`

Move window right

**Usage:** `move_right`


### `move_up`

Move window up

**Usage:** `move_up`


### `quit`

Quit niri

**Usage:** `quit`


### `screenshot`

Take a screenshot

**Usage:** `screenshot`


### `spawn`

Execute a command

**Usage:** `spawn "command"`


### `spawn_shell`

Execute a shell command

**Usage:** `spawn_shell "shell command"`



## Custom Types

The niri module defines several custom types for type-safe configuration:

### Color

Color value in various formats

**Examples:**
`#ff0000`  
`#rgb`  
`red`  
`rgb(255, 0, 0)`  
`rgba(255, 0, 0, 0.5)`


### Gradient

Color gradient definition

**Examples:**
```nix
{
  from = "#ff0000";
  to = "#0000ff";
  angle = 45;
  relative_to = "window";
  color_space = "srgb";
}
```


### Corner Radius

Border radius - single value or per-corner

**Examples:**
`12` (all corners)  
`[8, 12, 8, 12]` (top-left, top-right, bottom-right, bottom-left)


### Preset Size

Size specification as proportion or fixed pixels

**Examples:**
`{ proportion = 0.5; }` (50% of available space)  
`{ fixed = 1920; }` (1920 pixels)



## Enums

Many options accept only specific predefined values:

### Modifier Keys

Keyboard modifier keys for keybindings

**Valid values:** `ctrl`, `shift`, `alt`, `super`, `iso-level3-shift`, `iso-level5-shift`


### Transform

Output transformation/rotation

**Valid values:** `normal`, `90`, `180`, `270`, `flipped`, `flipped-90`, `flipped-180`, `flipped-270`


### Center Focused Column

When to center the focused column

**Valid values:** `never`, `always`, `on-overflow`


### Acceleration Profile

Mouse/touchpad acceleration profile

**Valid values:** `adaptive`, `flat`


### Click Method

Touchpad click method

**Valid values:** `clickfinger`, `button-areas`


### Scroll Method

Touchpad scroll method

**Valid values:** `no-scroll`, `two-finger`, `edge`, `on-button-down`



## Validation

The niri module provides comprehensive validation to catch configuration errors at build time:

### Type Validation
- All options have strongly-typed Nix types
- Invalid types are caught during evaluation
- Clear error messages guide users to correct issues

### Range Validation
- Numeric values are validated against valid ranges
- Examples: gaps must be non-negative, repeat rates have valid bounds

### Enum Validation
- Only valid enum values are accepted
- Unknown enum values result in build errors

### Cross-Option Validation
- References between options are validated
- Example: window rules referencing non-existent outputs or workspaces
- Prevents runtime configuration errors

### Format Validation
- Colors must be valid hex, CSS names, or RGB functions
- Regular expressions are validated for syntax
- File paths and other format-specific values are checked


## Configuration Examples

### Basic Setup

```nix
programs.niri = {
  enable = true;
  settings = {
    input = {
      keyboard = {
        xkb = {
          layout = "us";
          variant = "";
        };
        repeat-delay = 600;
        repeat-rate = 25;
      };
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
    };

    layout = {
      gaps = 16;
      focus-ring = {
        enable = true;
        width = 4;
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
```

### Advanced Multi-Monitor Setup

```nix
programs.niri.settings = {
  outputs = [
    {
      name = "eDP-1";
      scale = 1.25;
      position = { x = 0; y = 0; };
      mode = {
        width = 2560;
        height = 1600;
        refresh_rate = 165.0;
      };
    }
    {
      name = "DP-1";
      scale = 1.0;
      position = { x = 2560; y = 0; };
      mode = {
        width = 3440;
        height = 1440;
        refresh-rate = 144.0;
      };
    }
  ];

  window-rules = [
    {
      matches = [{ app-id = "firefox"; }];
      open-on-output = "DP-1";
      open-on-workspace = "browser";
    }
    {
      matches = [{ app-id = "Alacritty"; }];
      open-on-output = "eDP-1";
    }
  ];
};
```

### Animation Configuration

```nix
programs.niri.settings.animations = {
  slowdown = 0.8;

  workspace-switch = {
    spring = {
      damping-ratio = 1.2;
      stiffness = 800.0;
      epsilon = 0.0001;
    };
  };

  window-open = {
    easing = {
      duration-ms = 200;
      curve = "ease-out-expo";
    };
  };
};
```


## Troubleshooting

### Common Issues

#### Validation Errors
If you encounter validation errors:
1. Check that enum values match exactly (case-sensitive)
2. Ensure numeric values are within valid ranges
3. Verify color formats are valid (hex, CSS names, or RGB functions)
4. Confirm all required fields are provided

#### Missing Options
If an option seems to be missing:
1. Check if it's a new niri feature not yet in the generator
2. Verify the option name matches the niri documentation exactly
3. Update your flake to get the latest generated module

#### KDL Generation Issues
If the generated KDL configuration doesn't work:
1. Check the generated file at `~/.config/niri/config.kdl`
2. Verify string values don't contain unescaped special characters
3. Ensure boolean values are `true`/`false`, not strings

### Getting Help

1. Check the [niri documentation](https://github.com/YaLTeR/niri/wiki)
2. Review the generated KDL file for syntax issues
3. File issues on the niri-flake repository for module-specific problems
4. Join the niri community for general compositor questions

### Debugging

To debug configuration issues:

```bash
# Check the generated configuration
cat ~/.config/niri/config.kdl

# Validate niri can parse the configuration
niri validate

# Run niri with verbose logging
RUST_LOG=niri=debug niri
```


---

*This documentation is automatically generated from the niri source code. For the most up-to-date information, please refer to the [niri project](https://github.com/YaLTeR/niri).*

---

**Generation Info:**
- Generated on: 2025-11-18 23:29:39 UTC
- Niri commit: [dfcbbbb03071cadf3fd9bbb0903ead364a839412](https://github.com/soulvice/niri/commit/dfcbbbb03071cadf3fd9bbb0903ead364a839412)
- Module version: 20251118

