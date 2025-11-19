# Niri Home-Manager Module Documentation

<!-- Generated at build time -->

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Complete Module Options Reference](#complete-module-options-reference)
- [Actions Library Reference](#actions-library-reference)
- [Configuration Examples](#configuration-examples)
- [Type Reference](#type-reference)
- [Validation](#validation)
- [Advanced Usage](#advanced-usage)
- [Niri Version Information](#niri-version-information)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)


## Overview

The **niri-flake** provides a comprehensive, type-safe home-manager module for configuring the [niri Wayland compositor](https://github.com/YaLTeR/niri). This module is automatically generated from niri's source code to ensure complete coverage and accuracy.

### Key Features

- 🔒 **Type Safety** - Comprehensive validation catches errors at build time
- 🎯 **Complete Coverage** - All 87 niri actions available
- 🔄 **Auto-Generated** - Always up-to-date with niri development
- 📖 **Rich Documentation** - Detailed descriptions and examples
- 🎨 **Flexible** - Structured Nix + raw KDL support
- ⚡ **Performance** - Build-time validation prevents runtime errors

### Architecture

```
Your Nix Config → Type Validation → KDL Generation → ~/.config/niri/config.kdl → niri
```

The module validates your configuration during system build, converts it to niri's native KDL format, and deploys it automatically.


## Installation

### Prerequisites

- NixOS or Home Manager
- Nix Flakes enabled

### Adding to Your Flake

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:your-username/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, niri-flake, ... }: {
    homeConfigurations.yourusername = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        niri-flake.homeManagerModules.niri
        ./home.nix
      ];
    };
  };
}
```

### Basic Configuration

```nix
# home.nix
{ config, ... }:
{
  programs.niri = {
    enable = true;
    settings = {
      # Your niri configuration here
    };
  };
}
```


## Quick Start

Here's a minimal working configuration to get you started:

```nix
programs.niri = {
  enable = true;
  settings = {
    input = {
      keyboard.xkb.layout = "us";
      touchpad = {
        tap = true;
        natural_scroll = true;
      };
    };

    layout = {
      gaps = 16;
      focus_ring = {
        enable = true;
        width = 4;
        active_color = "#7fc8ff";
      };
    };

    binds = with config.lib.niri.actions; {
      # Applications
      "Mod+Return".action = spawn "alacritty";
      "Mod+D".action = spawn "wofi --show drun";

      # Window management
      "Mod+Q".action = close_window;
      "Mod+F".action = fullscreen_window;

      # Navigation
      "Mod+H".action = focus_column_left;
      "Mod+L".action = focus_column_right;
      "Mod+J".action = focus_window_down;
      "Mod+K".action = focus_window_up;

      # Workspaces
      "Mod+1".action = focus_workspace 1;
      "Mod+2".action = focus_workspace 2;

      # System
      "Print".action = screenshot;
      "Mod+Shift+E".action = quit;
    };

    outputs = [
      {
        name = "eDP-1";
        scale = 1.25;
        mode = {
          width = 1920;
          height = 1080;
          refresh_rate = 60.0;
        };
      }
    ];
  };
};
```


## Complete Module Options Reference

This section documents all available configuration options for the niri home-manager module. Options are organized hierarchically and include type information, default values, and descriptions.

### Notation

- `programs.niri.settings.layout.gaps` - Direct option path
- `programs.niri.settings.outputs.*.name` - List items (replace `*` with index)
- `programs.niri.settings.binds.<name>.action` - Named attribute sets (replace `<name>` with key)
- `programs.niri.settings.window-rules.*.matches.*.title` - Nested list items

### Core Options

## `programs.niri.enable`

**Type:** boolean
**Default:** `false`**Example:** `true` or `false`

Whether to enable niri, a scrollable-tiling Wayland compositor.


## `programs.niri.extraConfig`

**Type:** strings concatenated with "\n"
**Default:** `""` (empty string)

Additional KDL configuration not covered by structured options


## `programs.niri.finalConfigFile`

**Type:** path
**Default:** `null`

Generated KDL configuration file (read-only)


## `programs.niri.package`

**Type:** package
**Default:** `"pkgs.niri"`

The niri package to use.


## `programs.niri.settings`

**Type:** submodule
**Default:** `{}` (empty attribute set)

Niri configuration settings



## Actions Library

The niri module provides a comprehensive actions library accessible via `config.lib.niri.actions`. These actions provide type-safe access to all niri functionality.

### Usage in Bindings

```nix
programs.niri.settings.binds = with config.lib.niri.actions; {
  "Mod+Return".action = spawn "alacritty";
  "Mod+Q".action = close_window;
  "Mod+F".action = fullscreen_window;
  "Mod+H".action = focus_column_left;
  "Mod+L".action = focus_column_right;
  "Mod+1".action = focus_workspace 1;
};
```

### Available Actions (87 total)

### `center_column`

**KDL Action:** `center-column`
**Description:** Center the focused column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = center_column;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = center-column; }
}
```


### `center_visible_columns`

**KDL Action:** `center-visible-columns`
**Description:** Center all visible columns

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = center_visible_columns;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = center-visible-columns; }
}
```


### `center_window`

**KDL Action:** `center-window`
**Description:** Center the focused window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = center_window;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = center-window; }
}
```


### `close_overview`

**KDL Action:** `close-overview`
**Description:** Close overview mode

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = close_overview;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = close-overview; }
}
```


### `close_window`

**KDL Action:** `close-window`
**Description:** Close the focused window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = close_window;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = close-window; }
}
```


