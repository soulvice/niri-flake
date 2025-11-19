# Niri Home-Manager Module Documentation

This documentation covers the complete niri home-manager module including all configuration options and available actions.

## Module Overview

The niri module allows you to configure the niri Wayland compositor through Home Manager. The module provides:

- Comprehensive configuration validation through a detailed schema
- A complete actions library for keybindings
- Automatic KDL configuration generation
- Type-safe configuration with helpful error messages

**Module Information:**
- Niri commit: `dfcbbbb03071cadf3fd9bbb0903ead364a839412`
- Repository: `soulvice/niri`
- SHA256: `sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=`

## Module Options

The niri module provides 127 configuration options organized in a hierarchical structure.

#### `_module`

**Type:** unspecified value
**Default:** No default

No description available


#### `animations`

**Type:** null or (submodule)
**Default:** `null`

Animation configuration.

Controls various animations throughout the compositor for smooth visual transitions.


**Sub-options:**
#### `animations._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `animations.config-notification-open-close`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for configuration reload notifications.

Controls how config change notifications appear and disappear.


#### `animations.horizontal-view-movement`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for horizontal workspace/column scrolling.

Controls smoothness when moving between columns or workspaces.


#### `animations.shaders`

**Type:** null or boolean
**Default:** `null`

Whether to use GPU shaders for animations.

Provides smoother animations but may increase GPU usage.


#### `animations.slowdown`

**Type:** null or number between 0.001000 and 100.000000
**Default:** `null`**Example:** `1.000000`

Global animation speed multiplier.

1.0 = normal speed
2.0 = half speed (slower)
0.5 = double speed (faster)


#### `animations.window-close`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for window closure.

Controls how windows animate when being closed.


#### `animations.window-movement`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for window movement between columns.

Controls how smoothly windows animate when moved around.


#### `animations.window-open`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for new window appearance.

Controls how new windows animate when they first appear.


#### `animations.window-resize`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for window resizing.

Controls how smoothly windows animate when being resized.


#### `animations.workspace-switch`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for workspace switching.

Controls how smoothly the view transitions between workspaces.




#### `binds`

**Type:** null or (attribute set of (string or (submodule)))
**Default:** `null`**Example:** `{...}` (attribute set)

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



#### `cursor`

**Type:** null or (submodule)
**Default:** `null`

Mouse cursor appearance configuration.

Controls the visual appearance of the mouse cursor.


**Sub-options:**
#### `cursor._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `cursor.size`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `24`

Cursor size in pixels.

Larger values make the cursor bigger and more visible.


#### `cursor.theme`

**Type:** null or string
**Default:** `null`**Example:** `"Adwaita"`

Cursor theme name.

Must be installed on the system and available in cursor theme directories.




#### `debug`

**Type:** null or (submodule)
**Default:** `null`

Debug and development options.

These options are primarily useful for development and troubleshooting.


**Sub-options:**
#### `debug._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `debug.dbus-interfaces-in-non-session-instances`

**Type:** null or boolean
**Default:** `null`

Enable D-Bus interfaces in non-session instances.

Useful for debugging and testing when niri isn't running as the main session.


#### `debug.emulate-zero-presentation-time`

**Type:** null or boolean
**Default:** `null`

Emulate zero presentation time.

Debugging option for timing-related issues.


#### `debug.enable`

**Type:** null or boolean
**Default:** `null`

Enable debug mode.

Shows additional debugging information and overlays.


#### `debug.enable-color-transformations-capability`

**Type:** null or boolean
**Default:** `null`

Enable color transformation capability.

Experimental feature for advanced color management.


#### `debug.wait-for-frame-completion-before-queueing`

**Type:** null or boolean
**Default:** `null`

Wait for frame completion before queueing next frame.

May reduce performance but can help debug frame timing issues.




#### `environment`

**Type:** null or (attribute set of string)
**Default:** `null`**Example:** `{...}` (attribute set)

Environment variables to set for spawned processes.

These variables will be available to all applications launched by niri.



#### `input`

**Type:** null or (submodule)
**Default:** `null`

Input device configuration.

Controls keyboards, mice, touchpads, tablets, and other input devices.


**Sub-options:**
#### `input._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard`

**Type:** null or (submodule)
**Default:** `null`

Keyboard input configuration

**Sub-options:**
#### `input.keyboard._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.repeat-delay`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `600`

Delay in milliseconds before key repeat starts.

Higher values mean you need to hold a key longer before it starts repeating.


#### `input.keyboard.repeat-rate`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `25`

Key repeat rate in characters per second.

Higher values mean faster key repeat when holding a key.


#### `input.keyboard.track-layout`

**Type:** null or track layout (global, window)
**Default:** `null`

How to track keyboard layout changes.

"global" = same layout for all windows
"window" = remember layout per window


#### `input.keyboard.xkb`

**Type:** null or (submodule)
**Default:** `null`

XKB (X Keyboard Extension) configuration.

Controls keyboard layout, variant, and options.


**Sub-options:**
#### `input.keyboard.xkb._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.xkb.layout`

**Type:** null or string
**Default:** `null`**Example:** `"us,de"`

XKB keyboard layout(s)

#### `input.keyboard.xkb.model`

**Type:** null or string
**Default:** `null`**Example:** `"pc105"`

XKB keyboard model

#### `input.keyboard.xkb.options`

**Type:** null or string
**Default:** `null`**Example:** `"grp:alt\_shift\_toggle,caps:escape"`

XKB options

#### `input.keyboard.xkb.rules`

**Type:** null or string
**Default:** `null`**Example:** `"evdev"`

XKB rules file to use

#### `input.keyboard.xkb.variant`

**Type:** null or string
**Default:** `null`**Example:** `"dvorak"`

XKB layout variant(s)


#### `input.keyboard.xkb._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.xkb.layout`

**Type:** null or string
**Default:** `null`**Example:** `"us,de"`

XKB keyboard layout(s)

#### `input.keyboard.xkb.model`

**Type:** null or string
**Default:** `null`**Example:** `"pc105"`

XKB keyboard model

#### `input.keyboard.xkb.options`

**Type:** null or string
**Default:** `null`**Example:** `"grp:alt\_shift\_toggle,caps:escape"`

XKB options

#### `input.keyboard.xkb.rules`

**Type:** null or string
**Default:** `null`**Example:** `"evdev"`

XKB rules file to use

#### `input.keyboard.xkb.variant`

**Type:** null or string
**Default:** `null`**Example:** `"dvorak"`

XKB layout variant(s)


#### `input.mouse`

**Type:** null or (submodule)
**Default:** `null`

Mouse input configuration

**Sub-options:**
#### `input.mouse._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.mouse.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Mouse acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement


#### `input.mouse.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Mouse acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest


#### `input.mouse.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).



#### `input.tablet`

**Type:** null or (submodule)
**Default:** `null`

Graphics tablet input configuration

**Sub-options:**
#### `input.tablet._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.tablet.map-to-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Map tablet input to specific output.

Must reference an output defined in the outputs section.



#### `input.touch`

**Type:** null or (submodule)
**Default:** `null`

Touchscreen input configuration

**Sub-options:**
#### `input.touch._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.touch.map-to-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"eDP-1"`

Map touch input to specific output.

Must reference an output defined in the outputs section.



#### `input.touchpad`

**Type:** null or (submodule)
**Default:** `null`

Touchpad input configuration

