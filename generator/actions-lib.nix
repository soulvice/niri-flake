# Shared actions library for niri keybindings
# This provides a consistent set of action identifiers that use kebab-case
# and map directly to niri action strings without conversion

{
  # System & Power Management
  quit = "quit";
  suspend = "suspend";
  power-off-monitors = "power-off-monitors";
  power-on-monitors = "power-on-monitors";

  # Debug & Development
  toggle-debug-tint = "toggle-debug-tint";
  debug-toggle-opaque-regions = "debug-toggle-opaque-regions";
  debug-toggle-damage = "debug-toggle-damage";
  toggle-keyboard-shortcuts-inhibit = "toggle-keyboard-shortcuts-inhibit";
  show-hotkey-overlay = "show-hotkey-overlay";
  do-screen-transition = "do-screen-transition";

  # Application Spawning
  spawn = cmd: "spawn " + cmd;
  spawn-sh = cmd: "spawn sh -c '" + cmd + "'";

  # Screenshots
  screenshot = "screenshot";
  screenshot-screen = "screenshot-screen";
  screenshot-window = "screenshot-window";

  # Basic Window Management
  close-window = "close-window";
  fullscreen-window = "fullscreen-window";
  toggle-windowed-fullscreen = "toggle-windowed-fullscreen";
  maximize-window-to-edges = "maximize-window-to-edges";
  center-window = "center-window";

  # Window Focus Navigation
  focus-window-previous = "focus-window-previous";
  focus-window-up = "focus-window-up";
  focus-window-down = "focus-window-down";
  focus-window-top = "focus-window-top";
  focus-window-bottom = "focus-window-bottom";
  focus-window-down-or-top = "focus-window-down-or-top";
  focus-window-up-or-bottom = "focus-window-up-or-bottom";

  # Window Movement
  move-window-up = "move-window-up";
  move-window-down = "move-window-down";
  move-window-down-or-to-workspace-down = "move-window-down-or-to-workspace-down";
  move-window-up-or-to-workspace-up = "move-window-up-or-to-workspace-up";

  # Column Focus Navigation
  focus-column-left = "focus-column-left";
  focus-column-right = "focus-column-right";
  focus-column-first = "focus-column-first";
  focus-column-last = "focus-column-last";
  focus-column-right-or-first = "focus-column-right-or-first";
  focus-column-left-or-last = "focus-column-left-or-last";
  focus-column = "focus-column";

  # Column Movement
  move-column-left = "move-column-left";
  move-column-right = "move-column-right";
  move-column-to-first = "move-column-to-first";
  move-column-to-last = "move-column-to-last";
  move-column-to-index = "move-column-to-index";
  move-column-left-or-to-monitor-left = "move-column-left-or-to-monitor-left";
  move-column-right-or-to-monitor-right = "move-column-right-or-to-monitor-right";

  # Monitor Focus Navigation
  focus-monitor-left = "focus-monitor-left";
  focus-monitor-right = "focus-monitor-right";
  focus-monitor-down = "focus-monitor-down";
  focus-monitor-up = "focus-monitor-up";
  focus-monitor-previous = "focus-monitor-previous";
  focus-monitor-next = "focus-monitor-next";
  focus-monitor = "focus-monitor";

  # Window to Monitor Movement
  move-window-to-monitor-left = "move-window-to-monitor-left";
  move-window-to-monitor-right = "move-window-to-monitor-right";
  move-window-to-monitor-down = "move-window-to-monitor-down";
  move-window-to-monitor-up = "move-window-to-monitor-up";
  move-window-to-monitor-previous = "move-window-to-monitor-previous";
  move-window-to-monitor-next = "move-window-to-monitor-next";
  move-window-to-monitor = "move-window-to-monitor";

  # Workspace Management
  focus-workspace-down = "focus-workspace-down";
  focus-workspace-up = "focus-workspace-up";
  focus-workspace = "focus-workspace";
  focus-workspace-previous = "focus-workspace-previous";

  # Floating Window Management
  toggle-window-floating = "toggle-window-floating";
  move-window-to-floating = "move-window-to-floating";
  move-window-to-tiling = "move-window-to-tiling";
  focus-floating = "focus-floating";
  focus-tiling = "focus-tiling";
  switch-focus-between-floating-and-tiling = "switch-focus-between-floating-and-tiling";

  # Overview Mode
  toggle-overview = "toggle-overview";
  open-overview = "open-overview";
  close-overview = "close-overview";
}