# Niri Home-Manager Module Usage Guide

This guide explains how to use the automatically generated niri home-manager module.

## Installation

### Using Flakes (Recommended)

Add this flake as an input to your system flake:

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
        {
          programs.niri.enable = true;
          # Your niri configuration here
        }
      ];
    };
  };
}
```

### Traditional Import

If you're not using flakes, you can import the module directly:

```nix
{ pkgs, ... }:

let
  niri-flake = builtins.fetchGit {
    url = "https://github.com/your-username/niri-flake";
    rev = "main"; # or specific commit
  };
in
{
  imports = [ "${niri-flake}/module/niri.nix" ];

  programs.niri.enable = true;
  # Your configuration here
}
```

## Basic Configuration

The simplest configuration to get niri running:

```nix
{
  programs.niri = {
    enable = true;
    settings = {
      # Minimal required configuration
      binds = {
        "Mod+Return" = { action = "spawn alacritty"; };
        "Mod+Q" = { action = "close-window"; };
        "Mod+Shift+E" = { action = "quit"; };
      };
    };
  };
}
```

## Configuration Structure

The module follows niri's exact configuration structure. Each Rust struct field becomes a Nix option:

```nix
programs.niri.settings = {
  # Corresponds to niri's Config struct
  input = {
    # Corresponds to Input struct
    keyboard = {
      # Corresponds to Keyboard struct
      xkb = {
        layout = "us";
        variant = "";
      };
      repeat_delay = 600;
      repeat_rate = 25;
    };
  };

  layout = {
    # Corresponds to Layout struct
    gaps = 16;
    focus_ring = {
      enable = true;
      width = 4;
      active_color = "#7fc8ff";
    };
  };

  # ... rest of configuration
};
```

## Key Bindings

The module provides a convenient actions library for key bindings:

```nix
{ config, ... }: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Window management
    "Mod+Return".action = spawn "alacritty";
    "Mod+Q".action = close_window;
    "Mod+F".action = fullscreen_window;

    # Focus movement
    "Mod+Left".action = focus_left;
    "Mod+Right".action = focus_right;

    # Custom commands
    "Mod+D".action = spawn "wofi --show drun";
    "Print".action = screenshot;
  };
}
```

Available actions include:
- `spawn "command"` - Run a command
- `spawn_shell "command"` - Run a shell command
- `close_window` - Close focused window
- `fullscreen_window` - Toggle fullscreen
- `focus_left/right/up/down` - Focus movement
- `move_left/right/up/down` - Move window
- `focus_workspace_next/previous` - Workspace navigation
- `screenshot` - Take screenshot
- `quit` - Exit niri

## Type Safety and Validation

The module provides comprehensive type checking and validation:

### Colors
```nix
# Valid color formats
focus_ring.active_color = "#ff0000";        # Hex
focus_ring.active_color = "red";            # CSS name
focus_ring.active_color = "rgb(255, 0, 0)"; # RGB function
```

### Numeric Ranges
```nix
# Automatically validated ranges
layout.gaps = 16;           # Must be non-negative
animations.slowdown = 1.5;  # Must be positive
input.keyboard.repeat_rate = 25; # Must be within valid range
```

### Enums
```nix
# Only valid enum values accepted
input.touchpad.accel_profile = "adaptive"; # or "flat"
layout.center_focused_column = "never";    # or "always", "on-overflow"
```

## Advanced Features

### Multiple Outputs
```nix
outputs = [
  {
    name = "eDP-1";
    scale = 1.25;
    mode = { width = 2560; height = 1600; refresh_rate = 165.0; };
  }
  {
    name = "DP-1";
    scale = 1.0;
    position = { x = 2560; y = 0; };
  }
];
```

### Window Rules
```nix
window_rules = [
  {
    matches = [{ app_id = "firefox"; }];
    open_on_workspace = "browser";
    default_column_width = { proportion = 0.75; };
  }
  {
    matches = [{ title = "Picture-in-Picture"; }];
    open_floating = true;
    geometry_corner_radius = 12.0;
  }
];
```

### Animations
```nix
animations = {
  slowdown = 0.8;

  workspace_switch = {
    spring = {
      damping_ratio = 1.2;
      stiffness = 800.0;
      epsilon = 0.0001;
    };
  };

  window_open = {
    easing = {
      duration_ms = 200;
      curve = "ease-out-expo";
    };
  };
};
```

## Configuration File Generation

The module automatically generates a proper KDL configuration file at `~/.config/niri/config.kdl`. You can access the generated file path:

```nix
# Reference the generated config file
home.file."backup-niri-config".source = config.programs.niri.finalConfigFile;
```

## Troubleshooting

### Validation Errors
If you get validation errors, check:
1. Enum values match exactly (case-sensitive)
2. Numeric values are within valid ranges
3. Colors use valid formats
4. Required fields are provided

### KDL Generation Issues
The module converts Nix attribute sets to KDL format. If you encounter issues:
1. Check that string values don't contain unescaped quotes
2. Ensure boolean values are true/false, not "true"/"false"
3. Verify numeric values are not strings

### Missing Options
If an option is missing:
1. Check if it's a new niri feature not yet in the generator
2. Verify the option name matches the Rust struct field exactly
3. File an issue for missing options

## Examples

See the `examples/` directory for complete configuration examples:
- `basic-config.nix` - Minimal setup
- `advanced-config.nix` - Comprehensive configuration with all features

## Updates

The module is automatically updated when the niri source code changes. To get updates:

```bash
# If using flakes
nix flake update

# If using traditional import, update the rev/sha256 in your import
```

## Contributing

This module is automatically generated. To contribute:
1. File issues for missing features or bugs
2. Submit PRs to improve the generator logic
3. Add example configurations

The generator source is in the `generator/` directory and uses pure Nix to parse the niri Rust source code.