**Sub-options:**
#### `input.touchpad._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.touchpad.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Touchpad acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement


#### `input.touchpad.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.200000`

Touchpad acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest


#### `input.touchpad.click-method`

**Type:** null or click method (clickfinger, button-areas)
**Default:** `null`

Touchpad click method.

"clickfinger" = click location determines button (modern)
"button-areas" = touchpad areas determine button (traditional)


#### `input.touchpad.dwt`

**Type:** null or boolean
**Default:** `null`

Disable touchpad while typing.

Prevents accidental touchpad activation when typing.


#### `input.touchpad.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).


#### `input.touchpad.scroll-method`

**Type:** null or scroll method (no-scroll, two-finger, edge, on-button-down)
**Default:** `null`

Touchpad scroll method.

"two-finger" = scroll with two fingers (most common)
"edge" = scroll by moving along touchpad edge
"on-button-down" = scroll while holding button
"no-scroll" = disable scrolling


#### `input.touchpad.tap`

**Type:** null or boolean
**Default:** `null`

Enable tap-to-click on touchpad.

When enabled, lightly tapping the touchpad will register as a click.


#### `input.touchpad.tap-button-map`

**Type:** null or tap button map (left-right-middle, left-middle-right)
**Default:** `null`

Touchpad tap button mapping.

"left-right-middle" = 1-finger=left, 2-finger=right, 3-finger=middle
"left-middle-right" = 1-finger=left, 2-finger=middle, 3-finger=right



#### `input.trackball`

**Type:** null or (submodule)
**Default:** `null`

Trackball input configuration

**Sub-options:**
#### `input.trackball._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.trackball.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Trackball acceleration profile

#### `input.trackball.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Trackball acceleration speed (-1.0 to 1.0)

#### `input.trackball.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural scrolling for trackball


#### `input.keyboard._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.repeat-delay`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `600`

Delay in milliseconds before key repeat starts.

Higher values mean you need to hold a key longer before it starts repeating.


#### `input.keyboard.repeat-rate`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `25`

Key repeat rate in characters per second.

Higher values mean faster key repeat when holding a key.


#### `input.keyboard.track-layout`

**Type:** null or track layout (global, window)
**Default:** `null`

How to track keyboard layout changes.

"global" = same layout for all windows
"window" = remember layout per window


#### `input.keyboard.xkb`

**Type:** null or (submodule)
**Default:** `null`

XKB (X Keyboard Extension) configuration.

Controls keyboard layout, variant, and options.


**Sub-options:**
#### `input.keyboard.xkb._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.xkb.layout`

**Type:** null or string
**Default:** `null`**Example:** `"us,de"`

XKB keyboard layout(s)

#### `input.keyboard.xkb.model`

**Type:** null or string
**Default:** `null`**Example:** `"pc105"`

XKB keyboard model

#### `input.keyboard.xkb.options`

**Type:** null or string
**Default:** `null`**Example:** `"grp:alt\_shift\_toggle,caps:escape"`

XKB options

#### `input.keyboard.xkb.rules`

**Type:** null or string
**Default:** `null`**Example:** `"evdev"`

XKB rules file to use

#### `input.keyboard.xkb.variant`

**Type:** null or string
**Default:** `null`**Example:** `"dvorak"`

XKB layout variant(s)


#### `input.keyboard.xkb._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.xkb.layout`

**Type:** null or string
**Default:** `null`**Example:** `"us,de"`

XKB keyboard layout(s)

#### `input.keyboard.xkb.model`

**Type:** null or string
**Default:** `null`**Example:** `"pc105"`

XKB keyboard model

#### `input.keyboard.xkb.options`

**Type:** null or string
**Default:** `null`**Example:** `"grp:alt\_shift\_toggle,caps:escape"`

XKB options

#### `input.keyboard.xkb.rules`

**Type:** null or string
**Default:** `null`**Example:** `"evdev"`

XKB rules file to use

#### `input.keyboard.xkb.variant`

**Type:** null or string
**Default:** `null`**Example:** `"dvorak"`

XKB layout variant(s)

#### `input.mouse._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.mouse.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Mouse acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement


#### `input.mouse.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Mouse acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest


#### `input.mouse.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).


#### `input.tablet._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.tablet.map-to-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Map tablet input to specific output.

Must reference an output defined in the outputs section.


#### `input.touch._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.touch.map-to-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"eDP-1"`

Map touch input to specific output.

Must reference an output defined in the outputs section.


#### `input.touchpad._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.touchpad.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Touchpad acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement


#### `input.touchpad.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.200000`

Touchpad acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest


#### `input.touchpad.click-method`

**Type:** null or click method (clickfinger, button-areas)
**Default:** `null`

Touchpad click method.

"clickfinger" = click location determines button (modern)
"button-areas" = touchpad areas determine button (traditional)


#### `input.touchpad.dwt`

**Type:** null or boolean
**Default:** `null`

Disable touchpad while typing.

Prevents accidental touchpad activation when typing.


#### `input.touchpad.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).


#### `input.touchpad.scroll-method`

**Type:** null or scroll method (no-scroll, two-finger, edge, on-button-down)
**Default:** `null`

Touchpad scroll method.

"two-finger" = scroll with two fingers (most common)
"edge" = scroll by moving along touchpad edge
"on-button-down" = scroll while holding button
"no-scroll" = disable scrolling


#### `input.touchpad.tap`

**Type:** null or boolean
**Default:** `null`

Enable tap-to-click on touchpad.

When enabled, lightly tapping the touchpad will register as a click.


#### `input.touchpad.tap-button-map`

**Type:** null or tap button map (left-right-middle, left-middle-right)
**Default:** `null`

Touchpad tap button mapping.

"left-right-middle" = 1-finger=left, 2-finger=right, 3-finger=middle
"left-middle-right" = 1-finger=left, 2-finger=middle, 3-finger=right


#### `input.trackball._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.trackball.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Trackball acceleration profile

#### `input.trackball.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Trackball acceleration speed (-1.0 to 1.0)

#### `input.trackball.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural scrolling for trackball



#### `layout`

**Type:** null or (submodule)
**Default:** `null`

Window layout and visual configuration.

Controls window positioning, spacing, borders, and visual indicators.


**Sub-options:**
#### `layout._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.always-center-single-column`

**Type:** null or boolean
**Default:** `null`

Whether to center single columns on the screen.

When only one column is present, center it instead of placing it at the left edge.


#### `layout.border`

**Type:** null or (submodule)
**Default:** `null`

Window border configuration

**Sub-options:**
#### `layout.border._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.border.active-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#ffffff"`

Border color for the active window

#### `layout.border.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show borders around windows.

Persistent borders around all windows, separate from focus rings.


#### `layout.border.inactive-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#808080"`

Border color for inactive windows

#### `layout.border.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `2`

Window border width in pixels


#### `layout.center-focused-column`

**Type:** null or center focused column (never, always, on-overflow)
**Default:** `null`

When to center the focused column on screen.

"never" = never center columns
"always" = always center the focused column
"on-overflow" = center only when columns don't fit on screen


#### `layout.default-column-width`

**Type:** null or (submodule)
**Default:** `null`

Default width for new columns.

Can be specified as either a proportion of screen width or fixed pixels.
Only one of proportion or fixed should be set.


**Sub-options:**
#### `layout.default-column-width._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.default-column-width.fixed`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `1920`