### `debug_toggle_damage`

**KDL Action:** `debug-toggle-damage`
**Description:** Toggle damage debug overlay

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = debug_toggle_damage;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = debug-toggle-damage; }
}
```


### `debug_toggle_opaque_regions`

**KDL Action:** `debug-toggle-opaque-regions`
**Description:** Toggle opaque regions debug overlay

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = debug_toggle_opaque_regions;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = debug-toggle-opaque-regions; }
}
```


### `do_screen_transition`

**KDL Action:** `do-screen-transition`
**Description:** Perform screen transition effect

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = do_screen_transition 500;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = do-screen-transition; }
}
```


### `expand_column_to_available_width`

**KDL Action:** `expand-column-to-available-width`
**Description:** Expand column to fill available width

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = expand_column_to_available_width;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = expand-column-to-available-width; }
}
```


### `focus_column`

**KDL Action:** `focus-column`
**Description:** Focus column by index

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column 2;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-column; }
}
```


### `focus_column_first`

**KDL Action:** `focus-column-first`
**Description:** Focus first column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_first;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-column-first; }
}
```


### `focus_column_last`

**KDL Action:** `focus-column-last`
**Description:** Focus last column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_last;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-column-last; }
}
```


### `focus_column_left`

**KDL Action:** `focus-column-left`
**Description:** Focus column to the left

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_left;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-column-left; }
}
```


### `focus_column_left_or_last`

**KDL Action:** `focus-column-left-or-last`
**Description:** Focus left column or wrap to last

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_left_or_last;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-column-left-or-last; }
}
```


### `focus_column_or_monitor_left`

**KDL Action:** `focus-column-or-monitor-left`
**Description:** Focus column left or monitor left

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_or_monitor_left;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-column-or-monitor-left; }
}
```


### `focus_column_or_monitor_right`

**KDL Action:** `focus-column-or-monitor-right`
**Description:** Focus column right or monitor right

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_or_monitor_right;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-column-or-monitor-right; }
}
```


### `focus_column_right`

**KDL Action:** `focus-column-right`
**Description:** Focus column to the right

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_right;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-column-right; }
}
```


### `focus_column_right_or_first`

**KDL Action:** `focus-column-right-or-first`
**Description:** Focus right column or wrap to first

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_right_or_first;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-column-right-or-first; }
}
```


### `focus_floating`

**KDL Action:** `focus-floating`
**Description:** Focus floating windows

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_floating;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-floating; }
}
```


### `focus_monitor`

**KDL Action:** `focus-monitor`
**Description:** Focus specific monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor "DP-1";
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-monitor; }
}
```


### `focus_monitor_down`

**KDL Action:** `focus-monitor-down`
**Description:** Focus monitor below

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_down;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-monitor-down; }
}
```


### `focus_monitor_left`

**KDL Action:** `focus-monitor-left`
**Description:** Focus monitor to the left

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_left;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-monitor-left; }
}
```


### `focus_monitor_next`

**KDL Action:** `focus-monitor-next`
**Description:** Focus next monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_next;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-monitor-next; }
}
```


