# niri settings options

Auto-generated from niri Rust config source — do not edit manually.  
Regenerate: `python3 generate.py`

## Table of contents

- [`programs.niri.settings.input`](#input)
- [`programs.niri.settings.cursor`](#cursor)
- [`programs.niri.settings.clipboard`](#clipboard)
- [`programs.niri.settings.hotkey-overlay`](#hotkey-overlay)
- [`programs.niri.settings.config-notification`](#config-notification)
- [`programs.niri.settings.animations`](#animations)
- [`programs.niri.settings.blur`](#blur)
- [`programs.niri.settings.gestures`](#gestures)
- [`programs.niri.settings.overview`](#overview)
- [`programs.niri.settings.xwayland-satellite`](#xwayland-satellite)
- [`programs.niri.settings.switch-events`](#switch-events)
- [`programs.niri.settings.debug`](#debug)
- [`programs.niri.settings.output`](#output)
- [`programs.niri.settings.spawn-at-startup`](#spawn-at-startup)
- [`programs.niri.settings.spawn-sh-at-startup`](#spawn-sh-at-startup)
- [`programs.niri.settings.window-rule`](#window-rule)
- [`programs.niri.settings.layer-rule`](#layer-rule)
- [`programs.niri.settings.workspace`](#workspace)
- [`programs.niri.settings.binds`](#binds)
- [`programs.niri.settings.environment`](#environment)
- [`programs.niri.settings.prefer-no-csd`](#prefer-no-csd)
- [`programs.niri.settings.screenshot-path`](#screenshot-path)
- [`programs.niri.settings.layout`](#layout)
- [`programs.niri.settings.recent-windows`](#recent-windows)

---

## `programs.niri.settings.input`

### `programs.niri.settings.input.keyboard`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.keyboard.xkb`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.keyboard.xkb.rules`

**Type:** `string`

### `programs.niri.settings.input.keyboard.xkb.model`

**Type:** `string`

### `programs.niri.settings.input.keyboard.xkb.layout`

**Type:** `string`

### `programs.niri.settings.input.keyboard.xkb.variant`

**Type:** `string`

### `programs.niri.settings.input.keyboard.xkb.options`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.input.keyboard.xkb.file`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.input.keyboard.repeat-delay`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.input.keyboard.repeat-rate`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.input.keyboard.track-layout`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"global"`, `"window"` *(default: `"global"`)* 

### `programs.niri.settings.input.keyboard.numlock`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.touchpad.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.tap`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.dwt`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.dwtp`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.drag`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.drag-lock`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.natural-scroll`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.click-method`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"clickfinger"`, `"button-areas"`

### `programs.niri.settings.input.touchpad.accel-speed`

**Type:** `float`

### `programs.niri.settings.input.touchpad.accel-profile`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"adaptive"`, `"flat"`

### `programs.niri.settings.input.touchpad.scroll-method`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"no-scroll"`, `"two-finger"`, `"edge"`, `"on-button-down"`

### `programs.niri.settings.input.touchpad.scroll-button`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.input.touchpad.scroll-button-lock`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.tap-button-map`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"left-right-middle"`, `"left-middle-right"`

### `programs.niri.settings.input.touchpad.left-handed`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.disabled-on-external-mouse`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.middle-emulation`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touchpad.scroll-factor`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.touchpad.scroll-factor.base`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.touchpad.scroll-factor.horizontal`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.touchpad.scroll-factor.vertical`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.touchpad.pinch-sensitivity`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.mouse`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.mouse.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.mouse.natural-scroll`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.mouse.accel-speed`

**Type:** `float`

### `programs.niri.settings.input.mouse.accel-profile`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"adaptive"`, `"flat"`

### `programs.niri.settings.input.mouse.scroll-method`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"no-scroll"`, `"two-finger"`, `"edge"`, `"on-button-down"`

### `programs.niri.settings.input.mouse.scroll-button`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.input.mouse.scroll-button-lock`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.mouse.left-handed`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.mouse.middle-emulation`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.mouse.scroll-factor`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.mouse.scroll-factor.base`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.mouse.scroll-factor.horizontal`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.mouse.scroll-factor.vertical`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.trackpoint`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.trackpoint.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.trackpoint.natural-scroll`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.trackpoint.accel-speed`

**Type:** `float`

### `programs.niri.settings.input.trackpoint.accel-profile`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"adaptive"`, `"flat"`

### `programs.niri.settings.input.trackpoint.scroll-method`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"no-scroll"`, `"two-finger"`, `"edge"`, `"on-button-down"`

### `programs.niri.settings.input.trackpoint.scroll-button`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.input.trackpoint.scroll-button-lock`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.trackpoint.left-handed`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.trackpoint.middle-emulation`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.trackball`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.trackball.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.trackball.natural-scroll`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.trackball.accel-speed`

**Type:** `float`

### `programs.niri.settings.input.trackball.accel-profile`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"adaptive"`, `"flat"`

### `programs.niri.settings.input.trackball.scroll-method`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"no-scroll"`, `"two-finger"`, `"edge"`, `"on-button-down"`

### `programs.niri.settings.input.trackball.scroll-button`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.input.trackball.scroll-button-lock`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.trackball.left-handed`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.trackball.middle-emulation`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.tablet`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.tablet.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.tablet.calibration-matrix`

**Type:** `null` or list of `float`  **Default:** `null`

### `programs.niri.settings.input.tablet.map-to-output`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.input.tablet.map-to-focused-output`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.tablet.map-to-focused-window`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.tablet.left-handed`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touch`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.touch.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.input.touch.calibration-matrix`

**Type:** `null` or list of `float`  **Default:** `null`

### `programs.niri.settings.input.touch.map-to-output`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.input.disable-power-key-handling`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.input.warp-mouse-to-focus`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.warp-mouse-to-focus.mode`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"center-xy"`, `"center-xy-always"`

### `programs.niri.settings.input.focus-follows-mouse`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.input.focus-follows-mouse.max-scroll-amount`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.input.workspace-auto-back-and-forth`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.input.mod-key`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"ctrl"`, `"shift"`, `"alt"`, `"super"`, `"iso-level-3shift"`, `"iso-level-5shift"`

### `programs.niri.settings.input.mod-key-nested`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"ctrl"`, `"shift"`, `"alt"`, `"super"`, `"iso-level-3shift"`, `"iso-level-5shift"`

---

## `programs.niri.settings.cursor`

### `programs.niri.settings.cursor.xcursor-theme`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.cursor.xcursor-size`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.cursor.hide-when-typing`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.cursor.hide-after-inactive-ms`

**Type:** `null` or `int`  **Default:** `null`

---

## `programs.niri.settings.clipboard`

### `programs.niri.settings.clipboard.disable-primary`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

---

## `programs.niri.settings.hotkey-overlay`

### `programs.niri.settings.hotkey-overlay.skip-at-startup`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.hotkey-overlay.hide-not-bound`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

---

## `programs.niri.settings.config-notification`

### `programs.niri.settings.config-notification.disable-failed`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

---

## `programs.niri.settings.animations`

### `programs.niri.settings.animations.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.slowdown`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.animations.workspace-switch`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.workspace-switch.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.workspace-switch.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.workspace-switch.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.workspace-switch.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.workspace-switch.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.workspace-switch.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.workspace-switch.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.workspace-switch.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.window-open`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-open.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.window-open.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-open.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.window-open.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.window-open.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-open.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.window-open.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.window-open.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.window-open.custom-shader`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.animations.window-close`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-close.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.window-close.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-close.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.window-close.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.window-close.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-close.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.window-close.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.window-close.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.window-close.custom-shader`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.animations.horizontal-view-movement`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.horizontal-view-movement.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.horizontal-view-movement.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.horizontal-view-movement.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.horizontal-view-movement.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.horizontal-view-movement.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.horizontal-view-movement.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.horizontal-view-movement.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.horizontal-view-movement.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.window-movement`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-movement.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.window-movement.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-movement.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.window-movement.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.window-movement.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-movement.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.window-movement.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.window-movement.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.window-resize`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-resize.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.window-resize.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-resize.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.window-resize.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.window-resize.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.window-resize.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.window-resize.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.window-resize.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.window-resize.custom-shader`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.animations.config-notification-open-close`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.config-notification-open-close.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.config-notification-open-close.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.config-notification-open-close.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.config-notification-open-close.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.config-notification-open-close.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.config-notification-open-close.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.config-notification-open-close.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.config-notification-open-close.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.exit-confirmation-open-close`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.exit-confirmation-open-close.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.exit-confirmation-open-close.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.exit-confirmation-open-close.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.exit-confirmation-open-close.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.exit-confirmation-open-close.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.exit-confirmation-open-close.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.exit-confirmation-open-close.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.exit-confirmation-open-close.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.screenshot-ui-open`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.screenshot-ui-open.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.screenshot-ui-open.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.screenshot-ui-open.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.screenshot-ui-open.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.screenshot-ui-open.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.screenshot-ui-open.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.screenshot-ui-open.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.screenshot-ui-open.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.overview-open-close`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.overview-open-close.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.overview-open-close.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.overview-open-close.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.overview-open-close.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.overview-open-close.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.overview-open-close.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.overview-open-close.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.overview-open-close.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

### `programs.niri.settings.animations.recent-windows-close`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.recent-windows-close.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.animations.recent-windows-close.easing`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.recent-windows-close.easing.duration-ms`

**Type:** `int`  **Default:** `250`

### `programs.niri.settings.animations.recent-windows-close.easing.curve`

**Type:** `string`

### `programs.niri.settings.animations.recent-windows-close.spring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.animations.recent-windows-close.spring.damping-ratio`

**Type:** `float`  **Default:** `1.0`

### `programs.niri.settings.animations.recent-windows-close.spring.stiffness`

**Type:** `int`  **Default:** `1000`

### `programs.niri.settings.animations.recent-windows-close.spring.epsilon`

**Type:** `float`  **Default:** `0.0001`

---

## `programs.niri.settings.blur`

### `programs.niri.settings.blur.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.blur.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.blur.passes`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.blur.offset`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.blur.noise`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.blur.saturation`

**Type:** `null` or `float`  **Default:** `null`

---

## `programs.niri.settings.gestures`

### `programs.niri.settings.gestures.dnd-edge-view-scroll`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.gestures.dnd-edge-view-scroll.trigger-width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.gestures.dnd-edge-view-scroll.delay-ms`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.gestures.dnd-edge-view-scroll.max-speed`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.gestures.dnd-edge-workspace-switch`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.gestures.dnd-edge-workspace-switch.trigger-height`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.gestures.dnd-edge-workspace-switch.delay-ms`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.gestures.dnd-edge-workspace-switch.max-speed`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.gestures.hot-corners`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.gestures.hot-corners.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.gestures.hot-corners.top-left`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.gestures.hot-corners.top-right`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.gestures.hot-corners.bottom-left`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.gestures.hot-corners.bottom-right`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

---

## `programs.niri.settings.overview`

### `programs.niri.settings.overview.zoom`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.overview.backdrop-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.overview.workspace-shadow`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.overview.workspace-shadow.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.overview.workspace-shadow.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.overview.workspace-shadow.offset`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.overview.workspace-shadow.offset.x`

**Type:** `float`

### `programs.niri.settings.overview.workspace-shadow.offset.y`

**Type:** `float`

### `programs.niri.settings.overview.workspace-shadow.softness`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.overview.workspace-shadow.spread`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.overview.workspace-shadow.color`

**Type:** `null` or `string`  **Default:** `null`

---

## `programs.niri.settings.xwayland-satellite`

### `programs.niri.settings.xwayland-satellite.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.xwayland-satellite.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.xwayland-satellite.path`

**Type:** `null` or `string`  **Default:** `null`

---

## `programs.niri.settings.switch-events`

### `programs.niri.settings.switch-events.lid-open`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.switch-events.lid-open.spawn`

**Type:** list of `string`  **Default:** `[]`

### `programs.niri.settings.switch-events.lid-close`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.switch-events.lid-close.spawn`

**Type:** list of `string`  **Default:** `[]`

### `programs.niri.settings.switch-events.tablet-mode-on`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.switch-events.tablet-mode-on.spawn`

**Type:** list of `string`  **Default:** `[]`

### `programs.niri.settings.switch-events.tablet-mode-off`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.switch-events.tablet-mode-off.spawn`

**Type:** list of `string`  **Default:** `[]`

---

## `programs.niri.settings.debug`

### `programs.niri.settings.debug.preview-render`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"screencast"`, `"screen-capture"`

### `programs.niri.settings.debug.dbus-interfaces-in-non-session-instances`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.wait-for-frame-completion-before-queueing`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.enable-overlay-planes`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.disable-cursor-plane`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.disable-direct-scanout`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.restrict-primary-scanout-to-matching-format`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.force-disable-connectors-on-resume`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.render-drm-device`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.debug.ignored-drm-devices`

**Type:** list of `string`  **Default:** `[]`

### `programs.niri.settings.debug.force-pipewire-invalid-modifier`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.disable-pipewire-dmabuf`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.emulate-zero-presentation-time`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.disable-resize-throttling`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.disable-transactions`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.keep-laptop-panel-on-when-lid-is-closed`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.disable-monitor-names`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.strict-new-window-focus-policy`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.honor-xdg-activation-with-invalid-serial`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.deactivate-unfocused-windows`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.skip-cursor-only-updates-during-vrr`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.debug.disable-10bit-output`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

---

## `programs.niri.settings.output`

**Type:** list of submodules  **Default:** `[]`

### `programs.niri.settings.output.<n>.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.name`

**Type:** `string`

### `programs.niri.settings.output.<n>.scale`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.transform`

**Type:** `string`
**Values:** `"normal"`, `"90"`, `"180"`, `"270"`, `"flipped"`, `"flipped-90"`, `"flipped-180"`, `"flipped-270"`

### `programs.niri.settings.output.<n>.position`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.position.x`

**Type:** `int`

### `programs.niri.settings.output.<n>.position.y`

**Type:** `int`

### `programs.niri.settings.output.<n>.max-bpc`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.output.<n>.mode`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.modeline`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.variable-refresh-rate`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.variable-refresh-rate.on-demand`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.focus-at-startup`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.background-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.backdrop-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.hot-corners`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.hot-corners.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.hot-corners.top-left`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.hot-corners.top-right`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.hot-corners.bottom-left`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.hot-corners.bottom-right`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.focus-ring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.focus-ring.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.focus-ring.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.focus-ring.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.focus-ring.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.focus-ring.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.focus-ring.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.focus-ring.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.focus-ring.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.focus-ring.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.focus-ring.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.focus-ring.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.focus-ring.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.focus-ring.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.focus-ring.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.focus-ring.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.focus-ring.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.focus-ring.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.focus-ring.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.focus-ring.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.focus-ring.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.focus-ring.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.focus-ring.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.focus-ring.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.focus-ring.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.border`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.border.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.border.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.border.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.border.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.border.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.border.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.border.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.border.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.border.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.border.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.border.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.border.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.border.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.border.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.border.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.border.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.border.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.border.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.border.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.border.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.border.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.border.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.border.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.border.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.shadow`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.shadow.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.shadow.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.shadow.offset`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.shadow.offset.x`

**Type:** `float`

### `programs.niri.settings.output.<n>.layout.shadow.offset.y`

**Type:** `float`

### `programs.niri.settings.output.<n>.layout.shadow.softness`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.shadow.spread`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.shadow.draw-behind-window`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.shadow.color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.shadow.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.tab-indicator.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.tab-indicator.hide-when-single-tab`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.tab-indicator.place-within-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.tab-indicator.gap`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.length`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.length.total-proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.position`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"left"`, `"right"`, `"top"`, `"bottom"`

### `programs.niri.settings.output.<n>.layout.tab-indicator.gaps-between-tabs`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.corner-radius`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.tab-indicator.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.tab-indicator.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.tab-indicator.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.tab-indicator.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.tab-indicator.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.tab-indicator.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.tab-indicator.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.tab-indicator.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.tab-indicator.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.tab-indicator.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.tab-indicator.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.tab-indicator.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.tab-indicator.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.tab-indicator.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.tab-indicator.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.insert-hint`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.insert-hint.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.insert-hint.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.insert-hint.color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.insert-hint.gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.insert-hint.gradient.from`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.insert-hint.gradient.to`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.insert-hint.gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.output.<n>.layout.insert-hint.gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.output.<n>.layout.insert-hint.gradient.in-`

**Type:** `string`

### `programs.niri.settings.output.<n>.layout.preset-column-widths`

**Type:** `null` or list of `any`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.preset-column-widths.<item>.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.preset-column-widths.<item>.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.default-column-width`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.default-column-width.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.default-column-width.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.preset-window-heights`

**Type:** `null` or list of `any`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.preset-window-heights.<item>.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.preset-window-heights.<item>.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.center-focused-column`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"never"`, `"always"`, `"on-overflow"` *(default: `"never"`)* 

### `programs.niri.settings.output.<n>.layout.always-center-single-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.empty-workspace-above-first`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.output.<n>.layout.default-column-display`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"normal"`, `"tabbed"`

### `programs.niri.settings.output.<n>.layout.gaps`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.struts`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.output.<n>.layout.struts.left`

**Type:** `float`

### `programs.niri.settings.output.<n>.layout.struts.right`

**Type:** `float`

### `programs.niri.settings.output.<n>.layout.struts.top`

**Type:** `float`

### `programs.niri.settings.output.<n>.layout.struts.bottom`

**Type:** `float`

### `programs.niri.settings.output.<n>.layout.background-color`

**Type:** `null` or `string`  **Default:** `null`

---

## `programs.niri.settings.spawn-at-startup`

**Type:** list of submodules  **Default:** `[]`

### `programs.niri.settings.spawn-at-startup.<n>.command`

**Type:** list of `string`  **Default:** `[]`

---

## `programs.niri.settings.spawn-sh-at-startup`

**Type:** list of submodules  **Default:** `[]`

### `programs.niri.settings.spawn-sh-at-startup.<n>.command`

**Type:** `string`

---

## `programs.niri.settings.window-rule`

**Type:** list of submodules  **Default:** `[]`

### `programs.niri.settings.window-rule.<n>.matches`

**Type:** list of `submodule`  **Default:** `[]`

### `programs.niri.settings.window-rule.<n>.matches.<item>.app-id`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.matches.<item>.title`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.matches.<item>.is-active`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.matches.<item>.is-focused`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.matches.<item>.is-active-in-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.matches.<item>.is-floating`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.matches.<item>.is-window-cast-target`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.matches.<item>.is-urgent`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.matches.<item>.at-startup`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.excludes`

**Type:** list of `submodule`  **Default:** `[]`

### `programs.niri.settings.window-rule.<n>.excludes.<item>.app-id`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.excludes.<item>.title`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.excludes.<item>.is-active`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.excludes.<item>.is-focused`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.excludes.<item>.is-active-in-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.excludes.<item>.is-floating`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.excludes.<item>.is-window-cast-target`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.excludes.<item>.is-urgent`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.excludes.<item>.at-startup`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.default-column-width`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.default-column-width.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.default-column-width.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.default-window-height`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.default-window-height.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.default-window-height.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.open-on-output`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.open-on-workspace`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.open-maximized`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.open-maximized-to-edges`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.open-fullscreen`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.open-floating`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.open-focused`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.on-xdg-activate`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"ignore"`, `"set-urgent"`, `"focus"`

### `programs.niri.settings.window-rule.<n>.min-width`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.min-height`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.max-width`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.max-height`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.focus-ring`

**Type:** `submodule`

### `programs.niri.settings.window-rule.<n>.focus-ring.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.focus-ring.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.focus-ring.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.focus-ring.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.focus-ring.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.focus-ring.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.focus-ring.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.focus-ring.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.focus-ring.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.focus-ring.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.window-rule.<n>.focus-ring.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.window-rule.<n>.focus-ring.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.focus-ring.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.focus-ring.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.focus-ring.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.focus-ring.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.window-rule.<n>.focus-ring.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.window-rule.<n>.focus-ring.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.focus-ring.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.focus-ring.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.focus-ring.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.focus-ring.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.window-rule.<n>.focus-ring.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.window-rule.<n>.focus-ring.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.border`

**Type:** `submodule`

### `programs.niri.settings.window-rule.<n>.border.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.border.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.border.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.border.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.border.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.border.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.border.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.border.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.border.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.border.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.window-rule.<n>.border.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.window-rule.<n>.border.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.border.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.border.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.border.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.border.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.window-rule.<n>.border.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.window-rule.<n>.border.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.border.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.border.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.border.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.border.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.window-rule.<n>.border.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.window-rule.<n>.border.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.shadow`

**Type:** `submodule`

### `programs.niri.settings.window-rule.<n>.shadow.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.shadow.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.shadow.offset`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.shadow.offset.x`

**Type:** `float`

### `programs.niri.settings.window-rule.<n>.shadow.offset.y`

**Type:** `float`

### `programs.niri.settings.window-rule.<n>.shadow.softness`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.shadow.spread`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.shadow.draw-behind-window`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.shadow.color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.shadow.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.tab-indicator`

**Type:** `submodule`

### `programs.niri.settings.window-rule.<n>.tab-indicator.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.tab-indicator.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.tab-indicator.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.tab-indicator.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.tab-indicator.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.tab-indicator.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.tab-indicator.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.window-rule.<n>.tab-indicator.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.window-rule.<n>.tab-indicator.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.tab-indicator.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.tab-indicator.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.tab-indicator.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.tab-indicator.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.window-rule.<n>.tab-indicator.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.window-rule.<n>.tab-indicator.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.tab-indicator.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.tab-indicator.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.tab-indicator.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.tab-indicator.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.window-rule.<n>.tab-indicator.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.window-rule.<n>.tab-indicator.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.window-rule.<n>.draw-border-with-background`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.opacity`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.geometry-corner-radius`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.clip-to-geometry`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.baba-is-float`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.block-out-from`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"screencast"`, `"screen-capture"`

### `programs.niri.settings.window-rule.<n>.variable-refresh-rate`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.default-column-display`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"normal"`, `"tabbed"`

### `programs.niri.settings.window-rule.<n>.default-floating-position`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.default-floating-position.x`

**Type:** `float`

### `programs.niri.settings.window-rule.<n>.default-floating-position.y`

**Type:** `float`

### `programs.niri.settings.window-rule.<n>.default-floating-position.relative-to`

**Type:** `string`
**Values:** `"top-left"`, `"top-right"`, `"bottom-left"`, `"bottom-right"`, `"top"`, `"bottom"`, `"left"`, `"right"` *(default: `"top-left"`)* 

### `programs.niri.settings.window-rule.<n>.scroll-factor`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.pinch-sensitivity`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.tiled-state`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.background-effect`

**Type:** `submodule`

### `programs.niri.settings.window-rule.<n>.background-effect.xray`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.background-effect.blur`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.background-effect.noise`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.background-effect.saturation`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.popups`

**Type:** `submodule`

### `programs.niri.settings.window-rule.<n>.popups.opacity`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.popups.geometry-corner-radius`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.popups.background-effect`

**Type:** `submodule`

### `programs.niri.settings.window-rule.<n>.popups.background-effect.xray`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.popups.background-effect.blur`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.window-rule.<n>.popups.background-effect.noise`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.window-rule.<n>.popups.background-effect.saturation`

**Type:** `null` or `float`  **Default:** `null`

---

## `programs.niri.settings.layer-rule`

**Type:** list of submodules  **Default:** `[]`

### `programs.niri.settings.layer-rule.<n>.matches`

**Type:** list of `submodule`  **Default:** `[]`

### `programs.niri.settings.layer-rule.<n>.matches.<item>.app-id`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.matches.<item>.title`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.matches.<item>.is-active`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.matches.<item>.is-focused`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.matches.<item>.is-active-in-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.matches.<item>.is-floating`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.matches.<item>.is-window-cast-target`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.matches.<item>.is-urgent`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.matches.<item>.at-startup`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.excludes`

**Type:** list of `submodule`  **Default:** `[]`

### `programs.niri.settings.layer-rule.<n>.excludes.<item>.app-id`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.excludes.<item>.title`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.excludes.<item>.is-active`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.excludes.<item>.is-focused`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.excludes.<item>.is-active-in-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.excludes.<item>.is-floating`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.excludes.<item>.is-window-cast-target`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.excludes.<item>.is-urgent`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.excludes.<item>.at-startup`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.opacity`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.block-out-from`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"screencast"`, `"screen-capture"`

### `programs.niri.settings.layer-rule.<n>.shadow`

**Type:** `submodule`

### `programs.niri.settings.layer-rule.<n>.shadow.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.shadow.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.shadow.offset`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.shadow.offset.x`

**Type:** `float`

### `programs.niri.settings.layer-rule.<n>.shadow.offset.y`

**Type:** `float`

### `programs.niri.settings.layer-rule.<n>.shadow.softness`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.shadow.spread`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.shadow.draw-behind-window`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.shadow.color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.shadow.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.geometry-corner-radius`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.place-within-backdrop`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.baba-is-float`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.background-effect`

**Type:** `submodule`

### `programs.niri.settings.layer-rule.<n>.background-effect.xray`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.background-effect.blur`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.background-effect.noise`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.background-effect.saturation`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.popups`

**Type:** `submodule`

### `programs.niri.settings.layer-rule.<n>.popups.opacity`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.popups.geometry-corner-radius`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.popups.background-effect`

**Type:** `submodule`

### `programs.niri.settings.layer-rule.<n>.popups.background-effect.xray`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.popups.background-effect.blur`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layer-rule.<n>.popups.background-effect.noise`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layer-rule.<n>.popups.background-effect.saturation`

**Type:** `null` or `float`  **Default:** `null`

---

## `programs.niri.settings.workspace`

**Type:** list of submodules  **Default:** `[]`

### `programs.niri.settings.workspace.<n>.name`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.open-on-output`

**Type:** list of `string`  **Default:** `[]`

### `programs.niri.settings.workspace.<n>.layout`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.focus-ring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.focus-ring.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.focus-ring.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.focus-ring.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.focus-ring.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.border`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.border.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.border.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.border.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.border.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.border.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.border.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.border.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.border.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.border.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.border.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.border.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.border.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.border.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.border.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.border.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.border.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.border.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.border.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.border.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.border.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.border.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.border.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.border.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.border.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.shadow`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.shadow.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.shadow.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.shadow.offset`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.shadow.offset.x`

**Type:** `float`

### `programs.niri.settings.workspace.<n>.layout.shadow.offset.y`

**Type:** `float`

### `programs.niri.settings.workspace.<n>.layout.shadow.softness`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.shadow.spread`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.shadow.draw-behind-window`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.shadow.color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.shadow.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.hide-when-single-tab`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.place-within-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.gap`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.length`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.length.total-proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.position`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"left"`, `"right"`, `"top"`, `"bottom"`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.gaps-between-tabs`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.corner-radius`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.tab-indicator.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.insert-hint`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.insert-hint.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.insert-hint.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.insert-hint.color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.insert-hint.gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.insert-hint.gradient.from`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.insert-hint.gradient.to`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.insert-hint.gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.workspace.<n>.layout.insert-hint.gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.workspace.<n>.layout.insert-hint.gradient.in-`

**Type:** `string`

### `programs.niri.settings.workspace.<n>.layout.preset-column-widths`

**Type:** `null` or list of `any`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.preset-column-widths.<item>.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.preset-column-widths.<item>.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.default-column-width`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.default-column-width.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.default-column-width.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.preset-window-heights`

**Type:** `null` or list of `any`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.preset-window-heights.<item>.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.preset-window-heights.<item>.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.center-focused-column`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"never"`, `"always"`, `"on-overflow"` *(default: `"never"`)* 

### `programs.niri.settings.workspace.<n>.layout.always-center-single-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.empty-workspace-above-first`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.workspace.<n>.layout.default-column-display`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"normal"`, `"tabbed"`

### `programs.niri.settings.workspace.<n>.layout.gaps`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.struts`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.workspace.<n>.layout.struts.left`

**Type:** `float`

### `programs.niri.settings.workspace.<n>.layout.struts.right`

**Type:** `float`

### `programs.niri.settings.workspace.<n>.layout.struts.top`

**Type:** `float`

### `programs.niri.settings.workspace.<n>.layout.struts.bottom`

**Type:** `float`

### `programs.niri.settings.workspace.<n>.layout.background-color`

**Type:** `null` or `string`  **Default:** `null`

---

## `programs.niri.settings.binds`

**Type:** `attrsOf submodule`  **Default:** `{}`

Each key is a key combination (e.g. `"Mod+Return"`). Set exactly one action field per bind; the rest default to `false`/`null`.

**Action fields** (all `bool` or typed, default `false`/`null`): `quit`, `suspend`, `close-window`, `fullscreen-window`, `spawn` (list of str), `spawn-sh` (str), `focus-column-left/right`, `focus-workspace` (int or str), `set-column-width` (str), `set-window-width/height` (str), `maximize-column`, and many more — see the generated options for the full list.

**Metadata fields:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `allow-when-locked` | `bool` | `false` | Allow this bind when the screen is locked |
| `allow-inhibiting` | `bool` | `true` | Allow apps to inhibit this keybind |
| `cooldown-ms` | `null or int` | `null` | Minimum ms between triggers |
| `repeat` | `bool` | `true` | Trigger repeatedly when held |
| `hotkey-overlay` | `null or submodule` | `null` | Hotkey overlay display: `{ title = "…"; }` sets a label, `{ hidden = true; }` hides the bind |

---

## `programs.niri.settings.environment`

**Type:** `attrsOf nullOr str`  **Default:** `{}`

---

## `programs.niri.settings.prefer-no-csd`

**Type:** `bool`  **Default:** `false`

---

## `programs.niri.settings.screenshot-path`

**Type:** `nullOr str`  **Default:** `"~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"`

---

## `programs.niri.settings.layout`

### `programs.niri.settings.layout.focus-ring`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.focus-ring.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.focus-ring.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.focus-ring.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.focus-ring.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.focus-ring.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.focus-ring.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.focus-ring.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.focus-ring.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.focus-ring.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.focus-ring.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.focus-ring.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.focus-ring.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.focus-ring.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.focus-ring.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.focus-ring.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.focus-ring.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.focus-ring.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.focus-ring.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.focus-ring.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.focus-ring.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.focus-ring.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.focus-ring.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.focus-ring.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.focus-ring.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.border`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.border.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.border.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.border.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.border.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.border.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.border.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.border.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.border.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.border.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.border.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.border.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.border.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.border.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.border.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.border.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.border.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.border.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.border.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.border.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.border.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.border.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.border.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.border.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.border.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.shadow`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.shadow.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.shadow.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.shadow.offset`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.shadow.offset.x`

**Type:** `float`

### `programs.niri.settings.layout.shadow.offset.y`

**Type:** `float`

### `programs.niri.settings.layout.shadow.softness`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.shadow.spread`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.shadow.draw-behind-window`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layout.shadow.color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.shadow.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.tab-indicator.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.tab-indicator.hide-when-single-tab`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layout.tab-indicator.place-within-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layout.tab-indicator.gap`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.width`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.length`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.length.total-proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.position`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"left"`, `"right"`, `"top"`, `"bottom"`

### `programs.niri.settings.layout.tab-indicator.gaps-between-tabs`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.corner-radius`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.inactive-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.active-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.active-gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.tab-indicator.active-gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.tab-indicator.active-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.tab-indicator.active-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.tab-indicator.active-gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.tab-indicator.inactive-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.inactive-gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.tab-indicator.inactive-gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.tab-indicator.inactive-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.tab-indicator.inactive-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.tab-indicator.inactive-gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.tab-indicator.urgent-gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.tab-indicator.urgent-gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.tab-indicator.urgent-gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.tab-indicator.urgent-gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.tab-indicator.urgent-gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.tab-indicator.urgent-gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.insert-hint`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.insert-hint.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.insert-hint.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.layout.insert-hint.color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.layout.insert-hint.gradient`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.insert-hint.gradient.from`

**Type:** `string`

### `programs.niri.settings.layout.insert-hint.gradient.to`

**Type:** `string`

### `programs.niri.settings.layout.insert-hint.gradient.angle`

**Type:** `int`  **Default:** `180`

### `programs.niri.settings.layout.insert-hint.gradient.relative-to`

**Type:** `string`
**Values:** `"window"`, `"workspace-view"` *(default: `"window"`)* 

### `programs.niri.settings.layout.insert-hint.gradient.in-`

**Type:** `string`

### `programs.niri.settings.layout.preset-column-widths`

**Type:** `null` or list of `any`  **Default:** `null`

### `programs.niri.settings.layout.preset-column-widths.<item>.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.preset-column-widths.<item>.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.layout.default-column-width`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.default-column-width.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.default-column-width.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.layout.preset-window-heights`

**Type:** `null` or list of `any`  **Default:** `null`

### `programs.niri.settings.layout.preset-window-heights.<item>.proportion`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.preset-window-heights.<item>.fixed`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.layout.center-focused-column`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"never"`, `"always"`, `"on-overflow"` *(default: `"never"`)* 

### `programs.niri.settings.layout.always-center-single-column`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layout.empty-workspace-above-first`

**Type:** `null` or `bool`  **Default:** `null`
**Values:** `true`, `false`

### `programs.niri.settings.layout.default-column-display`

**Type:** `null` or `string`  **Default:** `null`
**Values:** `"normal"`, `"tabbed"`

### `programs.niri.settings.layout.gaps`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.layout.struts`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.layout.struts.left`

**Type:** `float`

### `programs.niri.settings.layout.struts.right`

**Type:** `float`

### `programs.niri.settings.layout.struts.top`

**Type:** `float`

### `programs.niri.settings.layout.struts.bottom`

**Type:** `float`

### `programs.niri.settings.layout.background-color`

**Type:** `null` or `string`  **Default:** `null`

---

## `programs.niri.settings.recent-windows`

### `programs.niri.settings.recent-windows.on`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.recent-windows.off`

**Type:** `bool`  **Default:** `false`
**Values:** `true`, `false`

### `programs.niri.settings.recent-windows.debounce-ms`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.recent-windows.open-delay-ms`

**Type:** `null` or `int`  **Default:** `null`

### `programs.niri.settings.recent-windows.highlight`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.recent-windows.highlight.active-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.recent-windows.highlight.urgent-color`

**Type:** `null` or `string`  **Default:** `null`

### `programs.niri.settings.recent-windows.highlight.padding`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.recent-windows.highlight.corner-radius`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.recent-windows.previews`

**Type:** `null` or `submodule`  **Default:** `null`

### `programs.niri.settings.recent-windows.previews.max-height`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.recent-windows.previews.max-scale`

**Type:** `null` or `float`  **Default:** `null`

### `programs.niri.settings.recent-windows.binds`

**Type:** `null` or `attrs`  **Default:** `null`

---