Default column width in pixels.

Fixed pixel width regardless of screen size.


#### `layout.default-column-width.proportion`

**Type:** null or number between 0.100000 and 10.000000
**Default:** `null`**Example:** `0.500000`

Default column width as proportion of screen width.

1.0 = full screen width
0.5 = half screen width
Values > 1.0 create wider-than-screen columns



#### `layout.focus-ring`

**Type:** null or (submodule)
**Default:** `null`

Focus ring visual indicator configuration.

Shows a colored border around focused windows.


**Sub-options:**
#### `layout.focus-ring._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.focus-ring.active-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#7fc8ff"`

Color or gradient for the active window focus ring.

Can be a solid color or a gradient for visual effects.


#### `layout.focus-ring.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show a focus ring around the active window.

Visual indicator to highlight which window has focus.


#### `layout.focus-ring.inactive-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#505050"`

Color or gradient for inactive window focus rings.

Used for non-focused windows when they have visible focus indicators.


#### `layout.focus-ring.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `4`

Focus ring width in pixels.

Thickness of the border drawn around the focused window.



#### `layout.gaps`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `16`

Gap size in pixels between windows and screen edges.

Sets uniform gaps around all windows for a clean, spaced look.


#### `layout.preset-column-widths`

**Type:** null or (list of preset size (proportion 0.0-1.0 or fixed pixels))
**Default:** `null`**Example:** `[...]` (list with 4 items)

Predefined column widths for quick switching.

List of widths that can be cycled through with keybindings.
Values can be proportions (0.0-1.0) or fixed pixel sizes.


#### `layout.struts`

**Type:** null or (submodule)
**Default:** `null`

Reserved screen edge space.

Prevents windows from using specified screen areas, useful for panels/docks.


**Sub-options:**
#### `layout.struts._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.struts.bottom`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on bottom edge in pixels

#### `layout.struts.left`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on left edge in pixels

#### `layout.struts.right`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on right edge in pixels

#### `layout.struts.top`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on top edge in pixels


#### `layout.border._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.border.active-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#ffffff"`

Border color for the active window

#### `layout.border.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show borders around windows.

Persistent borders around all windows, separate from focus rings.


#### `layout.border.inactive-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#808080"`

Border color for inactive windows

#### `layout.border.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `2`

Window border width in pixels

#### `layout.default-column-width._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.default-column-width.fixed`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `1920`

Default column width in pixels.

Fixed pixel width regardless of screen size.


#### `layout.default-column-width.proportion`

**Type:** null or number between 0.100000 and 10.000000
**Default:** `null`**Example:** `0.500000`

Default column width as proportion of screen width.

1.0 = full screen width
0.5 = half screen width
Values > 1.0 create wider-than-screen columns


#### `layout.focus-ring._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.focus-ring.active-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#7fc8ff"`

Color or gradient for the active window focus ring.

Can be a solid color or a gradient for visual effects.


#### `layout.focus-ring.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show a focus ring around the active window.

Visual indicator to highlight which window has focus.


#### `layout.focus-ring.inactive-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#505050"`

Color or gradient for inactive window focus rings.

Used for non-focused windows when they have visible focus indicators.


#### `layout.focus-ring.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `4`

Focus ring width in pixels.

Thickness of the border drawn around the focused window.


#### `layout.struts._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.struts.bottom`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on bottom edge in pixels

#### `layout.struts.left`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on left edge in pixels

#### `layout.struts.right`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on right edge in pixels

#### `layout.struts.top`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on top edge in pixels



#### `outputs`

**Type:** null or (list of (submodule))
**Default:** `null`**Example:** `[...]` (list with 2 items)

Display output configuration.

Configure connected monitors/displays including resolution, scaling, and positioning.
Use `niri msg outputs` to see available outputs.


**Sub-options:**
#### `outputs._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `outputs.mode`

**Type:** null or (submodule)
**Default:** `null`

Display mode configuration.

If not specified, niri will use the preferred mode from EDID.


**Sub-options:**
#### `outputs.mode._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `outputs.mode.height`

**Type:** positive integer, meaning >0
**Default:** No default**Example:** `1080`

Display height in pixels

#### `outputs.mode.refresh`

**Type:** null or number between 1 and 1000
**Default:** `null`**Example:** `144.000000`

Refresh rate in Hz

#### `outputs.mode.width`

**Type:** positive integer, meaning >0
**Default:** No default**Example:** `1920`

Display width in pixels


#### `outputs.name`

**Type:** output (monitor) name
**Default:** No default**Example:** `"DP-1"`

Output connector name.

Use `niri msg outputs` or check system logs to find available output names.
Common examples: "DP-1", "HDMI-A-1", "eDP-1"


#### `outputs.position`

**Type:** null or (submodule)
**Default:** `null`

Output position in the global coordinate space.

Used for multi-monitor setups to specify monitor arrangement.
If not specified, niri will arrange outputs automatically.


**Sub-options:**
#### `outputs.position._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `outputs.position.x`

**Type:** integer
**Default:** No default**Example:** `1920`

Horizontal position in pixels

#### `outputs.position.y`

**Type:** integer
**Default:** No default**Example:** `0`

Vertical position in pixels


#### `outputs.scale`

**Type:** null or number between 0.100000 and 10.000000
**Default:** `null`**Example:** `1.500000`

Display scaling factor.

1.0 = no scaling (100%)
2.0 = 2x scaling (200%)
1.5 = 1.5x scaling (150%)

Higher values make UI elements larger for high-DPI displays.


#### `outputs.transform`

**Type:** null or transform (normal, 90, 180, 270, flipped, flipped-90, flipped-180, flipped-270)
**Default:** `null`

Display rotation and reflection.

"normal" = no rotation
"90", "180", "270" = clockwise rotation in degrees
"flipped-*" = mirror horizontally then rotate


#### `outputs.mode._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `outputs.mode.height`

**Type:** positive integer, meaning >0
**Default:** No default**Example:** `1080`

Display height in pixels

#### `outputs.mode.refresh`

**Type:** null or number between 1 and 1000
**Default:** `null`**Example:** `144.000000`

Refresh rate in Hz

#### `outputs.mode.width`

**Type:** positive integer, meaning >0
**Default:** No default**Example:** `1920`

Display width in pixels

#### `outputs.position._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `outputs.position.x`

**Type:** integer
**Default:** No default**Example:** `1920`

Horizontal position in pixels

#### `outputs.position.y`

**Type:** integer
**Default:** No default**Example:** `0`

Vertical position in pixels



#### `prefer-no-csd`

**Type:** null or boolean
**Default:** `null`

Whether to prefer server-side decorations over client-side.

When true, asks applications to use server-side window decorations
instead of drawing their own title bars and borders.



#### `screenshot-path`

**Type:** null or string
**Default:** `null`**Example:** `"~/Screenshots"`

Directory path for saving screenshots.

Screenshots taken with niri will be saved to this directory.
If not specified, uses the default Pictures directory.



#### `spawn-at-startup`

**Type:** null or (list of string)
**Default:** `null`**Example:** `[...]` (list with 3 items)

Commands to run when niri starts.

List of shell commands that will be executed during niri initialization.
Useful for starting essential applications like status bars, notification daemons, etc.



#### `window-rules`

**Type:** null or (list of (submodule))
**Default:** `null`**Example:** `[...]` (list with 2 items)

Per-window behavior rules.