### `focus_monitor_previous`

**KDL Action:** `focus-monitor-previous`
**Description:** Focus previously focused monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_previous;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-monitor-previous; }
}
```


### `focus_monitor_right`

**KDL Action:** `focus-monitor-right`
**Description:** Focus monitor to the right

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_right;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-monitor-right; }
}
```


### `focus_monitor_up`

**KDL Action:** `focus-monitor-up`
**Description:** Focus monitor above

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_up;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-monitor-up; }
}
```


### `focus_tiling`

**KDL Action:** `focus-tiling`
**Description:** Focus tiling windows

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_tiling;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-tiling; }
}
```


### `focus_window_bottom`

**KDL Action:** `focus-window-bottom`
**Description:** Focus bottommost window in column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_bottom;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-bottom; }
}
```


### `focus_window_down`

**KDL Action:** `focus-window-down`
**Description:** Focus window below

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_down;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-down; }
}
```


### `focus_window_down_or_column_left`

**KDL Action:** `focus-window-down-or-column-left`
**Description:** Focus window down or column left

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_down_or_column_left;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-down-or-column-left; }
}
```


### `focus_window_down_or_column_right`

**KDL Action:** `focus-window-down-or-column-right`
**Description:** Focus window down or column right

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_down_or_column_right;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-down-or-column-right; }
}
```


### `focus_window_down_or_top`

**KDL Action:** `focus-window-down-or-top`
**Description:** Focus window down or wrap to top

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_down_or_top;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-down-or-top; }
}
```


### `focus_window_or_monitor_down`

**KDL Action:** `focus-window-or-monitor-down`
**Description:** Focus window down or monitor down

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_or_monitor_down;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-or-monitor-down; }
}
```


### `focus_window_or_monitor_up`

**KDL Action:** `focus-window-or-monitor-up`
**Description:** Focus window up or monitor up

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_or_monitor_up;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-or-monitor-up; }
}
```


### `focus_window_or_workspace_down`

**KDL Action:** `focus-window-or-workspace-down`
**Description:** Focus window down or workspace down

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_or_workspace_down;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-or-workspace-down; }
}
```


### `focus_window_or_workspace_up`

**KDL Action:** `focus-window-or-workspace-up`
**Description:** Focus window up or workspace up

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_or_workspace_up;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-or-workspace-up; }
}
```


### `focus_window_previous`

**KDL Action:** `focus-window-previous`
**Description:** Focus previously focused window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_previous;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-previous; }
}
```


### `focus_window_top`

**KDL Action:** `focus-window-top`
**Description:** Focus topmost window in column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_top;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-top; }
}
```


### `focus_window_up`

**KDL Action:** `focus-window-up`
**Description:** Focus window above

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_up;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-up; }
}
```


### `focus_window_up_or_bottom`

**KDL Action:** `focus-window-up-or-bottom`
**Description:** Focus window up or wrap to bottom

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_up_or_bottom;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-up-or-bottom; }
}
```


### `focus_window_up_or_column_left`

**KDL Action:** `focus-window-up-or-column-left`
**Description:** Focus window up or column left

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_up_or_column_left;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-up-or-column-left; }
}
```


### `focus_window_up_or_column_right`

**KDL Action:** `focus-window-up-or-column-right`
**Description:** Focus window up or column right

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_up_or_column_right;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-window-up-or-column-right; }
}
```


### `focus_workspace`

**KDL Action:** `focus-workspace`
**Description:** Focus specific workspace

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_workspace 2;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-workspace; }
}
```


### `focus_workspace_down`

**KDL Action:** `focus-workspace-down`
**Description:** Focus workspace below

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_workspace_down;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-workspace-down; }
}
```


### `focus_workspace_previous`

**KDL Action:** `focus-workspace-previous`
**Description:** Focus previously focused workspace

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_workspace_previous;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-workspace-previous; }
}
```


### `focus_workspace_up`

**KDL Action:** `focus-workspace-up`
**Description:** Focus workspace above

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_workspace_up;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = focus-workspace-up; }
}
```


### `fullscreen_window`

**KDL Action:** `fullscreen-window`
**Description:** Toggle window fullscreen

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = fullscreen_window;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = fullscreen-window; }
}
```


