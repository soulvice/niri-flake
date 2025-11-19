# Updated example showing the corrected kebab-case usage
{ config, lib, pkgs, ... }:

{
  programs.niri = {
    enable = true;

    settings = {
      # Input configuration - should use kebab-case
      input = {
        keyboard = {
          # repeat-delay instead of repeat_delay
          repeat-delay = 600;
          repeat-rate = 25;
        };

        touchpad = {
          # accel-profile instead of accel_profile
          accel-profile = "adaptive";
          accel-speed = 0.2;
          natural-scroll = true;
          click-method = "clickfinger";
          scroll-method = "two-finger";
          tap-button-map = "left-right-middle";
        };
      };

      # Layout configuration with kebab-case
      layout = {
        gaps = 16;
        # center-focused-column instead of center_focused_column
        center-focused-column = "never";
        always-center-single-column = true;

        # focus-ring instead of focus_ring
        focus-ring = {
          enable = true;
          width = 4;
          active-color = "#7fc8ff";
          inactive-color = "#505050";
        };

        # default-column-width instead of default_column_width
        default-column-width = {
          proportion = 0.5;
        };

        preset-column-widths = [ 0.25 0.5 0.75 1920 ];
      };

      # spawn-at-startup instead of spawn_at_startup
      spawn-at-startup = [
        "waybar"
        "mako"
        "swww init"
      ];

      # Bindings using the corrected kebab-case actions
      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "alacritty";
        "Mod+Q".action = close-window;        # kebab-case action
        "Mod+F".action = fullscreen-window;   # kebab-case action
        "Mod+Left".action = focus-column-left;  # kebab-case action
        "Print".action = screenshot;
      };

      # Window rules with kebab-case field names
      window-rules = [
        {
          # app-id instead of app_id
          app-id = "^firefox$";
          # open-on-workspace instead of open_on_workspace
          open-on-workspace = "browser";
          opacity = 0.95;
        }
        {
          title = ".*YouTube.*";
          # block-out-from instead of block_out_from
          block-out-from = "screen-capture";
        }
      ];

      # Workspaces with kebab-case
      workspaces = [
        { name = "main"; open-on-output = "DP-1"; }
        { name = "browser"; open-on-output = "DP-1"; }
      ];

      # Animation configuration
      animations = {
        window-movement = {
          damping-ratio = 1.0;   # kebab-case
          stiffness = 800.0;
          epsilon = 0.0001;
        };

        window-open = {
          duration-ms = 250;     # kebab-case
          curve = "ease-out-cubic";
        };
      };

      # Output configuration
      outputs = [
        {
          name = "DP-1";
          mode = {
            width = 2560;
            height = 1440;
            refresh = 144.0;
          };
        }
      ];
    };
  };
}

# Key changes for kebab-case consistency:
# 1. Actions: close_window → close-window (in nix identifiers)
# 2. Options: repeat_delay → repeat-delay
# 3. Options: focus_ring → focus-ring
# 4. Options: app_id → app-id
# 5. Options: spawn_at_startup → spawn-at-startup
# 6. Options: window_rules → window-rules
#
# The KDL generator will convert these back to snake_case for niri:
# - repeat-delay → repeat_delay in KDL
# - focus-ring → focus_ring in KDL
# - app-id → app_id in KDL