Configure how specific windows should behave based on their properties.
Rules are evaluated in order, and the first matching rule applies.


**Sub-options:**
#### `window-rules._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `window-rules.app-id`

**Type:** null or regular expression
**Default:** `null`**Example:** `"^firefox$"`

Match windows by their application ID (Wayland) or WM_CLASS (X11).

Supports regular expressions for flexible matching.


#### `window-rules.block-out-from`

**Type:** null or one of "screencast", "screen-capture"
**Default:** `null`

Block this window from appearing in screencasts or screenshots.

Useful for sensitive windows like password managers.


#### `window-rules.is-active`

**Type:** null or boolean
**Default:** `null`

Match only the currently active window.

Useful for rules that should only apply to focused windows.


#### `window-rules.is-floating`

**Type:** null or boolean
**Default:** `null`

Match only floating or tiling windows.

true = floating windows only
false = tiling windows only
null = both floating and tiling


#### `window-rules.opacity`

**Type:** null or number between 0.000000 and 1.000000
**Default:** `null`**Example:** `0.900000`

Window opacity/transparency level.

0.0 = fully transparent
1.0 = fully opaque


#### `window-rules.open-floating`

**Type:** null or boolean
**Default:** `null`

Whether to open this window as floating.

true = always floating
false = always tiling
null = use default behavior


#### `window-rules.open-fullscreen`

**Type:** null or boolean
**Default:** `null`

Whether to open this window in fullscreen mode.


#### `window-rules.open-maximized`

**Type:** null or boolean
**Default:** `null`

Whether to open this window maximized.

Only applies to tiling windows.


#### `window-rules.open-on-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Which output (monitor) to open this window on.

Must reference an output defined in the outputs section.


#### `window-rules.open-on-workspace`

**Type:** null or workspace name
**Default:** `null`**Example:** `"main"`

Which workspace to open this window on.

Must reference a workspace defined in the workspaces section.


#### `window-rules.title`

**Type:** null or regular expression
**Default:** `null`**Example:** `".\*YouTube.\*"`

Match windows by their title/name.

Supports regular expressions for flexible matching.




#### `workspaces`

**Type:** null or (list of (submodule))
**Default:** `null`**Example:** `[...]` (list with 3 items)

Workspace definitions.

Define named workspaces that can be referenced in window rules and keybindings.


**Sub-options:**
#### `workspaces._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `workspaces.name`

**Type:** workspace name
**Default:** No default**Example:** `"main"`

Workspace name/identifier

#### `workspaces.open-on-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Which output this workspace should open on.

Must reference an output defined in the outputs section.




#### `animations._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `animations.config-notification-open-close`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for configuration reload notifications.

Controls how config change notifications appear and disappear.



#### `animations.horizontal-view-movement`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for horizontal workspace/column scrolling.

Controls smoothness when moving between columns or workspaces.



#### `animations.shaders`

**Type:** null or boolean
**Default:** `null`

Whether to use GPU shaders for animations.

Provides smoother animations but may increase GPU usage.



#### `animations.slowdown`

**Type:** null or number between 0.001000 and 100.000000
**Default:** `null`**Example:** `1.000000`

Global animation speed multiplier.

1.0 = normal speed
2.0 = half speed (slower)
0.5 = double speed (faster)



#### `animations.window-close`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for window closure.

Controls how windows animate when being closed.



#### `animations.window-movement`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for window movement between columns.

Controls how smoothly windows animate when moved around.



#### `animations.window-open`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for new window appearance.

Controls how new windows animate when they first appear.



#### `animations.window-resize`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for window resizing.

Controls how smoothly windows animate when being resized.



#### `animations.workspace-switch`

**Type:** null or animation (off, spring, or easing)
**Default:** `null`

Animation for workspace switching.

Controls how smoothly the view transitions between workspaces.



#### `cursor._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `cursor.size`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `24`

Cursor size in pixels.

Larger values make the cursor bigger and more visible.



#### `cursor.theme`

**Type:** null or string
**Default:** `null`**Example:** `"Adwaita"`

Cursor theme name.

Must be installed on the system and available in cursor theme directories.



#### `debug._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `debug.dbus-interfaces-in-non-session-instances`

**Type:** null or boolean
**Default:** `null`

Enable D-Bus interfaces in non-session instances.

Useful for debugging and testing when niri isn't running as the main session.



#### `debug.emulate-zero-presentation-time`

**Type:** null or boolean
**Default:** `null`

Emulate zero presentation time.

Debugging option for timing-related issues.



#### `debug.enable`

**Type:** null or boolean
**Default:** `null`

Enable debug mode.

Shows additional debugging information and overlays.



#### `debug.enable-color-transformations-capability`

**Type:** null or boolean
**Default:** `null`

Enable color transformation capability.

Experimental feature for advanced color management.



#### `debug.wait-for-frame-completion-before-queueing`

**Type:** null or boolean
**Default:** `null`

Wait for frame completion before queueing next frame.

May reduce performance but can help debug frame timing issues.



#### `input._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `input.keyboard`

**Type:** null or (submodule)
**Default:** `null`

Keyboard input configuration

**Sub-options:**
#### `input.keyboard._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.repeat-delay`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `600`

Delay in milliseconds before key repeat starts.

Higher values mean you need to hold a key longer before it starts repeating.


#### `input.keyboard.repeat-rate`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `25`

Key repeat rate in characters per second.

Higher values mean faster key repeat when holding a key.


#### `input.keyboard.track-layout`

**Type:** null or track layout (global, window)
**Default:** `null`

How to track keyboard layout changes.

"global" = same layout for all windows
"window" = remember layout per window


#### `input.keyboard.xkb`

**Type:** null or (submodule)
**Default:** `null`

XKB (X Keyboard Extension) configuration.

Controls keyboard layout, variant, and options.


**Sub-options:**
#### `input.keyboard.xkb._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.xkb.layout`

**Type:** null or string
**Default:** `null`**Example:** `"us,de"`

XKB keyboard layout(s)

#### `input.keyboard.xkb.model`

**Type:** null or string
**Default:** `null`**Example:** `"pc105"`

XKB keyboard model

#### `input.keyboard.xkb.options`

**Type:** null or string
**Default:** `null`**Example:** `"grp:alt\_shift\_toggle,caps:escape"`

XKB options

#### `input.keyboard.xkb.rules`

**Type:** null or string
**Default:** `null`**Example:** `"evdev"`

XKB rules file to use

#### `input.keyboard.xkb.variant`

**Type:** null or string
**Default:** `null`**Example:** `"dvorak"`

XKB layout variant(s)


#### `input.keyboard.xkb._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.xkb.layout`

**Type:** null or string
**Default:** `null`**Example:** `"us,de"`

XKB keyboard layout(s)

#### `input.keyboard.xkb.model`

**Type:** null or string
**Default:** `null`**Example:** `"pc105"`

XKB keyboard model

#### `input.keyboard.xkb.options`

**Type:** null or string
**Default:** `null`**Example:** `"grp:alt\_shift\_toggle,caps:escape"`

XKB options

#### `input.keyboard.xkb.rules`

**Type:** null or string
**Default:** `null`**Example:** `"evdev"`

XKB rules file to use

#### `input.keyboard.xkb.variant`

**Type:** null or string
**Default:** `null`**Example:** `"dvorak"`

XKB layout variant(s)



#### `input.mouse`

