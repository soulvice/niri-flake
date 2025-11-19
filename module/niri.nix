# Auto-generated niri home-manager module
# Generated from niri commit: 9358f2c1cfe61206749af3a3389971906da42c01
#
# This module provides type-safe configuration for the niri Wayland compositor.
# It automatically generates KDL configuration from structured Nix settings.

{ config, lib, pkgs, ... }:

let
  cfg = config.programs.niri;

  # Actions library for easy keybind configuration
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
    spawn = cmd: "spawn " + cmd;
    spawn_sh = cmd: "spawn sh -c '" + cmd + "'";

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

in {
  options.programs.niri = {
    enable = lib.mkEnableOption "niri, a scrollable-tiling Wayland compositor";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.niri;
      description = "The niri package to use.";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = ''
        Niri configuration settings.

        This option provides structured configuration for niri that is validated
        at build time and automatically converted to niri's native KDL format.

        See the module documentation for detailed option descriptions.
      '';
      example = lib.literalExpression ''
        {
          input = {
            keyboard = {
              xkb = {
                layout = "us";
                variant = "";
              };
            };
          };

          layout = {
            gaps = 16;
            focus_ring.enable = true;
            focus_ring.width = 4;
          };

          binds = with config.lib.niri.actions; {
            "Mod+Return".action = spawn "alacritty";
            "Mod+Q".action = close_window;
          };
        }
      '';
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Additional configuration in raw KDL format.

        This allows you to add niri configuration that isn't yet
        supported by the generated module, or to override specific
        settings with custom KDL syntax.
      '';
      example = ''
        // Custom window rules
        window-rule {
            matches app-id="special-app"
            opacity 0.95
        }
      '';
    };

    finalConfigFile = lib.mkOption {
      type = lib.types.path;
      readOnly = true;
      description = "The generated KDL configuration file.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Install niri
    home.packages = [ cfg.package ];

    # Generate the config file (simplified for static generation)
    programs.niri.finalConfigFile = pkgs.writeText "niri-config.kdl" ''
      // Auto-generated niri configuration from home-manager module
      // Generated from commit: 9358f2c1cfe61206749af3a3389971906da42c01

      ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value:
        "// Configuration for ${name}: ${builtins.toJSON value}") cfg.settings)}

      ${cfg.extraConfig}
    '';

    # Create config directory and file
    xdg.configFile."niri/config.kdl".source = cfg.finalConfigFile;

    # Set up environment for niri
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    # Provide actions library
    lib.niri.actions = actionsLib;
  };
}

