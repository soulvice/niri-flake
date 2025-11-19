# Documentation generation script for niri-flake
# Run with: nix build -f generate-docs.nix
{ pkgs ? import <nixpkgs> {} }:

let
  # Import our generator
  generator = import ./generator { inherit pkgs; };
  lib = pkgs.lib;

  # Fetch niri source (same as in flake.nix)
  niriSrc = pkgs.fetchFromGitHub {
    owner = "soulvice";
    repo = "niri";
    rev = "dfcbbbb03071cadf3fd9bbb0903ead364a839412";
    sha256 = "0ad642z34vfvdv22bzl7m9c13f1m45va43whmjhvyxkqf72nssj5";
  };

  # Parse the configuration for documentation
  configStructs = generator.parser.parseNiriConfig niriSrc;
  nixTypes = generator.typeMapper.mapConfigToNixTypes configStructs;

  # Complete actions library (matching what would be in module-generator.nix)
  actionsLib = {
    # System & Power Management
    quit = "quit";
    suspend = "suspend";
    power_off_monitors = "power-off-monitors";
    power_on_monitors = "power-on-monitors";

    # Debug & Development
    toggle_debug_tint = "toggle-debug-tint";
    debug_toggle_opaque_regions = "debug-toggle-opaque-regions";
    debug_toggle_damage = "debug-toggle-damage";
    toggle_keyboard_shortcuts_inhibit = "toggle-keyboard-shortcuts-inhibit";
    show_hotkey_overlay = "show-hotkey-overlay";
    do_screen_transition = "do-screen-transition";

    # Application Spawning
    spawn = "spawn";
    spawn_sh = "spawn-sh";

    # Screenshots
    screenshot = "screenshot";
    screenshot_screen = "screenshot-screen";
    screenshot_window = "screenshot-window";

    # Basic Window Management
    close_window = "close-window";
    fullscreen_window = "fullscreen-window";
    toggle_windowed_fullscreen = "toggle-windowed-fullscreen";
    maximize_window_to_edges = "maximize-window-to-edges";
    center_window = "center-window";

    # Window Focus Navigation
    focus_window_previous = "focus-window-previous";
    focus_window_up = "focus-window-up";
    focus_window_down = "focus-window-down";
    focus_window_top = "focus-window-top";
    focus_window_bottom = "focus-window-bottom";
    focus_window_down_or_top = "focus-window-down-or-top";
    focus_window_up_or_bottom = "focus-window-up-or-bottom";

    # Window Movement
    move_window_up = "move-window-up";
    move_window_down = "move-window-down";
    move_window_down_or_to_workspace_down = "move-window-down-or-to-workspace-down";
    move_window_up_or_to_workspace_up = "move-window-up-or-to-workspace-up";

    # Column Focus Navigation
    focus_column_left = "focus-column-left";
    focus_column_right = "focus-column-right";
    focus_column_first = "focus-column-first";
    focus_column_last = "focus-column-last";
    focus_column_right_or_first = "focus-column-right-or-first";
    focus_column_left_or_last = "focus-column-left-or-last";
    focus_column = "focus-column";

    # Column Movement
    move_column_left = "move-column-left";
    move_column_right = "move-column-right";
    move_column_to_first = "move-column-to-first";
    move_column_to_last = "move-column-to-last";
    move_column_to_index = "move-column-to-index";
    move_column_left_or_to_monitor_left = "move-column-left-or-to-monitor-left";
    move_column_right_or_to_monitor_right = "move-column-right-or-to-monitor-right";

    # Combined Focus (Window/Monitor Navigation)
    focus_window_or_monitor_up = "focus-window-or-monitor-up";
    focus_window_or_monitor_down = "focus-window-or-monitor-down";
    focus_column_or_monitor_left = "focus-column-or-monitor-left";
    focus_column_or_monitor_right = "focus-column-or-monitor-right";
    focus_window_down_or_column_left = "focus-window-down-or-column-left";
    focus_window_down_or_column_right = "focus-window-down-or-column-right";
    focus_window_up_or_column_left = "focus-window-up-or-column-left";
    focus_window_up_or_column_right = "focus-window-up-or-column-right";
    focus_window_or_workspace_down = "focus-window-or-workspace-down";
    focus_window_or_workspace_up = "focus-window-or-workspace-up";

    # Column Management
    center_column = "center-column";
    center_visible_columns = "center-visible-columns";
    maximize_column = "maximize-column";
    set_column_width = "set-column-width";
    expand_column_to_available_width = "expand-column-to-available-width";

    # Monitor Focus Navigation
    focus_monitor_left = "focus-monitor-left";
    focus_monitor_right = "focus-monitor-right";
    focus_monitor_down = "focus-monitor-down";
    focus_monitor_up = "focus-monitor-up";
    focus_monitor_previous = "focus-monitor-previous";
    focus_monitor_next = "focus-monitor-next";
    focus_monitor = "focus-monitor";

    # Window to Monitor Movement
    move_window_to_monitor_left = "move-window-to-monitor-left";
    move_window_to_monitor_right = "move-window-to-monitor-right";
    move_window_to_monitor_down = "move-window-to-monitor-down";
    move_window_to_monitor_up = "move-window-to-monitor-up";
    move_window_to_monitor_previous = "move-window-to-monitor-previous";
    move_window_to_monitor_next = "move-window-to-monitor-next";
    move_window_to_monitor = "move-window-to-monitor";

    # Workspace Management
    focus_workspace_down = "focus-workspace-down";
    focus_workspace_up = "focus-workspace-up";
    focus_workspace = "focus-workspace";
    focus_workspace_previous = "focus-workspace-previous";

    # Floating Window Management
    toggle_window_floating = "toggle-window-floating";
    move_window_to_floating = "move-window-to-floating";
    move_window_to_tiling = "move-window-to-tiling";
    focus_floating = "focus-floating";
    focus_tiling = "focus-tiling";
    switch_focus_between_floating_and_tiling = "switch-focus-between-floating-and-tiling";

    # Overview Mode
    toggle_overview = "toggle-overview";
    open_overview = "open-overview";
    close_overview = "close-overview";
  };

  # Extract niri version information from flake.nix
  flakeContents = builtins.readFile ./flake.nix;

  # Extract commit hash from flake.nix
  extractCommit = content:
    let
      lines = lib.splitString "\n" content;
      revLine = lib.findFirst (line: lib.hasInfix "rev =" line) "" lines;
      matches = builtins.match ".*rev = \"([^\"]*)\";.*" revLine;
    in
    if matches != null then builtins.head matches else null;

  # Extract sha256 from flake.nix
  extractSha256 = content:
    let
      lines = lib.splitString "\n" content;
      shaLine = lib.findFirst (line: lib.hasInfix "sha256 =" line) "" lines;
      matches = builtins.match ".*sha256 = \"([^\"]*)\";.*" shaLine;
    in
    if matches != null then builtins.head matches else null;

  commit = extractCommit flakeContents;
  sha256 = extractSha256 flakeContents;

  # Niri version information
  niriInfo = {
    commit = commit;
    sha256 = sha256;
    commitMessage = "Latest integrated commit"; # Could be enhanced with API call
    repository = "soulvice/niri";
  };

  # Generate comprehensive documentation
  docs = generator.generateComprehensiveDocs {
    inherit nixTypes actionsLib niriInfo;
  };

in pkgs.writeTextFile {
  name = "niri-module-comprehensive-docs";
  text = docs;
  destination = "/MODULE_OPTIONS.md";
}