### `maximize_column`

**KDL Action:** `maximize-column`
**Description:** Maximize column width

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = maximize_column;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = maximize-column; }
}
```


### `maximize_window_to_edges`

**KDL Action:** `maximize-window-to-edges`
**Description:** Maximize window to screen edges

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = maximize_window_to_edges;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = maximize-window-to-edges; }
}
```


### `move_column_left`

**KDL Action:** `move-column-left`
**Description:** Move column to the left

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_left;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-column-left; }
}
```


### `move_column_left_or_to_monitor_left`

**KDL Action:** `move-column-left-or-to-monitor-left`
**Description:** Move column left or to left monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_left_or_to_monitor_left;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-column-left-or-to-monitor-left; }
}
```


### `move_column_right`

**KDL Action:** `move-column-right`
**Description:** Move column to the right

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_right;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-column-right; }
}
```


### `move_column_right_or_to_monitor_right`

**KDL Action:** `move-column-right-or-to-monitor-right`
**Description:** Move column right or to right monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_right_or_to_monitor_right;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-column-right-or-to-monitor-right; }
}
```


### `move_column_to_first`

**KDL Action:** `move-column-to-first`
**Description:** Move column to first position

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_to_first;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-column-to-first; }
}
```


### `move_column_to_index`

**KDL Action:** `move-column-to-index`
**Description:** Move column to specific index

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_to_index 2;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-column-to-index; }
}
```


### `move_column_to_last`

**KDL Action:** `move-column-to-last`
**Description:** Move column to last position

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_to_last;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-column-to-last; }
}
```


### `move_window_down`

**KDL Action:** `move-window-down`
**Description:** Move window down in column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_down;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-down; }
}
```


### `move_window_down_or_to_workspace_down`

**KDL Action:** `move-window-down-or-to-workspace-down`
**Description:** Move window down or to workspace below

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_down_or_to_workspace_down;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-down-or-to-workspace-down; }
}
```


### `move_window_to_floating`

**KDL Action:** `move-window-to-floating`
**Description:** Move window to floating layer

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_floating;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-to-floating; }
}
```


### `move_window_to_monitor`

**KDL Action:** `move-window-to-monitor`
**Description:** Move window to specific monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor "DP-1";
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-to-monitor; }
}
```


### `move_window_to_monitor_down`

**KDL Action:** `move-window-to-monitor-down`
**Description:** Move window to monitor below

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_down;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-to-monitor-down; }
}
```


### `move_window_to_monitor_left`

**KDL Action:** `move-window-to-monitor-left`
**Description:** Move window to left monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_left;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-to-monitor-left; }
}
```


### `move_window_to_monitor_next`

**KDL Action:** `move-window-to-monitor-next`
**Description:** Move window to next monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_next;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-to-monitor-next; }
}
```


### `move_window_to_monitor_previous`

**KDL Action:** `move-window-to-monitor-previous`
**Description:** Move window to previous monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_previous;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-to-monitor-previous; }
}
```


### `move_window_to_monitor_right`

**KDL Action:** `move-window-to-monitor-right`
**Description:** Move window to right monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_right;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-to-monitor-right; }
}
```


### `move_window_to_monitor_up`

**KDL Action:** `move-window-to-monitor-up`
**Description:** Move window to monitor above

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_up;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-to-monitor-up; }
}
```


### `move_window_to_tiling`

**KDL Action:** `move-window-to-tiling`
**Description:** Move window to tiling layer

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_tiling;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-to-tiling; }
}
```


### `move_window_up`

**KDL Action:** `move-window-up`
**Description:** Move window up in column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_up;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-up; }
}
```


### `move_window_up_or_to_workspace_up`

**KDL Action:** `move-window-up-or-to-workspace-up`
**Description:** Move window up or to workspace above

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_up_or_to_workspace_up;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = move-window-up-or-to-workspace-up; }
}
```


### `open_overview`

**KDL Action:** `open-overview`
**Description:** Open overview mode

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = open_overview;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = open-overview; }
}
```


### `power_off_monitors`

**KDL Action:** `power-off-monitors`
**Description:** Turn off all monitors

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = power_off_monitors;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = power-off-monitors; }
}
```


### `power_on_monitors`

