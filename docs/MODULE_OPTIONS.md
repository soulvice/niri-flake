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
- SHA256: `1j41qxdg9yr5pkmb9slvgq36n2y5pcy01xs1sw265b63nmsazdx4`

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

The niri module provides 72 built-in actions for window management, workspace navigation, and system control. All actions are available through `config.lib.niri.actions`.

### Available Actions (72 total)

### `center-window`

**Nix Function:** `center-window`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = center-window;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="center-window"
}
```


### `close-overview`

**Nix Function:** `close-overview`
**Description:** Close the focused window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = close-overview;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="close-overview"
}
```


### `close-window`

**Nix Function:** `close-window`
**Description:** Close the focused window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = close-window;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="close-window"
}
```


### `debug-toggle-damage`

**Nix Function:** `debug-toggle-damage`
**Description:** Debug and development action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = debug-toggle-damage;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="debug-toggle-damage"
}
```


### `debug-toggle-opaque-regions`

**Nix Function:** `debug-toggle-opaque-regions`
**Description:** Debug and development action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = debug-toggle-opaque-regions;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="debug-toggle-opaque-regions"
}
```


### `do-screen-transition`

**Nix Function:** `do-screen-transition`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = do-screen-transition;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="do-screen-transition"
}
```


### `focus-column`

**Nix Function:** `focus-column`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-column;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-column"
}
```


### `focus-column-first`

**Nix Function:** `focus-column-first`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-column-first;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-column-first"
}
```


### `focus-column-last`

**Nix Function:** `focus-column-last`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-column-last;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-column-last"
}
```


### `focus-column-left`

**Nix Function:** `focus-column-left`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-column-left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-column-left"
}
```


### `focus-column-left-or-last`

**Nix Function:** `focus-column-left-or-last`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-column-left-or-last;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-column-left-or-last"
}
```


### `focus-column-right`

**Nix Function:** `focus-column-right`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-column-right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-column-right"
}
```


### `focus-column-right-or-first`

**Nix Function:** `focus-column-right-or-first`
**Description:** Focus column navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-column-right-or-first;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-column-right-or-first"
}
```


### `focus-floating`

**Nix Function:** `focus-floating`
**Description:** Focus navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-floating;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-floating"
}
```


### `focus-monitor`

**Nix Function:** `focus-monitor`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-monitor;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-monitor"
}
```


### `focus-monitor-down`

**Nix Function:** `focus-monitor-down`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-monitor-down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-monitor-down"
}
```


### `focus-monitor-left`

**Nix Function:** `focus-monitor-left`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-monitor-left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-monitor-left"
}
```


### `focus-monitor-next`

**Nix Function:** `focus-monitor-next`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-monitor-next;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-monitor-next"
}
```


### `focus-monitor-previous`

**Nix Function:** `focus-monitor-previous`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-monitor-previous;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-monitor-previous"
}
```


### `focus-monitor-right`

**Nix Function:** `focus-monitor-right`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-monitor-right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-monitor-right"
}
```


### `focus-monitor-up`

**Nix Function:** `focus-monitor-up`
**Description:** Focus monitor navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-monitor-up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-monitor-up"
}
```


### `focus-tiling`

**Nix Function:** `focus-tiling`
**Description:** Focus navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-tiling;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-tiling"
}
```


### `focus-window-bottom`

**Nix Function:** `focus-window-bottom`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-window-bottom;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-window-bottom"
}
```


### `focus-window-down`

**Nix Function:** `focus-window-down`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-window-down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-window-down"
}
```


### `focus-window-down-or-top`

**Nix Function:** `focus-window-down-or-top`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-window-down-or-top;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-window-down-or-top"
}
```


### `focus-window-previous`

**Nix Function:** `focus-window-previous`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-window-previous;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-window-previous"
}
```


### `focus-window-top`

**Nix Function:** `focus-window-top`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-window-top;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-window-top"
}
```


### `focus-window-up`

**Nix Function:** `focus-window-up`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-window-up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-window-up"
}
```


### `focus-window-up-or-bottom`

**Nix Function:** `focus-window-up-or-bottom`
**Description:** Focus window navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-window-up-or-bottom;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-window-up-or-bottom"
}
```


### `focus-workspace`

**Nix Function:** `focus-workspace`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-workspace;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-workspace"
}
```


### `focus-workspace-down`

**Nix Function:** `focus-workspace-down`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-workspace-down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-workspace-down"
}
```


### `focus-workspace-previous`

**Nix Function:** `focus-workspace-previous`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-workspace-previous;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-workspace-previous"
}
```


### `focus-workspace-up`

**Nix Function:** `focus-workspace-up`
**Description:** Focus workspace navigation

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = focus-workspace-up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="focus-workspace-up"
}
```


### `fullscreen-window`

**Nix Function:** `fullscreen-window`
**Description:** Toggle window fullscreen

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = fullscreen-window;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="fullscreen-window"
}
```


### `maximize-window-to-edges`

**Nix Function:** `maximize-window-to-edges`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = maximize-window-to-edges;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="maximize-window-to-edges"
}
```


### `move-column-left`

**Nix Function:** `move-column-left`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-column-left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-column-left"
}
```


### `move-column-left-or-to-monitor-left`

**Nix Function:** `move-column-left-or-to-monitor-left`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-column-left-or-to-monitor-left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-column-left-or-to-monitor-left"
}
```


### `move-column-right`

**Nix Function:** `move-column-right`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-column-right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-column-right"
}
```


### `move-column-right-or-to-monitor-right`