**Type:** null or (submodule)
**Default:** `null`

Mouse input configuration

**Sub-options:**
#### `input.mouse._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.mouse.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Mouse acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement


#### `input.mouse.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Mouse acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest


#### `input.mouse.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).




#### `input.tablet`

**Type:** null or (submodule)
**Default:** `null`

Graphics tablet input configuration

**Sub-options:**
#### `input.tablet._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.tablet.map-to-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Map tablet input to specific output.

Must reference an output defined in the outputs section.




#### `input.touch`

**Type:** null or (submodule)
**Default:** `null`

Touchscreen input configuration

**Sub-options:**
#### `input.touch._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.touch.map-to-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"eDP-1"`

Map touch input to specific output.

Must reference an output defined in the outputs section.




#### `input.touchpad`

**Type:** null or (submodule)
**Default:** `null`

Touchpad input configuration

**Sub-options:**
#### `input.touchpad._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.touchpad.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Touchpad acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement


#### `input.touchpad.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.200000`

Touchpad acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest


#### `input.touchpad.click-method`

**Type:** null or click method (clickfinger, button-areas)
**Default:** `null`

Touchpad click method.

"clickfinger" = click location determines button (modern)
"button-areas" = touchpad areas determine button (traditional)


#### `input.touchpad.dwt`

**Type:** null or boolean
**Default:** `null`

Disable touchpad while typing.

Prevents accidental touchpad activation when typing.


#### `input.touchpad.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).


#### `input.touchpad.scroll-method`

**Type:** null or scroll method (no-scroll, two-finger, edge, on-button-down)
**Default:** `null`

Touchpad scroll method.

"two-finger" = scroll with two fingers (most common)
"edge" = scroll by moving along touchpad edge
"on-button-down" = scroll while holding button
"no-scroll" = disable scrolling


#### `input.touchpad.tap`

**Type:** null or boolean
**Default:** `null`

Enable tap-to-click on touchpad.

When enabled, lightly tapping the touchpad will register as a click.


#### `input.touchpad.tap-button-map`

**Type:** null or tap button map (left-right-middle, left-middle-right)
**Default:** `null`

Touchpad tap button mapping.

"left-right-middle" = 1-finger=left, 2-finger=right, 3-finger=middle
"left-middle-right" = 1-finger=left, 2-finger=middle, 3-finger=right




#### `input.trackball`

**Type:** null or (submodule)
**Default:** `null`

Trackball input configuration

**Sub-options:**
#### `input.trackball._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.trackball.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Trackball acceleration profile

#### `input.trackball.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Trackball acceleration speed (-1.0 to 1.0)

#### `input.trackball.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural scrolling for trackball



#### `input.keyboard._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `input.keyboard.repeat-delay`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `600`

Delay in milliseconds before key repeat starts.

Higher values mean you need to hold a key longer before it starts repeating.



#### `input.keyboard.repeat-rate`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `25`

Key repeat rate in characters per second.

Higher values mean faster key repeat when holding a key.



#### `input.keyboard.track-layout`

**Type:** null or track layout (global, window)
**Default:** `null`

How to track keyboard layout changes.

"global" = same layout for all windows
"window" = remember layout per window



#### `input.keyboard.xkb`

**Type:** null or (submodule)
**Default:** `null`

XKB (X Keyboard Extension) configuration.

Controls keyboard layout, variant, and options.


**Sub-options:**
#### `input.keyboard.xkb._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `input.keyboard.xkb.layout`

**Type:** null or string
**Default:** `null`**Example:** `"us,de"`

XKB keyboard layout(s)

#### `input.keyboard.xkb.model`

**Type:** null or string
**Default:** `null`**Example:** `"pc105"`

XKB keyboard model

#### `input.keyboard.xkb.options`

**Type:** null or string
**Default:** `null`**Example:** `"grp:alt\_shift\_toggle,caps:escape"`

XKB options

#### `input.keyboard.xkb.rules`

**Type:** null or string
**Default:** `null`**Example:** `"evdev"`

XKB rules file to use

#### `input.keyboard.xkb.variant`

**Type:** null or string
**Default:** `null`**Example:** `"dvorak"`

XKB layout variant(s)



#### `input.keyboard.xkb._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `input.keyboard.xkb.layout`

**Type:** null or string
**Default:** `null`**Example:** `"us,de"`

XKB keyboard layout(s)


#### `input.keyboard.xkb.model`

**Type:** null or string
**Default:** `null`**Example:** `"pc105"`

XKB keyboard model


#### `input.keyboard.xkb.options`

**Type:** null or string
**Default:** `null`**Example:** `"grp:alt\_shift\_toggle,caps:escape"`

XKB options


#### `input.keyboard.xkb.rules`

**Type:** null or string
**Default:** `null`**Example:** `"evdev"`

XKB rules file to use


#### `input.keyboard.xkb.variant`

**Type:** null or string
**Default:** `null`**Example:** `"dvorak"`

XKB layout variant(s)


#### `input.mouse._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `input.mouse.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Mouse acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement



#### `input.mouse.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Mouse acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest



#### `input.mouse.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).



#### `input.tablet._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `input.tablet.map-to-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Map tablet input to specific output.

Must reference an output defined in the outputs section.



#### `input.touch._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `input.touch.map-to-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"eDP-1"`

Map touch input to specific output.

Must reference an output defined in the outputs section.



#### `input.touchpad._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `input.touchpad.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Touchpad acceleration profile.

"adaptive" = cursor speed adapts to movement speed
"flat" = constant cursor speed regardless of movement



#### `input.touchpad.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.200000`

Touchpad acceleration speed.

-1.0 = slowest
 0.0 = default
 1.0 = fastest



#### `input.touchpad.click-method`

**Type:** null or click method (clickfinger, button-areas)
**Default:** `null`

Touchpad click method.

"clickfinger" = click location determines button (modern)
"button-areas" = touchpad areas determine button (traditional)



#### `input.touchpad.dwt`

**Type:** null or boolean
**Default:** `null`

Disable touchpad while typing.

Prevents accidental touchpad activation when typing.



#### `input.touchpad.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural (reversed) scrolling direction.

Scrolling down moves content down (like on mobile devices).



#### `input.touchpad.scroll-method`

**Type:** null or scroll method (no-scroll, two-finger, edge, on-button-down)
**Default:** `null`

Touchpad scroll method.

"two-finger" = scroll with two fingers (most common)
"edge" = scroll by moving along touchpad edge
"on-button-down" = scroll while holding button
"no-scroll" = disable scrolling



#### `input.touchpad.tap`

**Type:** null or boolean
**Default:** `null`

Enable tap-to-click on touchpad.

When enabled, lightly tapping the touchpad will register as a click.



#### `input.touchpad.tap-button-map`

**Type:** null or tap button map (left-right-middle, left-middle-right)
**Default:** `null`

Touchpad tap button mapping.

"left-right-middle" = 1-finger=left, 2-finger=right, 3-finger=middle
"left-middle-right" = 1-finger=left, 2-finger=middle, 3-finger=right



#### `input.trackball._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `input.trackball.accel-profile`

**Type:** null or acceleration profile (adaptive, flat)
**Default:** `null`

Trackball acceleration profile


#### `input.trackball.accel-speed`

**Type:** null or number between -1.000000 and 1.000000
**Default:** `null`**Example:** `0.000000`

Trackball acceleration speed (-1.0 to 1.0)


