# Niri Configuration Coverage

This document shows the comprehensive coverage of niri configuration options in our auto-generated home-manager module.

## File Coverage Summary

Our parser now reads **14 configuration files** from `niri-config/src/`, ensuring complete coverage of all niri configuration options:

| File | Purpose | Key Types |
|------|---------|-----------|
| `lib.rs` | Main configuration structure | `Config`, root structure |
| `input.rs` | Input devices | `Input`, `Keyboard`, `Mouse`, `Touchpad`, `Tablet`, `Touch` |
| `output.rs` | Display/monitor setup | `Output`, `OutputMode`, `Transform` |
| `layout.rs` | Window layout | `Layout`, `PresetSize`, `Struts` |
| `animations.rs` | Animation system | `Animations`, `Animation`, `SpringParams`, `EasingParams` |
| `binds.rs` | Keyboard/mouse bindings | `Binds`, `Bind`, `Key`, `Action`, `Trigger` |
| `gestures.rs` | Gesture configuration | `Gestures`, `TouchpadGestures` |
| `window_rule.rs` | Per-window rules | `WindowRule`, `WindowRulePart` |
| `layer_rule.rs` | Layer shell rules | `LayerRule`, `Match` |
| `workspace.rs` | Workspace definitions | `Workspace`, `WorkspaceName` |
| `recent_windows.rs` | MRU window switcher | `RecentWindows`, `MruHighlight`, `MruPreviews`, `MruBind` |
| `appearance.rs` | Visual appearance | `Color`, `Gradient`, `CornerRadius`, `FocusRing`, `Border`, `Shadow`, `TabIndicator` |
| `debug.rs` | Debug settings | `Debug`, `PreviewRender` |
| `misc.rs` | Miscellaneous settings | `SpawnAtStartup`, `Cursor`, `ScreenshotPath`, `HotkeyOverlay`, `Environment` |
| `utils.rs` | Utility types | `FloatOrInt`, `Percent`, `Flag`, `RegexEq` |

## Configuration Categories

### 🖱️ Input & Interaction (3 files)
- **Keyboard**: XKB layouts, repeat settings, modifiers
- **Mouse/Touchpad**: Acceleration, scrolling, clicking, gestures
- **Touch/Tablet**: Calibration, mapping, pressure sensitivity
- **Focus**: Focus-follows-mouse, workspace behavior

### 🖥️ Display & Layout (3 files)
- **Outputs**: Multi-monitor setup, scaling, rotation, positioning
- **Layout**: Window arrangement, gaps, centering, presets
- **Workspaces**: Named workspaces, layout overrides

### 🎨 Visual Appearance (2 files)
- **Colors & Gradients**: Advanced color system with gradients
- **Borders & Shadows**: Focus rings, window borders, drop shadows
- **Corner Radius**: Rounded corners with per-corner control
- **Tab Indicators**: Visual indicators for tabbed windows

### ⚡ Behavior & Actions (3 files)
- **Key Bindings**: Comprehensive keybinding system
- **Window Rules**: Per-application behavior rules
- **Layer Rules**: Layer shell window management
- **Gestures**: Touchpad gesture configuration

### 🎬 Animation System (1 file)
- **Spring Animations**: Physics-based animations with damping/stiffness
- **Easing Animations**: Traditional easing curves
- **Per-Action**: Separate animation settings for different actions

### 🔧 System & Debug (2 files)
- **Environment**: Environment variable management
- **Startup**: Application launching at compositor start
- **Screenshots**: Screenshot path templates
- **Cursor**: Cursor theme and size
- **Debug**: Debug settings and preview rendering
- **Overlays**: Hotkey overlay configuration

## Type Safety Coverage

### Primitive Types ✅
- `bool`, `String`, `u8`-`u64`, `i8`-`i64`, `f32`, `f64`
- Range-constrained numbers (`FloatOrInt<MIN, MAX>`)
- Percentage values (`Percent`)

### Advanced Types ✅
- **Colors**: Hex, CSS names, RGB/RGBA functions
- **Gradients**: Multi-stop gradients with color space interpolation
- **Regex**: Validated regular expressions
- **Flags**: Boolean flags with optional explicit values
- **Preset Sizes**: Proportional or fixed sizing

### Collection Types ✅
- **Vectors**: Lists of any type (`Vec<T>`)
- **Options**: Optional values (`Option<T>`)
- **Hash Maps**: Key-value mappings for flexible configuration

### Complex Structures ✅
- **Nested Configuration**: Arbitrary nesting depth supported
- **Conditional Logic**: Rules and matching systems
- **Cross-References**: Output names, workspace references validated

## Enum Coverage

All niri enums are fully supported with validation:

- **Modifier Keys**: `Ctrl`, `Shift`, `Alt`, `Super`, etc.
- **Transformations**: Display rotations and flips
- **Acceleration Profiles**: Mouse/touchpad acceleration curves
- **Click Methods**: Touchpad clicking behavior
- **Scroll Methods**: Touchpad scrolling techniques
- **Animation Curves**: Easing curve types
- **Layout Behavior**: Column centering, overflow handling
- **Focus Behavior**: Window focusing modes

## Missing/Excluded

The following files are intentionally excluded as they don't contain user configuration:

- `error.rs` - Error handling types only
- `macros.rs` - Procedural macros only
- `utils/merge_with.rs` - Internal trait only

## Validation Coverage

- ✅ **Type Validation**: All types mapped to appropriate Nix types
- ✅ **Range Validation**: Numeric constraints enforced
- ✅ **Enum Validation**: Only valid enum values accepted
- ✅ **Cross-Reference Validation**: Output/workspace references checked
- ✅ **Format Validation**: Colors, regex patterns, file paths validated

## Future-Proofing

The parser automatically discovers new files and types added to niri, ensuring the module stays current with niri development without manual intervention.

---

**Total Coverage**: 14/14 configuration files (100%)
**Last Updated**: Generated automatically from niri source analysis