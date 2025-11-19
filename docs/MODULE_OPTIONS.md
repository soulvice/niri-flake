# Niri Home-Manager Module Documentation

<!-- Generated at build time -->

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Module Options](#module-options)
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
- 🎯 **Complete Coverage** - All 72 niri actions available
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


## Module Options

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

### `programs.niri.settings.animations`

**Type:** null or (submodule)
**Default:** `null`

Animation configuration.

Controls various animations throughout the compositor for smooth visual transitions.


### `programs.niri.settings.animations.config_notification_open_close`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for configuration reload notifications.

Controls how config change notifications appear and disappear.



### `programs.niri.settings.animations.horizontal_view_movement`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for horizontal workspace/column scrolling.

Controls smoothness when moving between columns or workspaces.



### `programs.niri.settings.animations.shaders`

**Type:** null or boolean
**Default:** `null`

Whether to use GPU shaders for animations.

Provides smoother animations but may increase GPU usage.



### `programs.niri.settings.animations.slowdown`

**Type:** null or number between 0.001000 and 100.000000
**Default:** `null`**Example:** `1.000000`

Global animation speed multiplier.

1.0 = normal speed
2.0 = half speed (slower)
0.5 = double speed (faster)



### `programs.niri.settings.animations.window_close`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for window closure.

Controls how windows animate when being closed.



### `programs.niri.settings.animations.window_movement`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for window movement between columns.

Controls how smoothly windows animate when moved around.



### `programs.niri.settings.animations.window_open`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for new window appearance.

Controls how new windows animate when they first appear.



### `programs.niri.settings.animations.window_resize`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for window resizing.

Controls how smoothly windows animate when being resized.



### `programs.niri.settings.animations.workspace_switch`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for workspace switching.

Controls how smoothly the view transitions between workspaces.




### `programs.niri.settings.binds`

**Type:** null or (attribute set of (string or (submodule)))
**Default:** `null`**Example:** `{ Mod+D = ..., Mod+Q = ..., Mod+Return = ... }`

Keyboard and mouse bindings.

Maps key combinations to actions. Use config.lib.niri.actions for predefined actions.

Key syntax:
- Modifiers: Mod (Super), Alt, Ctrl, Shift
- Keys: letters, numbers, function keys (F1-F12), special keys
- Mouse: click actions can be bound to mouse buttons

Examples:
- "Mod+Return" - Super + Enter
- "Alt+Shift+Q" - Alt + Shift + Q
- "Ctrl+Alt+Delete" - Ctrl + Alt + Delete



### `programs.niri.settings.cursor`

**Type:** null or (submodule)
**Default:** `null`

Mouse cursor appearance configuration.

Controls the visual appearance of the mouse cursor.


### `programs.niri.settings.cursor.size`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `24`

Cursor size in pixels.

Larger values make the cursor bigger and more visible.



### `programs.niri.settings.cursor.theme`

**Type:** null or string
**Default:** `null`**Example:** `"Adwaita"`

Cursor theme name.

Must be installed on the system and available in cursor theme directories.




### `programs.niri.settings.debug`

**Type:** null or (submodule)
**Default:** `null`

Debug and development options.

These options are primarily useful for development and troubleshooting.


### `programs.niri.settings.debug.dbus_interfaces_in_non_session_instances`

**Type:** null or boolean
**Default:** `null`

Enable D-Bus interfaces in non-session instances.

Useful for debugging and testing when niri isn't running as the main session.



### `programs.niri.settings.debug.emulate_zero_presentation_time`

**Type:** null or boolean
**Default:** `null`

Emulate zero presentation time.

Debugging option for timing-related issues.



### `programs.niri.settings.debug.enable`

**Type:** null or boolean
**Default:** `null`

Enable debug mode.

Shows additional debugging information and overlays.



### `programs.niri.settings.debug.enable_color_transformations_capability`

**Type:** null or boolean
**Default:** `null`

Enable color transformation capability.

Experimental feature for advanced color management.



### `programs.niri.settings.debug.wait_for_frame_completion_before_queueing`

**Type:** null or boolean
**Default:** `null`

Wait for frame completion before queueing next frame.

May reduce performance but can help debug frame timing issues.




### `programs.niri.settings.environment`

**Type:** null or (attribute set of string)
**Default:** `null`**Example:** `{ BROWSER = ..., EDITOR = ..., TERM = ... }`

Environment variables to set for spawned processes.

These variables will be available to all applications launched by niri.



### `programs.niri.settings.input`

**Type:** null or (submodule)
**Default:** `null`

Input device configuration.

Controls keyboards, mice, touchpads, tablets, and other input devices.


### `programs.niri.settings.input.keyboard`

**Type:** null or (submodule)
**Default:** `null`

Keyboard input configuration

### `programs.niri.settings.input.keyboard.repeat-delay`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `600`

Delay in milliseconds before key repeat starts.

Higher values mean you need to hold a key longer before it starts repeating.



### `programs.niri.settings.input.keyboard.repeat-rate`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `25`

Key repeat rate in characters per second.

Higher values mean faster key repeat when holding a key.



### `programs.niri.settings.input.keyboard.track-layout`

**Type:** null or track layout (global, window)
**Default:** `null`

How to track keyboard layout changes.

"global" = same layout for all windows
"window" = remember layout per window



### `programs.niri.settings.input.keyboard.xkb`

**Type:** null or (submodule)
**Default:** `null`

XKB (X Keyboard Extension) configuration.

Controls keyboard layout, variant, and options.


### `programs.niri.settings.input.keyboard.xkb.layout`

**Type:** null or string
**Default:** `null`**Example:** `"us,de"`

XKB keyboard layout(s)


### `programs.niri.settings.input.keyboard.xkb.model`

**Type:** null or string
**Default:** `null`**Example:** `"pc105"`

XKB keyboard model


### `programs.niri.settings.input.keyboard.xkb.options`

**Type:** null or string
**Default:** `null`**Example:** `"grp:alt\_shift\_toggle,caps:escape"`

XKB options


### `programs.niri.settings.input.keyboard.xkb.rules`

**Type:** null or string
**Default:** `null`**Example:** `"evdev"`

XKB rules file to use


### `programs.niri.settings.input.keyboard.xkb.variant`

**Type:** null or string
**Default:** `null`**Example:** `"dvorak"`

XKB layout variant(s)




### `programs.niri.settings.input.mouse`

**Type:** null or (submodule)
**Default:** `null`

Mouse input configuration

### `programs.niri.settings.input.mouse.accel_profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Mouse acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement



### `programs.niri.settings.input.mouse.accel_speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Mouse acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest



### `programs.niri.settings.input.mouse.natural_scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).




### `programs.niri.settings.input.tablet`

**Type:** null or (submodule)
**Default:** `null`

Graphics tablet input configuration

### `programs.niri.settings.input.tablet.map_to_output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Map tablet input to specific output.

Must reference an output defined in the outputs section.




### `programs.niri.settings.input.touch`

**Type:** null or (submodule)
**Default:** `null`

Touchscreen input configuration

### `programs.niri.settings.input.touch.map_to_output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"eDP-1"`

Map touch input to specific output.

Must reference an output defined in the outputs section.




### `programs.niri.settings.input.touchpad`

**Type:** null or (submodule)
**Default:** `null`

Touchpad input configuration

### `programs.niri.settings.input.touchpad.accel_profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Touchpad acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement



### `programs.niri.settings.input.touchpad.accel_speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.200000`

Touchpad acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest



### `programs.niri.settings.input.touchpad.click_method`

**Type:** null or click method (clickfinger, button-areas)
**Default:** `null`

Touchpad click method.

"clickfinger" = click location determines button (modern)
"button-areas" = touchpad areas determine button (traditional)



### `programs.niri.settings.input.touchpad.dwt`

**Type:** null or boolean
**Default:** `null`

Disable touchpad while typing.

Prevents accidental touchpad activation when typing.



### `programs.niri.settings.input.touchpad.natural_scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).



### `programs.niri.settings.input.touchpad.scroll_method`

**Type:** null or scroll method (no-scroll, two-finger, edge, on-button-down)
**Default:** `null`

Touchpad scroll method.

"two-finger" = scroll with two fingers (most common)
"edge" = scroll by moving along touchpad edge
"on-button-down" = scroll while holding button
"no-scroll" = disable scrolling



### `programs.niri.settings.input.touchpad.tap`

**Type:** null or boolean
**Default:** `null`

Enable tap-to-click on touchpad.

When enabled, lightly tapping the touchpad will register as a click.



### `programs.niri.settings.input.touchpad.tap_button_map`

**Type:** null or tap button map (left-right-middle, left-middle-right)
**Default:** `null`

Touchpad tap button mapping.

"left-right-middle" = 1-finger=left, 2-finger=right, 3-finger=middle
"left-middle-right" = 1-finger=left, 2-finger=middle, 3-finger=right




### `programs.niri.settings.input.trackball`

**Type:** null or (submodule)
**Default:** `null`

Trackball input configuration

### `programs.niri.settings.input.trackball.accel_profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Trackball acceleration profile


### `programs.niri.settings.input.trackball.accel_speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Trackball acceleration speed (-1.0 to 1.0)


### `programs.niri.settings.input.trackball.natural_scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural scrolling for trackball




### `programs.niri.settings.layout`

**Type:** null or (submodule)
**Default:** `null`

Window layout and visual configuration.

Controls window positioning, spacing, borders, and visual indicators.


### `programs.niri.settings.layout.always_center_single_column`

**Type:** null or boolean
**Default:** `null`

Whether to center single columns on the screen.

When only one column is present, center it instead of placing it at the left edge.



### `programs.niri.settings.layout.border`

**Type:** null or (submodule)
**Default:** `null`

Window border configuration

### `programs.niri.settings.layout.border.active_color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#ffffff"`

Border color for the active window


### `programs.niri.settings.layout.border.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show borders around windows.

Persistent borders around all windows, separate from focus rings.



### `programs.niri.settings.layout.border.inactive_color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#808080"`

Border color for inactive windows


### `programs.niri.settings.layout.border.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `2`

Window border width in pixels



### `programs.niri.settings.layout.center_focused_column`

**Type:** null or center focused column (never, always, on-overflow)
**Default:** `null`

When to center the focused column on screen.

"never" = never center columns
"always" = always center the focused column
"on-overflow" = center only when columns don't fit on screen



### `programs.niri.settings.layout.default_column_width`

**Type:** null or (submodule)
**Default:** `null`

Default width for new columns.

Can be specified as either a proportion of screen width or fixed pixels.
Only one of proportion or fixed should be set.


### `programs.niri.settings.layout.default_column_width.fixed`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `1920`

Default column width in pixels.

Fixed pixel width regardless of screen size.



### `programs.niri.settings.layout.default_column_width.proportion`

**Type:** null or number between 0.100000 and 10.000000
**Default:** `null`**Example:** `0.500000`

Default column width as proportion of screen width.

1.0 = full screen width
0.5 = half screen width
Values > 1.0 create wider-than-screen columns




### `programs.niri.settings.layout.focus_ring`

**Type:** null or (submodule)
**Default:** `null`

Focus ring visual indicator configuration.

Shows a colored border around focused windows.


### `programs.niri.settings.layout.focus_ring.active_color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#7fc8ff"`

Color or gradient for the active window focus ring.

Can be a solid color or a gradient for visual effects.



### `programs.niri.settings.layout.focus_ring.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show a focus ring around the active window.

Visual indicator to highlight which window has focus.



### `programs.niri.settings.layout.focus_ring.inactive_color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#505050"`

Color or gradient for inactive window focus rings.

Used for non-focused windows when they have visible focus indicators.



### `programs.niri.settings.layout.focus_ring.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `4`

Focus ring width in pixels.

Thickness of the border drawn around the focused window.




### `programs.niri.settings.layout.gaps`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `16`

Gap size in pixels between windows and screen edges.

Sets uniform gaps around all windows for a clean, spaced look.



### `programs.niri.settings.layout.preset_column_widths`

**Type:** null or (list of preset size (proportion 0.0-1.0 or fixed pixels))
**Default:** `null`**Example:** `[ 0.250000, 0.500000, 0.750000, ... ]`

Predefined column widths for quick switching.

List of widths that can be cycled through with keybindings.
Values can be proportions (0.0-1.0) or fixed pixel sizes.



### `programs.niri.settings.layout.struts`

**Type:** null or (submodule)
**Default:** `null`

Reserved screen edge space.

Prevents windows from using specified screen areas, useful for panels/docks.


### `programs.niri.settings.layout.struts.bottom`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on bottom edge in pixels


### `programs.niri.settings.layout.struts.left`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on left edge in pixels


### `programs.niri.settings.layout.struts.right`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on right edge in pixels


### `programs.niri.settings.layout.struts.top`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on top edge in pixels




### `programs.niri.settings.outputs`

**Type:** null or (list of (submodule))
**Default:** `null`**Example:** `[ { ... }, { ... } ]`

Display output configuration.

Configure connected monitors/displays including resolution, scaling, and positioning.
Use \`niri msg outputs\` to see available outputs.


### `programs.niri.settings.outputs.mode`

**Type:** null or (submodule)
**Default:** `null`

Display mode configuration.

If not specified, niri will use the preferred mode from EDID.


### `programs.niri.settings.outputs.mode.height`

**Type:** positive integer, meaning >0
**Default:** `null`**Example:** `1080`

Display height in pixels


### `programs.niri.settings.outputs.mode.refresh`

**Type:** null or number between 1 and 1000
**Default:** `null`**Example:** `144.000000`

Refresh rate in Hz


### `programs.niri.settings.outputs.mode.width`

**Type:** positive integer, meaning >0
**Default:** `null`**Example:** `1920`

Display width in pixels



### `programs.niri.settings.outputs.name`

**Type:** output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Output connector name.

Use \`niri msg outputs\` or check system logs to find available output names.
Common examples: "DP-1", "HDMI-A-1", "eDP-1"



### `programs.niri.settings.outputs.position`

**Type:** null or (submodule)
**Default:** `null`

Output position in the global coordinate space.

Used for multi-monitor setups to specify monitor arrangement.
If not specified, niri will arrange outputs automatically.


### `programs.niri.settings.outputs.position.x`

**Type:** integer
**Default:** `null`**Example:** `1920`

Horizontal position in pixels


### `programs.niri.settings.outputs.position.y`

**Type:** integer
**Default:** `null`**Example:** `0`

Vertical position in pixels



### `programs.niri.settings.outputs.scale`

**Type:** null or number between 0.100000 and 10.000000
**Default:** `null`**Example:** `1.500000`

Display scaling factor.

1.0 = no scaling (100%)
2.0 = 2x scaling (200%)
1.5 = 1.5x scaling (150%)

Higher values make UI elements larger for high-DPI displays.



### `programs.niri.settings.outputs.transform`

**Type:** null or transform (normal, 90, 180, 270, flipped, flipped-90, flipped-180, flipped-270)
**Default:** `null`

Display rotation and reflection.

"normal" = no rotation
"90", "180", "270" = clockwise rotation in degrees
"flipped-\*" = mirror horizontally then rotate




### `programs.niri.settings.prefer_no_csd`

**Type:** null or boolean
**Default:** `null`

Whether to prefer server-side decorations over client-side.

When true, asks applications to use server-side window decorations
instead of drawing their own title bars and borders.



### `programs.niri.settings.screenshot_path`

**Type:** null or string
**Default:** `null`**Example:** `"~/Screenshots"`

Directory path for saving screenshots.

Screenshots taken with niri will be saved to this directory.
If not specified, uses the default Pictures directory.



### `programs.niri.settings.spawn_at_startup`

**Type:** null or (list of string)
**Default:** `null`**Example:** `[ waybar, mako, swww init ]`

Commands to run when niri starts.

List of shell commands that will be executed during niri initialization.
Useful for starting essential applications like status bars, notification daemons, etc.



### `programs.niri.settings.window_rules`

**Type:** null or (list of (submodule))
**Default:** `null`**Example:** `[ { ... }, { ... } ]`

Per-window behavior rules.

Configure how specific windows should behave based on their properties.
Rules are evaluated in order, and the first matching rule applies.


### `programs.niri.settings.window_rules.app-id`

**Type:** null or regular expression
**Default:** `null`**Example:** `"^firefox$"`

Match windows by their application ID (Wayland) or WM\_CLASS (X11).

Supports regular expressions for flexible matching.



### `programs.niri.settings.window_rules.block-out-from`

**Type:** null or one of "screencast", "screen-capture"
**Default:** `null`

Block this window from appearing in screencasts or screenshots.

Useful for sensitive windows like password managers.



### `programs.niri.settings.window_rules.is-active`

**Type:** null or boolean
**Default:** `null`

Match only the currently active window.

Useful for rules that should only apply to focused windows.



### `programs.niri.settings.window_rules.is-floating`

**Type:** null or boolean
**Default:** `null`

Match only floating or tiling windows.

true = floating windows only
false = tiling windows only
null = both floating and tiling



### `programs.niri.settings.window_rules.opacity`

**Type:** null or number between 0.000000 and 1.000000
**Default:** `null`**Example:** `0.900000`

Window opacity/transparency level.

0.0 = fully transparent
1.0 = fully opaque



### `programs.niri.settings.window_rules.open-floating`

**Type:** null or boolean
**Default:** `null`

Whether to open this window as floating.

true = always floating
false = always tiling
null = use default behavior



### `programs.niri.settings.window_rules.open-fullscreen`

**Type:** null or boolean
**Default:** `null`

Whether to open this window in fullscreen mode.



### `programs.niri.settings.window_rules.open-maximized`

**Type:** null or boolean
**Default:** `null`

Whether to open this window maximized.

Only applies to tiling windows.



### `programs.niri.settings.window_rules.open-on-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Which output (monitor) to open this window on.

Must reference an output defined in the outputs section.



### `programs.niri.settings.window_rules.open-on-workspace`

**Type:** null or workspace name
**Default:** `null`**Example:** `"main"`

Which workspace to open this window on.

Must reference a workspace defined in the workspaces section.



### `programs.niri.settings.window_rules.title`

**Type:** null or regular expression
**Default:** `null`**Example:** `".\*YouTube.\*"`

Match windows by their title/name.

Supports regular expressions for flexible matching.




### `programs.niri.settings.workspaces`

**Type:** null or (list of (submodule))
**Default:** `null`**Example:** `[ { ... }, { ... }, { ... } ]`

Workspace definitions.

Define named workspaces that can be referenced in window rules and keybindings.


### `programs.niri.settings.workspaces.name`

**Type:** workspace name
**Default:** `null`**Example:** `"main"`

Workspace name/identifier


### `programs.niri.settings.workspaces.open_on_output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Which output this workspace should open on.

Must reference an output defined in the outputs section.






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

### `center-column`

**Nix Function:** `center_column`
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


### `center-visible-columns`

**Nix Function:** `center_visible_columns`
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


### `center-window`

**Nix Function:** `center_window`
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


### `close-overview`

**Nix Function:** `close_overview`
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


### `close-window`

**Nix Function:** `close_window`
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


### `debug-toggle-damage`

**Nix Function:** `debug_toggle_damage`
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


### `debug-toggle-opaque-regions`

**Nix Function:** `debug_toggle_opaque_regions`
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


### `do-screen-transition`

**Nix Function:** `do_screen_transition`
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


### `expand-column-to-available-width`

**Nix Function:** `expand_column_to_available_width`
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


### `focus-column`

**Nix Function:** `focus_column`
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


### `focus-column-first`

**Nix Function:** `focus_column_first`
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


### `focus-column-last`

**Nix Function:** `focus_column_last`
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


### `focus-column-left`

**Nix Function:** `focus_column_left`
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


### `focus-column-left-or-last`

**Nix Function:** `focus_column_left_or_last`
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


### `focus-column-or-monitor-left`

**Nix Function:** `focus_column_or_monitor_left`
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


### `focus-column-or-monitor-right`

**Nix Function:** `focus_column_or_monitor_right`
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


### `focus-column-right`

**Nix Function:** `focus_column_right`
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


### `focus-column-right-or-first`

**Nix Function:** `focus_column_right_or_first`
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


### `focus-floating`

**Nix Function:** `focus_floating`
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


### `focus-monitor`

**Nix Function:** `focus_monitor`
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


### `focus-monitor-down`

**Nix Function:** `focus_monitor_down`
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


### `focus-monitor-left`

**Nix Function:** `focus_monitor_left`
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


### `focus-monitor-next`

**Nix Function:** `focus_monitor_next`
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


### `focus-monitor-previous`

**Nix Function:** `focus_monitor_previous`
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


### `focus-monitor-right`

**Nix Function:** `focus_monitor_right`
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


### `focus-monitor-up`

**Nix Function:** `focus_monitor_up`
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


### `focus-tiling`

**Nix Function:** `focus_tiling`
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


### `focus-window-bottom`

**Nix Function:** `focus_window_bottom`
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


### `focus-window-down`

**Nix Function:** `focus_window_down`
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


### `focus-window-down-or-column-left`

**Nix Function:** `focus_window_down_or_column_left`
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


### `focus-window-down-or-column-right`

**Nix Function:** `focus_window_down_or_column_right`
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


### `focus-window-down-or-top`

**Nix Function:** `focus_window_down_or_top`
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


### `focus-window-or-monitor-down`

**Nix Function:** `focus_window_or_monitor_down`
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


### `focus-window-or-monitor-up`

**Nix Function:** `focus_window_or_monitor_up`
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


### `focus-window-or-workspace-down`

**Nix Function:** `focus_window_or_workspace_down`
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


### `focus-window-or-workspace-up`

**Nix Function:** `focus_window_or_workspace_up`
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


### `focus-window-previous`

**Nix Function:** `focus_window_previous`
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


### `focus-window-top`

**Nix Function:** `focus_window_top`
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


### `focus-window-up`

**Nix Function:** `focus_window_up`
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


### `focus-window-up-or-bottom`

**Nix Function:** `focus_window_up_or_bottom`
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


### `focus-window-up-or-column-left`

**Nix Function:** `focus_window_up_or_column_left`
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


### `focus-window-up-or-column-right`

**Nix Function:** `focus_window_up_or_column_right`
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


### `focus-workspace`

**Nix Function:** `focus_workspace`
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


### `focus-workspace-down`

**Nix Function:** `focus_workspace_down`
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


### `focus-workspace-previous`

**Nix Function:** `focus_workspace_previous`
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


### `focus-workspace-up`

**Nix Function:** `focus_workspace_up`
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


### `fullscreen-window`

**Nix Function:** `fullscreen_window`
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


### `maximize-column`

**Nix Function:** `maximize_column`
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


### `maximize-window-to-edges`

**Nix Function:** `maximize_window_to_edges`
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


### `move-column-left`

**Nix Function:** `move_column_left`
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


### `move-column-left-or-to-monitor-left`

**Nix Function:** `move_column_left_or_to_monitor_left`
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


### `move-column-right`

**Nix Function:** `move_column_right`
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


### `move-column-right-or-to-monitor-right`

**Nix Function:** `move_column_right_or_to_monitor_right`
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


### `move-column-to-first`

**Nix Function:** `move_column_to_first`
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


### `move-column-to-index`

**Nix Function:** `move_column_to_index`
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


### `move-column-to-last`

**Nix Function:** `move_column_to_last`
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


### `move-window-down`

**Nix Function:** `move_window_down`
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


### `move-window-down-or-to-workspace-down`

**Nix Function:** `move_window_down_or_to_workspace_down`
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


### `move-window-to-floating`

**Nix Function:** `move_window_to_floating`
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


### `move-window-to-monitor`

**Nix Function:** `move_window_to_monitor`
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


### `move-window-to-monitor-down`

**Nix Function:** `move_window_to_monitor_down`
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


### `move-window-to-monitor-left`

**Nix Function:** `move_window_to_monitor_left`
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


### `move-window-to-monitor-next`

**Nix Function:** `move_window_to_monitor_next`
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


### `move-window-to-monitor-previous`

**Nix Function:** `move_window_to_monitor_previous`
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


### `move-window-to-monitor-right`

**Nix Function:** `move_window_to_monitor_right`
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


### `move-window-to-monitor-up`

**Nix Function:** `move_window_to_monitor_up`
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


### `move-window-to-tiling`

**Nix Function:** `move_window_to_tiling`
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


### `move-window-up`

**Nix Function:** `move_window_up`
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


### `move-window-up-or-to-workspace-up`

**Nix Function:** `move_window_up_or_to_workspace_up`
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


### `open-overview`

**Nix Function:** `open_overview`
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


### `power-off-monitors`

**Nix Function:** `power_off_monitors`
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


### `power-on-monitors`

**Nix Function:** `power_on_monitors`
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

**Nix Function:** `quit`
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

**Nix Function:** `screenshot`
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


### `screenshot-screen`

**Nix Function:** `screenshot_screen`
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


### `screenshot-window`

**Nix Function:** `screenshot_window`
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


### `set-column-width`

**Nix Function:** `set_column_width`
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


### `show-hotkey-overlay`

**Nix Function:** `show_hotkey_overlay`
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

**Nix Function:** `spawn`
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


### `spawn-sh`

**Nix Function:** `spawn_sh`
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

**Nix Function:** `suspend`
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


### `switch-focus-between-floating-and-tiling`

**Nix Function:** `switch_focus_between_floating_and_tiling`
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


### `toggle-debug-tint`

**Nix Function:** `toggle_debug_tint`
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


### `toggle-keyboard-shortcuts-inhibit`

**Nix Function:** `toggle_keyboard_shortcuts_inhibit`
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


### `toggle-overview`

**Nix Function:** `toggle_overview`
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


### `toggle-window-floating`

**Nix Function:** `toggle_window_floating`
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


### `toggle-windowed-fullscreen`

**Nix Function:** `toggle_windowed_fullscreen`
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

**Generation Info:**
- Generated on: 2025-11-19 19:52:22 UTC
- Niri commit: e0fe1a8b97c303da017906b18cbb53d3eacc354c
- Workflow run: [\#6](https://github.com/soulvice/niri-flake/actions/runs/19514449325)