#### `input.trackball.natural-scroll`

**Type:** null or boolean
**Default:** `null`

Enable natural scrolling for trackball


#### `layout._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `layout.always-center-single-column`

**Type:** null or boolean
**Default:** `null`

Whether to center single columns on the screen.

When only one column is present, center it instead of placing it at the left edge.



#### `layout.border`

**Type:** null or (submodule)
**Default:** `null`

Window border configuration

**Sub-options:**
#### `layout.border._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.border.active-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#ffffff"`

Border color for the active window

#### `layout.border.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show borders around windows.

Persistent borders around all windows, separate from focus rings.


#### `layout.border.inactive-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#808080"`

Border color for inactive windows

#### `layout.border.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `2`

Window border width in pixels



#### `layout.center-focused-column`

**Type:** null or center focused column (never, always, on-overflow)
**Default:** `null`

When to center the focused column on screen.

"never" = never center columns
"always" = always center the focused column
"on-overflow" = center only when columns don't fit on screen



#### `layout.default-column-width`

**Type:** null or (submodule)
**Default:** `null`

Default width for new columns.

Can be specified as either a proportion of screen width or fixed pixels.
Only one of proportion or fixed should be set.


**Sub-options:**
#### `layout.default-column-width._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.default-column-width.fixed`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `1920`

Default column width in pixels.

Fixed pixel width regardless of screen size.


#### `layout.default-column-width.proportion`

**Type:** null or number between 0.100000 and 10.000000
**Default:** `null`**Example:** `0.500000`

Default column width as proportion of screen width.

1.0 = full screen width
0.5 = half screen width
Values > 1.0 create wider-than-screen columns




#### `layout.focus-ring`

**Type:** null or (submodule)
**Default:** `null`

Focus ring visual indicator configuration.

Shows a colored border around focused windows.


**Sub-options:**
#### `layout.focus-ring._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.focus-ring.active-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#7fc8ff"`

Color or gradient for the active window focus ring.

Can be a solid color or a gradient for visual effects.


#### `layout.focus-ring.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show a focus ring around the active window.

Visual indicator to highlight which window has focus.


#### `layout.focus-ring.inactive-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#505050"`

Color or gradient for inactive window focus rings.

Used for non-focused windows when they have visible focus indicators.


#### `layout.focus-ring.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `4`

Focus ring width in pixels.

Thickness of the border drawn around the focused window.




#### `layout.gaps`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `16`

Gap size in pixels between windows and screen edges.

Sets uniform gaps around all windows for a clean, spaced look.



#### `layout.preset-column-widths`

**Type:** null or (list of preset size (proportion 0.0-1.0 or fixed pixels))
**Default:** `null`**Example:** `[...]` (list with 4 items)

Predefined column widths for quick switching.

List of widths that can be cycled through with keybindings.
Values can be proportions (0.0-1.0) or fixed pixel sizes.



#### `layout.struts`

**Type:** null or (submodule)
**Default:** `null`

Reserved screen edge space.

Prevents windows from using specified screen areas, useful for panels/docks.


**Sub-options:**
#### `layout.struts._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `layout.struts.bottom`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on bottom edge in pixels

#### `layout.struts.left`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on left edge in pixels

#### `layout.struts.right`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on right edge in pixels

#### `layout.struts.top`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on top edge in pixels



#### `layout.border._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `layout.border.active-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#ffffff"`

Border color for the active window


#### `layout.border.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show borders around windows.

Persistent borders around all windows, separate from focus rings.



#### `layout.border.inactive-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#808080"`

Border color for inactive windows


#### `layout.border.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `2`

Window border width in pixels


#### `layout.default-column-width._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `layout.default-column-width.fixed`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `1920`

Default column width in pixels.

Fixed pixel width regardless of screen size.



#### `layout.default-column-width.proportion`

**Type:** null or number between 0.100000 and 10.000000
**Default:** `null`**Example:** `0.500000`

Default column width as proportion of screen width.

1.0 = full screen width
0.5 = half screen width
Values > 1.0 create wider-than-screen columns



#### `layout.focus-ring._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `layout.focus-ring.active-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#7fc8ff"`

Color or gradient for the active window focus ring.

Can be a solid color or a gradient for visual effects.



#### `layout.focus-ring.enable`

**Type:** null or boolean
**Default:** `null`

Whether to show a focus ring around the active window.

Visual indicator to highlight which window has focus.



#### `layout.focus-ring.inactive-color`

**Type:** null or color (hex, CSS name, or rgb/rgba function) or color gradient
**Default:** `null`**Example:** `"#505050"`

Color or gradient for inactive window focus rings.

Used for non-focused windows when they have visible focus indicators.



#### `layout.focus-ring.width`

**Type:** null or (positive integer, meaning >0)
**Default:** `null`**Example:** `4`

Focus ring width in pixels.

Thickness of the border drawn around the focused window.



#### `layout.struts._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `layout.struts.bottom`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on bottom edge in pixels


#### `layout.struts.left`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on left edge in pixels


#### `layout.struts.right`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `64`

Reserved space on right edge in pixels


#### `layout.struts.top`

**Type:** null or (unsigned integer, meaning >=0)
**Default:** `null`**Example:** `32`

Reserved space on top edge in pixels


#### `outputs._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `outputs.mode`

**Type:** null or (submodule)
**Default:** `null`

Display mode configuration.

If not specified, niri will use the preferred mode from EDID.


**Sub-options:**
#### `outputs.mode._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `outputs.mode.height`

**Type:** positive integer, meaning >0
**Default:** No default**Example:** `1080`

Display height in pixels

#### `outputs.mode.refresh`

**Type:** null or number between 1 and 1000
**Default:** `null`**Example:** `144.000000`

Refresh rate in Hz

#### `outputs.mode.width`

**Type:** positive integer, meaning >0
**Default:** No default**Example:** `1920`

Display width in pixels



#### `outputs.name`

**Type:** output (monitor) name
**Default:** No default**Example:** `"DP-1"`

Output connector name.

Use `niri msg outputs` or check system logs to find available output names.
Common examples: "DP-1", "HDMI-A-1", "eDP-1"



#### `outputs.position`

**Type:** null or (submodule)
**Default:** `null`

Output position in the global coordinate space.

Used for multi-monitor setups to specify monitor arrangement.
If not specified, niri will arrange outputs automatically.


**Sub-options:**
#### `outputs.position._module`

**Type:** unspecified value
**Default:** No default

No description available

#### `outputs.position.x`

**Type:** integer
**Default:** No default**Example:** `1920`

Horizontal position in pixels

#### `outputs.position.y`

**Type:** integer
**Default:** No default**Example:** `0`

Vertical position in pixels



#### `outputs.scale`

**Type:** null or number between 0.100000 and 10.000000
**Default:** `null`**Example:** `1.500000`

Display scaling factor.

1.0 = no scaling (100%)
2.0 = 2x scaling (200%)
1.5 = 1.5x scaling (150%)

Higher values make UI elements larger for high-DPI displays.



#### `outputs.transform`

**Type:** null or transform (normal, 90, 180, 270, flipped, flipped-90, flipped-180, flipped-270)
**Default:** `null`

Display rotation and reflection.

"normal" = no rotation
"90", "180", "270" = clockwise rotation in degrees
"flipped-*" = mirror horizontally then rotate



#### `outputs.mode._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `outputs.mode.height`