**KDL Action:** `power-on-monitors`
**Description:** Turn on all monitors

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = power_on_monitors;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = power-on-monitors; }
}
```


### `quit`

**KDL Action:** `quit`
**Description:** Quit niri compositor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = quit;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = quit; }
}
```


### `screenshot`

**KDL Action:** `screenshot`
**Description:** Take a screenshot

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = screenshot;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = screenshot; }
}
```


### `screenshot_screen`

**KDL Action:** `screenshot-screen`
**Description:** Take a screenshot of entire screen

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = screenshot_screen;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = screenshot-screen; }
}
```


### `screenshot_window`

**KDL Action:** `screenshot-window`
**Description:** Take a screenshot of current window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = screenshot_window;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = screenshot-window; }
}
```


### `set_column_width`

**KDL Action:** `set-column-width`
**Description:** Set column width

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = set_column_width "+10%";
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = set-column-width; }
}
```


### `show_hotkey_overlay`

**KDL Action:** `show-hotkey-overlay`
**Description:** Show hotkey overlay

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = show_hotkey_overlay;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = show-hotkey-overlay; }
}
```


### `spawn`

**KDL Action:** `spawn`
**Description:** Execute a command

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = spawn "alacritty";
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = spawn; }
}
```


### `spawn_sh`

**KDL Action:** `spawn-sh`
**Description:** Execute a shell command

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = spawn_sh "notify-send Hello";
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = spawn-sh; }
}
```


### `suspend`

**KDL Action:** `suspend`
**Description:** Suspend the system

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = suspend;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = suspend; }
}
```


### `switch_focus_between_floating_and_tiling`

**KDL Action:** `switch-focus-between-floating-and-tiling`
**Description:** Switch focus between floating and tiling

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = switch_focus_between_floating_and_tiling;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = switch-focus-between-floating-and-tiling; }
}
```


### `toggle_debug_tint`

**KDL Action:** `toggle-debug-tint`
**Description:** Toggle debug tint overlay

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle_debug_tint;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = toggle-debug-tint; }
}
```


### `toggle_keyboard_shortcuts_inhibit`

**KDL Action:** `toggle-keyboard-shortcuts-inhibit`
**Description:** Toggle keyboard shortcuts inhibition

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle_keyboard_shortcuts_inhibit;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = toggle-keyboard-shortcuts-inhibit; }
}
```


### `toggle_overview`

**KDL Action:** `toggle-overview`
**Description:** Toggle overview mode

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle_overview;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = toggle-overview; }
}
```


### `toggle_window_floating`

**KDL Action:** `toggle-window-floating`
**Description:** Toggle window between floating and tiling

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle_window_floating;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = toggle-window-floating; }
}
```


### `toggle_windowed_fullscreen`

**KDL Action:** `toggle-windowed-fullscreen`
**Description:** Toggle windowed fullscreen

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle_windowed_fullscreen;
};
```

**KDL Format:**
```kdl
binds {
  Mod+Key { action = toggle-windowed-fullscreen; }
}
```



## Type Reference

### Basic Types

| Type | Description | Example |
|------|-------------|---------|
| `boolean` | True or false | `true`, `false` |
| `string` | Text value | `"alacritty"`, `"#ff0000"` |
| `integer` | Whole number | `16`, `1920` |
| `float` | Decimal number | `1.25`, `144.0` |
| `list of T` | Array of type T | `[ "item1", "item2" ]` |
| `attribute set` | Object with key-value pairs | `{ x = 100; y = 50; }` |

### Complex Types

#### Color
Colors can be specified in multiple formats:
- Hex: `"#ff0000"`, `"#rgb"`, `"#rrggbb"`, `"#rrggbbaa"`
- CSS names: `"red"`, `"blue"`, `"transparent"`
- RGB functions: `"rgb(255, 0, 0)"`, `"rgba(255, 0, 0, 0.5)"`

#### Size Specification
```nix
# Proportional (percentage of available space)
{ proportion = 0.5; }  # 50%

# Fixed pixels
{ fixed = 1920; }

# String format for adjustments
"+10%"    # Increase by 10%
"-5%"     # Decrease by 5%
"1000"    # Set to 1000 pixels
```

#### Position
```nix
{
  x = 1920;  # Horizontal position
  y = 0;     # Vertical position
}
```