**Nix Function:** `move-column-right-or-to-monitor-right`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-column-right-or-to-monitor-right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-column-right-or-to-monitor-right"
}
```


### `move-column-to-first`

**Nix Function:** `move-column-to-first`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-column-to-first;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-column-to-first"
}
```


### `move-column-to-index`

**Nix Function:** `move-column-to-index`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-column-to-index;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-column-to-index"
}
```


### `move-column-to-last`

**Nix Function:** `move-column-to-last`
**Description:** Move column

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-column-to-last;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-column-to-last"
}
```


### `move-window-down`

**Nix Function:** `move-window-down`
**Description:** Move window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-down"
}
```


### `move-window-down-or-to-workspace-down`

**Nix Function:** `move-window-down-or-to-workspace-down`
**Description:** Move to workspace

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-down-or-to-workspace-down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-down-or-to-workspace-down"
}
```


### `move-window-to-floating`

**Nix Function:** `move-window-to-floating`
**Description:** Move window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-to-floating;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-to-floating"
}
```


### `move-window-to-monitor`

**Nix Function:** `move-window-to-monitor`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-to-monitor;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-to-monitor"
}
```


### `move-window-to-monitor-down`

**Nix Function:** `move-window-to-monitor-down`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-to-monitor-down;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-to-monitor-down"
}
```


### `move-window-to-monitor-left`

**Nix Function:** `move-window-to-monitor-left`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-to-monitor-left;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-to-monitor-left"
}
```


### `move-window-to-monitor-next`

**Nix Function:** `move-window-to-monitor-next`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-to-monitor-next;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-to-monitor-next"
}
```


### `move-window-to-monitor-previous`

**Nix Function:** `move-window-to-monitor-previous`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-to-monitor-previous;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-to-monitor-previous"
}
```


### `move-window-to-monitor-right`

**Nix Function:** `move-window-to-monitor-right`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-to-monitor-right;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-to-monitor-right"
}
```


### `move-window-to-monitor-up`

**Nix Function:** `move-window-to-monitor-up`
**Description:** Move to monitor

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-to-monitor-up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-to-monitor-up"
}
```


### `move-window-to-tiling`

**Nix Function:** `move-window-to-tiling`
**Description:** Move window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-to-tiling;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-to-tiling"
}
```


### `move-window-up`

**Nix Function:** `move-window-up`
**Description:** Move window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-up"
}
```


### `move-window-up-or-to-workspace-up`

**Nix Function:** `move-window-up-or-to-workspace-up`
**Description:** Move to workspace

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = move-window-up-or-to-workspace-up;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="move-window-up-or-to-workspace-up"
}
```


### `open-overview`

**Nix Function:** `open-overview`
**Description:** Open overview mode

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = open-overview;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="open-overview"
}
```


### `power-off-monitors`

**Nix Function:** `power-off-monitors`
**Description:** Turn off all monitors

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = power-off-monitors;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="power-off-monitors"
}
```


### `power-on-monitors`

**Nix Function:** `power-on-monitors`
**Description:** Turn on all monitors

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = power-on-monitors;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="power-on-monitors"
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


### `screenshot-screen`

**Nix Function:** `screenshot-screen`
**Description:** Take a screenshot of entire screen

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = screenshot-screen;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="screenshot-screen"
}
```


### `screenshot-window`

**Nix Function:** `screenshot-window`
**Description:** Take a screenshot of current window

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = screenshot-window;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="screenshot-window"
}
```


### `show-hotkey-overlay`

**Nix Function:** `show-hotkey-overlay`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = show-hotkey-overlay;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="show-hotkey-overlay"
}
```


### `spawn`

**Nix Function:** `spawn`
**Description:** Execute a command

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = spawn "argument";
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="spawn "argument""
}
```


### `spawn-sh`

**Nix Function:** `spawn-sh`
**Description:** Execute a shell command

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = spawn-sh "argument";
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="spawn-sh "argument""
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


### `switch-focus-between-floating-and-tiling`

**Nix Function:** `switch-focus-between-floating-and-tiling`
**Description:** Toggle window floating

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = switch-focus-between-floating-and-tiling;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="switch-focus-between-floating-and-tiling"
}
```


### `toggle-debug-tint`

**Nix Function:** `toggle-debug-tint`
**Description:** Debug and development action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle-debug-tint;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="toggle-debug-tint"
}
```


### `toggle-keyboard-shortcuts-inhibit`

**Nix Function:** `toggle-keyboard-shortcuts-inhibit`
**Description:** Niri action

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle-keyboard-shortcuts-inhibit;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="toggle-keyboard-shortcuts-inhibit"
}
```


### `toggle-overview`

**Nix Function:** `toggle-overview`
**Description:** Toggle overview mode

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle-overview;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="toggle-overview"
}
```


### `toggle-window-floating`

**Nix Function:** `toggle-window-floating`
**Description:** Toggle window floating

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle-window-floating;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="toggle-window-floating"
}
```


### `toggle-windowed-fullscreen`

**Nix Function:** `toggle-windowed-fullscreen`
**Description:** Toggle window fullscreen

**Usage:**
```nix
binds = with config.lib.niri.actions; {
  "Mod+Key".action = toggle-windowed-fullscreen;
};
```

**KDL Format:**
```kdl
binds {
    bind "Mod+Key" action="toggle-windowed-fullscreen"
}
```


---

**Generation Info:**
- Generated on: 2025-11-20 03:04:04 UTC
- Niri commit: e0fe1a8b97c303da017906b18cbb53d3eacc354c
- Workflow run: [\#9](https://github.com/soulvice/niri-flake/actions/runs/19524090242)