**Type:** positive integer, meaning >0
**Default:** No default**Example:** `1080`

Display height in pixels


#### `outputs.mode.refresh`

**Type:** null or number between 1 and 1000
**Default:** `null`**Example:** `144.000000`

Refresh rate in Hz


#### `outputs.mode.width`

**Type:** positive integer, meaning >0
**Default:** No default**Example:** `1920`

Display width in pixels


#### `outputs.position._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `outputs.position.x`

**Type:** integer
**Default:** No default**Example:** `1920`

Horizontal position in pixels


#### `outputs.position.y`

**Type:** integer
**Default:** No default**Example:** `0`

Vertical position in pixels


#### `window-rules._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `window-rules.app-id`

**Type:** null or regular expression
**Default:** `null`**Example:** `"^firefox$"`

Match windows by their application ID (Wayland) or WM_CLASS (X11).

Supports regular expressions for flexible matching.



#### `window-rules.block-out-from`

**Type:** null or one of "screencast", "screen-capture"
**Default:** `null`

Block this window from appearing in screencasts or screenshots.

Useful for sensitive windows like password managers.



#### `window-rules.is-active`

**Type:** null or boolean
**Default:** `null`

Match only the currently active window.

Useful for rules that should only apply to focused windows.



#### `window-rules.is-floating`

**Type:** null or boolean
**Default:** `null`

Match only floating or tiling windows.

true = floating windows only
false = tiling windows only
null = both floating and tiling



#### `window-rules.opacity`

**Type:** null or number between 0.000000 and 1.000000
**Default:** `null`**Example:** `0.900000`

Window opacity/transparency level.

0.0 = fully transparent
1.0 = fully opaque



#### `window-rules.open-floating`

**Type:** null or boolean
**Default:** `null`

Whether to open this window as floating.

true = always floating
false = always tiling
null = use default behavior



#### `window-rules.open-fullscreen`

**Type:** null or boolean
**Default:** `null`

Whether to open this window in fullscreen mode.



#### `window-rules.open-maximized`

**Type:** null or boolean
**Default:** `null`

Whether to open this window maximized.

Only applies to tiling windows.



#### `window-rules.open-on-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Which output (monitor) to open this window on.

Must reference an output defined in the outputs section.



#### `window-rules.open-on-workspace`

**Type:** null or workspace name
**Default:** `null`**Example:** `"main"`

Which workspace to open this window on.

Must reference a workspace defined in the workspaces section.



#### `window-rules.title`

**Type:** null or regular expression
**Default:** `null`**Example:** `".\*YouTube.\*"`

Match windows by their title/name.

Supports regular expressions for flexible matching.



#### `workspaces._module`

**Type:** unspecified value
**Default:** No default

No description available


#### `workspaces.name`

**Type:** workspace name
**Default:** No default**Example:** `"main"`

Workspace name/identifier


#### `workspaces.open-on-output`

**Type:** null or output (monitor) name
**Default:** `null`**Example:** `"DP-1"`

Which output this workspace should open on.

Must reference an output defined in the outputs section.




## Actions Library

The niri module provides 87 built-in actions for window management, workspace navigation, and system control. All actions are available through `config.lib.niri.actions`.

### Available Actions (87 total)

### `center_column`

**Nix Function:** `center_column`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = center_column;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="center_column"
}
```


### `center_visible_columns`

**Nix Function:** `center_visible_columns`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = center_visible_columns;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="center_visible_columns"
}
```


### `center_window`

**Nix Function:** `center_window`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = center_window;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="center_window"
}
```


### `close_overview`

**Nix Function:** `close_overview`
**Description:** Close the focused window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = close_overview;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="close_overview"
}
```


### `close_window`

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
    bind "Mod+Key" action="close_window"
}
```


### `debug_toggle_damage`

**Nix Function:** `debug_toggle_damage`
**Description:** Debug and development action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = debug_toggle_damage;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="debug_toggle_damage"
}
```


### `debug_toggle_opaque_regions`

**Nix Function:** `debug_toggle_opaque_regions`
**Description:** Debug and development action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = debug_toggle_opaque_regions;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="debug_toggle_opaque_regions"
}
```


### `do_screen_transition`

**Nix Function:** `do_screen_transition`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = do_screen_transition;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="do_screen_transition"
}
```


### `expand_column_to_available_width`

**Nix Function:** `expand_column_to_available_width`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = expand_column_to_available_width;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="expand_column_to_available_width"
}
```


### `focus_column`

**Nix Function:** `focus_column`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_column"
}
```


### `focus_column_first`

**Nix Function:** `focus_column_first`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_first;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_column_first"
}
```


### `focus_column_last`

**Nix Function:** `focus_column_last`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_last;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_column_last"
}
```


### `focus_column_left`

**Nix Function:** `focus_column_left`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_column_left"
}
```


### `focus_column_left_or_last`

**Nix Function:** `focus_column_left_or_last`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_left_or_last;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_column_left_or_last"
}
```


### `focus_column_or_monitor_left`

**Nix Function:** `focus_column_or_monitor_left`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_or_monitor_left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_column_or_monitor_left"
}
```


### `focus_column_or_monitor_right`

**Nix Function:** `focus_column_or_monitor_right`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_or_monitor_right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_column_or_monitor_right"
}
```


### `focus_column_right`

**Nix Function:** `focus_column_right`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_column_right"
}
```


### `focus_column_right_or_first`

**Nix Function:** `focus_column_right_or_first`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_column_right_or_first;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_column_right_or_first"
}
```


### `focus_floating`

**Nix Function:** `focus_floating`
**Description:** Focus navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_floating;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_floating"
}
```


### `focus_monitor`

**Nix Function:** `focus_monitor`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_monitor"
}
```


### `focus_monitor_down`

**Nix Function:** `focus_monitor_down`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_monitor_down"
}
```


### `focus_monitor_left`

**Nix Function:** `focus_monitor_left`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_monitor_left"
}
```


### `focus_monitor_next`

**Nix Function:** `focus_monitor_next`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_next;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_monitor_next"
}
```


### `focus_monitor_previous`

**Nix Function:** `focus_monitor_previous`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_previous;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_monitor_previous"
}
```


### `focus_monitor_right`

**Nix Function:** `focus_monitor_right`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_monitor_right"
}
```


### `focus_monitor_up`

**Nix Function:** `focus_monitor_up`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_monitor_up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_monitor_up"
}
```


### `focus_tiling`

**Nix Function:** `focus_tiling`
**Description:** Focus navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_tiling;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_tiling"
}
```


### `focus_window_bottom`

**Nix Function:** `focus_window_bottom`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_bottom;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_bottom"
}
```


### `focus_window_down`

**Nix Function:** `focus_window_down`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_down"
}
```


### `focus_window_down_or_column_left`

**Nix Function:** `focus_window_down_or_column_left`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_down_or_column_left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_down_or_column_left"
}
```


### `focus_window_down_or_column_right`

**Nix Function:** `focus_window_down_or_column_right`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_down_or_column_right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_down_or_column_right"
}
```


### `focus_window_down_or_top`

**Nix Function:** `focus_window_down_or_top`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_down_or_top;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_down_or_top"
}
```


### `focus_window_or_monitor_down`

**Nix Function:** `focus_window_or_monitor_down`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_or_monitor_down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_or_monitor_down"
}
```


### `focus_window_or_monitor_up`

**Nix Function:** `focus_window_or_monitor_up`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_or_monitor_up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_or_monitor_up"
}
```