#### Mode (Resolution)
```nix
{
  width = 1920;
  height = 1080;
  refresh_rate = 144.0;  # Optional
}
```

### Enums

#### Transform
Valid values: `"normal"`, `"90"`, `"180"`, `"270"`, `"flipped"`, `"flipped-90"`, `"flipped-180"`, `"flipped-270"`

#### Center Focused Column
Valid values: `"never"`, `"always"`, `"on-overflow"`

#### Acceleration Profile
Valid values: `"adaptive"`, `"flat"`

#### Click Method
Valid values: `"clickfinger"`, `"button-areas"`

#### Scroll Method
Valid values: `"no-scroll"`, `"two-finger"`, `"edge"`, `"on-button-down"`


## Validation

The niri module provides comprehensive validation to catch errors early:

### Type Validation
- All options have strongly-typed Nix types
- Invalid types cause build failures with clear error messages
- Example: Setting `gaps = "sixteen"` will fail (expected integer)

### Value Validation
- Colors must be valid hex, CSS names, or RGB functions
- Numeric values are checked against valid ranges
- Enum values must match exactly (case-sensitive)

### Cross-Reference Validation
- Window rules can reference existing outputs and workspaces
- Actions in binds must be valid niri actions
- Monitor names in output configurations are checked

### Common Validation Errors

```nix
# ❌ Wrong type
layout.gaps = "16";  # Should be integer: 16

# ❌ Invalid color
focus_ring.active_color = "notacolor";  # Should be "#ff0000" or "red"

# ❌ Invalid enum
touchpad.accel_profile = "medium";  # Should be "adaptive" or "flat"

# ❌ Invalid action
"Mod+X".action = nonexistent_action;  # Use valid action from library
```


## Advanced Usage

### Mixed Configuration Approach

Use structured options for type safety and `extraConfig` for advanced features:

```nix
programs.niri = {
  enable = true;

  # Type-safe structured configuration
  settings = {
    input.keyboard.xkb.layout = "us";
    layout.gaps = 16;
    binds = with config.lib.niri.actions; {
      "Mod+Return".action = spawn "alacritty";
    };
  };

  # Raw KDL for experimental features
  extraConfig = ''
    debug {
      render-drm true
      damage "off"
    }

    // Complex window rule
    window-rule {
      matches app-id="^special-app$" title="Debug.*"
      opacity 0.9
      exclude-from-screenshot true
    }
  '';
};
```

### Custom Window Rules

```nix
programs.niri.settings.window_rules = [
  # Firefox on specific monitor
  {
    matches = [{ app_id = "firefox"; }];
    open_on_output = "DP-1";
    open_on_workspace = "browser";
    default_column_width = { proportion = 0.75; };
  }

  # Gaming applications
  {
    matches = [{ app_id = "^steam_app_.*"; }];
    open_fullscreen = true;
    block_out_from = "screen-capture";
  }

  # Floating utilities
  {
    matches = [
      { app_id = "^org\\.gnome\\.Calculator$"; }
      { title = "Picture-in-Picture"; }
    ];
    open_floating = true;
    default_column_width = { fixed = 400; };
  }
];
```

### Multi-Monitor Setup

```nix
programs.niri.settings = {
  outputs = [
    {
      name = "eDP-1";
      scale = 1.25;
      position = { x = 0; y = 0; };
      mode = { width = 2560; height = 1600; refresh_rate = 165.0; };
    }
    {
      name = "DP-1";
      scale = 1.0;
      position = { x = 2048; y = 0; };  # 2560 / 1.25 = 2048
      mode = { width = 3440; height = 1440; refresh_rate = 144.0; };
    }
  ];

  # Monitor-specific bindings
  binds = with config.lib.niri.actions; {
    "Mod+Shift+H".action = focus_monitor_left;
    "Mod+Shift+L".action = focus_monitor_right;
    "Mod+Ctrl+H".action = move_window_to_monitor_left;
    "Mod+Ctrl+L".action = move_window_to_monitor_right;
  };
};
```

### Animation Configuration

```nix
programs.niri.settings.animations = {
  slowdown = 0.8;  # Slightly faster animations

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

  window_close = {
    easing = {
      duration_ms = 150;
      curve = "ease-in-expo";
    };
  };
};
```


## Niri Version Information