### `focus_window_or_workspace_down`

**Nix Function:** `focus_window_or_workspace_down`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_or_workspace_down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_or_workspace_down"
}
```


### `focus_window_or_workspace_up`

**Nix Function:** `focus_window_or_workspace_up`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_or_workspace_up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_or_workspace_up"
}
```


### `focus_window_previous`

**Nix Function:** `focus_window_previous`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_previous;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_previous"
}
```


### `focus_window_top`

**Nix Function:** `focus_window_top`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_top;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_top"
}
```


### `focus_window_up`

**Nix Function:** `focus_window_up`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_up"
}
```


### `focus_window_up_or_bottom`

**Nix Function:** `focus_window_up_or_bottom`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_up_or_bottom;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_up_or_bottom"
}
```


### `focus_window_up_or_column_left`

**Nix Function:** `focus_window_up_or_column_left`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_up_or_column_left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_up_or_column_left"
}
```


### `focus_window_up_or_column_right`

**Nix Function:** `focus_window_up_or_column_right`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_window_up_or_column_right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_window_up_or_column_right"
}
```


### `focus_workspace`

**Nix Function:** `focus_workspace`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_workspace;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_workspace"
}
```


### `focus_workspace_down`

**Nix Function:** `focus_workspace_down`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_workspace_down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_workspace_down"
}
```


### `focus_workspace_previous`

**Nix Function:** `focus_workspace_previous`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_workspace_previous;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_workspace_previous"
}
```


### `focus_workspace_up`

**Nix Function:** `focus_workspace_up`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus_workspace_up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus_workspace_up"
}
```


### `fullscreen_window`

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
    bind "Mod+Key" action="fullscreen_window"
}
```


### `maximize_column`

**Nix Function:** `maximize_column`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = maximize_column;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="maximize_column"
}
```


### `maximize_window_to_edges`

**Nix Function:** `maximize_window_to_edges`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = maximize_window_to_edges;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="maximize_window_to_edges"
}
```


### `move_column_left`

**Nix Function:** `move_column_left`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_column_left"
}
```


### `move_column_left_or_to_monitor_left`

**Nix Function:** `move_column_left_or_to_monitor_left`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_left_or_to_monitor_left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_column_left_or_to_monitor_left"
}
```


### `move_column_right`

**Nix Function:** `move_column_right`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_column_right"
}
```


### `move_column_right_or_to_monitor_right`

**Nix Function:** `move_column_right_or_to_monitor_right`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_right_or_to_monitor_right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_column_right_or_to_monitor_right"
}
```


### `move_column_to_first`

**Nix Function:** `move_column_to_first`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_to_first;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_column_to_first"
}
```


### `move_column_to_index`

**Nix Function:** `move_column_to_index`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_to_index;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_column_to_index"
}
```


### `move_column_to_last`

**Nix Function:** `move_column_to_last`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_column_to_last;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_column_to_last"
}
```


### `move_window_down`

**Nix Function:** `move_window_down`
**Description:** Move window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_down"
}
```


### `move_window_down_or_to_workspace_down`

**Nix Function:** `move_window_down_or_to_workspace_down`
**Description:** Move to workspace

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_down_or_to_workspace_down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_down_or_to_workspace_down"
}
```


### `move_window_to_floating`

**Nix Function:** `move_window_to_floating`
**Description:** Move window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_floating;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_to_floating"
}
```


### `move_window_to_monitor`

**Nix Function:** `move_window_to_monitor`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_to_monitor"
}
```


### `move_window_to_monitor_down`

**Nix Function:** `move_window_to_monitor_down`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_to_monitor_down"
}
```


### `move_window_to_monitor_left`

**Nix Function:** `move_window_to_monitor_left`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_to_monitor_left"
}
```


### `move_window_to_monitor_next`

**Nix Function:** `move_window_to_monitor_next`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_next;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_to_monitor_next"
}
```


### `move_window_to_monitor_previous`

**Nix Function:** `move_window_to_monitor_previous`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_previous;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_to_monitor_previous"
}
```


### `move_window_to_monitor_right`

**Nix Function:** `move_window_to_monitor_right`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_to_monitor_right"
}
```


### `move_window_to_monitor_up`

**Nix Function:** `move_window_to_monitor_up`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_monitor_up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_to_monitor_up"
}
```


### `move_window_to_tiling`

**Nix Function:** `move_window_to_tiling`
**Description:** Move window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_to_tiling;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_to_tiling"
}
```


### `move_window_up`

**Nix Function:** `move_window_up`
**Description:** Move window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_up"
}
```


### `move_window_up_or_to_workspace_up`

**Nix Function:** `move_window_up_or_to_workspace_up`
**Description:** Move to workspace

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move_window_up_or_to_workspace_up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move_window_up_or_to_workspace_up"
}
```


### `open_overview`

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
    bind "Mod+Key" action="open_overview"
}
```


### `power_off_monitors`

**Nix Function:** `power_off_monitors`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = power_off_monitors;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="power_off_monitors"
}
```


### `power_on_monitors`

**Nix Function:** `power_on_monitors`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = power_on_monitors;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="power_on_monitors"
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
    bind "Mod+Key" action="quit"
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
    bind "Mod+Key" action="screenshot"
}
```


### `screenshot_screen`

**Nix Function:** `screenshot_screen`
**Description:** Take a screenshot

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = screenshot_screen;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="screenshot_screen"
}
```


### `screenshot_window`

**Nix Function:** `screenshot_window`
**Description:** Take a screenshot

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = screenshot_window;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="screenshot_window"
}
```


### `set_column_width`

**Nix Function:** `set_column_width`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = set_column_width;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="set_column_width"
}
```


### `show_hotkey_overlay`

**Nix Function:** `show_hotkey_overlay`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = show_hotkey_overlay;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="show_hotkey_overlay"
}
```


### `spawn`

**Nix Function:** `spawn`
**Description:** Execute a command

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = spawn;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="spawn"
}
```


### `spawn_sh`

**Nix Function:** `spawn_sh`
**Description:** Execute a command

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = spawn_sh;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="spawn_sh"
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
    bind "Mod+Key" action="suspend"
}
```


### `switch_focus_between_floating_and_tiling`

**Nix Function:** `switch_focus_between_floating_and_tiling`
**Description:** Toggle window floating

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = switch_focus_between_floating_and_tiling;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="switch_focus_between_floating_and_tiling"
}
```


### `toggle_debug_tint`

**Nix Function:** `toggle_debug_tint`
**Description:** Debug and development action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle_debug_tint;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="toggle_debug_tint"
}
```


### `toggle_keyboard_shortcuts_inhibit`

**Nix Function:** `toggle_keyboard_shortcuts_inhibit`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle_keyboard_shortcuts_inhibit;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="toggle_keyboard_shortcuts_inhibit"
}
```


### `toggle_overview`

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
    bind "Mod+Key" action="toggle_overview"
}
```


### `toggle_window_floating`

**Nix Function:** `toggle_window_floating`
**Description:** Toggle window floating

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle_window_floating;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="toggle_window_floating"
}
```


### `toggle_windowed_fullscreen`

**Nix Function:** `toggle_windowed_fullscreen`
**Description:** Toggle window fullscreen

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle_windowed_fullscreen;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="toggle_windowed_fullscreen"
}
```