This module is automatically generated from the niri Wayland compositor source code.
Version information will be displayed here when the module is built with proper niri source integration.


## Troubleshooting

### Common Issues

#### Build Failures
```bash
error: The option 'programs.niri.settings.layout.gaps' is not an integer.
```
**Solution:** Check option types - `gaps` expects an integer, not a string.

#### Invalid Actions
```bash
error: undefined variable 'invalid_action'
```
**Solution:** Use actions from `config.lib.niri.actions` or check spelling.

#### KDL Syntax Errors
```bash
niri: error parsing config: unexpected token at line 42
```
**Solutions:**
1. Check generated config: `cat ~/.config/niri/config.kdl`
2. Validate with: `niri validate`
3. Check `extraConfig` for syntax errors

### Debugging Steps

1. **Check generated configuration:**
   ```bash
   cat ~/.config/niri/config.kdl
   ```

2. **Validate niri can parse it:**
   ```bash
   niri validate
   ```

3. **Test niri configuration:**
   ```bash
   niri --dry-run
   ```

4. **Enable verbose logging:**
   ```bash
   RUST_LOG=niri=debug niri
   ```

### Performance Issues

If niri feels slow:
- Reduce `animations.slowdown` value
- Disable animations: `animations.off = true`
- Check GPU drivers for Wayland support
- Monitor system resources during use

### Getting Help

1. **Documentation:** [niri Wiki](https://github.com/YaLTeR/niri/wiki)
2. **Community:** niri Discord/Matrix rooms
3. **Issues:**
   - niri-specific: [niri repository](https://github.com/YaLTeR/niri/issues)
   - Module-specific: [niri-flake repository](https://github.com/your-username/niri-flake/issues)


## Contributing

### Module Development

The niri module is automatically generated from niri's source code. To improve the generator:

1. **Parser improvements** (`generator/parser.nix`)
2. **Type mapping** (`generator/type-mapper.nix`)
3. **Documentation** (`generator/enhanced-docs-generator.nix`)
4. **Validation** (`generator/validation.nix`)

### Testing

```bash
# Run test suite
nix build .#check

# Test specific configuration
nix build .#examples.basic-config

# Generate documentation
./build-docs.sh

# Run all workflows locally
nix build .#module-test
```

### Automated Updates

The module automatically updates when:
- New niri commits are available (daily check at 2 AM UTC)
- Generator code changes are pushed
- Manual workflow dispatch is triggered

### Reporting Issues

When reporting issues, include:
- Your Nix configuration
- Generated KDL file (`~/.config/niri/config.kdl`)
- Error messages
- Niri version and commit hash (shown above)
- Steps to reproduce the issue


---

*This documentation is automatically generated from the niri source code. Last updated: $(date -u +'%Y-%m-%d %H:%M:%S UTC')*

---

## Niri Version Information

This module is generated from the niri Wayland compositor source code to ensure complete compatibility and feature coverage.

### Current Integration

**Niri Commit:** [\`dfcbbbb03071cadf3fd9bbb0903ead364a839412\`](https://github.com/soulvice/niri/commit/dfcbbbb03071cadf3fd9bbb0903ead364a839412)
**Commit Message:** Merge branch 'YaLTeR:main' into main
**Integration SHA256:** \`sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=\`

### Latest Niri Development

**Latest Commit:** [\`dfcbbbb03071cadf3fd9bbb0903ead364a839412\`](https://github.com/soulvice/niri/commit/dfcbbbb03071cadf3fd9bbb0903ead364a839412)
**Commit Date:** 2025-11-18T19:32:51Z

### Automatic Updates

This module is automatically updated when new niri commits are available. The GitHub Actions workflow:
- Monitors the [niri repository](https://github.com/soulvice/niri) for changes
- Automatically regenerates the module when new commits are detected
- Updates documentation and examples
- Creates pull requests for review and integration

### Version Compatibility

| Component | Version |
|-----------|---------|
| Niri Source | [\`dfcbbbb03071cadf3fd9bbb0903ead364a839412\`](https://github.com/soulvice/niri/commit/dfcbbbb03071cadf3fd9bbb0903ead364a839412) |
| Module Generated | $(date -u +'%Y-%m-%d %H:%M:%S UTC') |
| Documentation | $(date -u +'%Y-%m-%d %H:%M:%S UTC') |

