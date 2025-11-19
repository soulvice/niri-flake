# Example niri configuration showcasing the new validation and descriptions
# This demonstrates the comprehensive type checking and documentation now available

{ config, lib, pkgs, ... }:

{
  programs.niri = {
    enable = true;

    settings = {
      # Input configuration with full validation
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            variant = "dvorak";  # Validated as string
            options = "grp:alt_shift_toggle,caps:escape";
          };
          repeat_delay = 600;    # Validated as positive integer
          repeat_rate = 25;      # Validated as positive integer
        };

        touchpad = {
          tap = true;                    # Validated as boolean
          natural_scroll = true;         # Validated as boolean
          accel_profile = "adaptive";    # Validated enum: "adaptive" | "flat"
          accel_speed = 0.2;            # Validated as float between -1.0 and 1.0
          click_method = "clickfinger";  # Validated enum
          scroll_method = "two-finger";  # Validated enum
        };

        mouse = {
          accel_profile = "flat";
          accel_speed = 0.0;
        };
      };

      # Layout configuration with rich validation
      layout = {
        gaps = 16;                           # Validated as non-negative integer
        center_focused_column = "never";     # Validated enum: "never" | "always" | "on-overflow"
        always_center_single_column = true;  # Validated as boolean

        # Column width configuration
        default_column_width = {
          proportion = 0.5;  # Validated as float between 0.1 and 10.0
          # OR: fixed = 1920;  # Would be validated as positive integer
        };

        preset_column_widths = [
          0.25   # Validated proportions (0.0-1.0)
          0.5
          0.75
          1920   # OR validated fixed pixel sizes
        ];

        # Focus ring with color validation
        focus_ring = {
          enable = true;
          width = 4;                    # Validated as positive integer
          active_color = "#7fc8ff";     # Validated as hex color, CSS name, or rgb() function
          inactive_color = "#505050";   # Same color validation
        };

        # Border configuration
        border = {
          enable = true;
          width = 2;
          active_color = "#ffffff";
          inactive_color = "#808080";
        };

        # Struts (reserved screen areas)
        struts = {
          left = 0;     # Validated as non-negative integer
          right = 0;
          top = 32;     # Space for top bar
          bottom = 0;
        };
      };

      # Startup commands
      spawn_at_startup = [    # Validated as list of strings
        "waybar"
        "mako"
        "swww init"
      ];

      # Keybindings using the actions library
      binds = with config.lib.niri.actions; {
        # The actions use underscore_case in Nix but generate kebab-case commands
        "Mod+Return".action = spawn "alacritty";           # -> "spawn alacritty"
        "Mod+D".action = spawn "wofi --show drun";         # -> "spawn wofi --show drun"
        "Mod+Q".action = close_window;                     # -> "close-window"
        "Mod+F".action = fullscreen_window;                # -> "fullscreen-window"
        "Mod+Shift+Q".action = quit;                       # -> "quit"

        # Window focus navigation
        "Mod+Left".action = focus_column_left;             # -> "focus-column-left"
        "Mod+Right".action = focus_column_right;           # -> "focus-column-right"
        "Mod+Up".action = focus_window_up;                 # -> "focus-window-up"
        "Mod+Down".action = focus_window_down;             # -> "focus-window-down"

        # Window movement
        "Mod+Shift+Left".action = move_column_left;        # -> "move-column-left"
        "Mod+Shift+Right".action = move_column_right;      # -> "move-column-right"

        # Screenshots
        "Print".action = screenshot;                       # -> "screenshot"
        "Mod+Print".action = screenshot_window;            # -> "screenshot-window"
      };

      # Window rules with comprehensive validation
      window_rules = [
        {
          app_id = "^firefox$";           # Validated as regex pattern
          open_on_workspace = "browser";  # Cross-validated against workspaces list
          opacity = 0.95;                # Validated as float between 0.0 and 1.0
        }
        {
          title = ".*YouTube.*";         # Validated as regex pattern
          block_out_from = "screen-capture";  # Validated enum
        }
        {
          app_id = "^discord$";
          open_floating = true;          # Validated as boolean
          opacity = 0.9;
        }
      ];

      # Output configuration with validation
      outputs = [
        {
          name = "DP-1";                # Validated as string (output name)
          mode = {
            width = 2560;              # Validated as positive integer
            height = 1440;             # Validated as positive integer
            refresh = 144.0;           # Validated as float between 1 and 1000
          };
          scale = 1.0;                 # Validated as float between 0.1 and 10.0
          position = { x = 0; y = 0; }; # Validated as integers
          transform = "normal";        # Validated enum
        }
        {
          name = "HDMI-A-1";
          mode = {
            width = 1920;
            height = 1080;
            # refresh omitted - will use default
          };
          scale = 1.0;
          position = { x = 2560; y = 0; };
        }
      ];

      # Workspaces with cross-validation
      workspaces = [
        { name = "main"; open_on_output = "DP-1"; }      # output reference validated
        { name = "browser"; open_on_output = "DP-1"; }   # output reference validated
        { name = "chat"; open_on_output = "HDMI-A-1"; }  # output reference validated
      ];

      # Animation configuration
      animations = {
        shaders = true;              # Validated as boolean
        slowdown = 1.0;             # Validated as float between 0.001 and 100.0

        # Spring animations with detailed validation
        window_movement = {
          damping_ratio = 1.0;      # Validated between 0.1 and 10.0
          stiffness = 800.0;        # Validated >= 1
          epsilon = 0.0001;         # Validated between 0.00001 and 0.1
        };

        # Easing animations
        window_open = {
          duration_ms = 250;        # Validated as positive integer
          curve = "ease-out-cubic"; # Validated enum or cubic-bezier
        };

        workspace_switch = "off";   # Can be "off", spring config, or easing config
      };

      # Environment variables
      environment = {             # Validated as string -> string mapping
        EDITOR = "nvim";
        BROWSER = "firefox";
        TERM = "alacritty";
      };

      # Cursor configuration
      cursor = {
        theme = "Adwaita";        # Validated as string
        size = 24;                # Validated as positive integer
      };

      # Additional options
      prefer_no_csd = true;       # Validated as boolean
      screenshot_path = "~/Screenshots";  # Validated as string

      # Debug configuration (usually not needed)
      debug = {
        enable = false;           # Validated as boolean
      };
    };

    # Raw KDL for anything not yet supported by the schema
    extraConfig = ''
      // Custom experimental settings that aren't in the schema yet
      experimental {
          new-feature true
      }
    '';
  };
}

# Key Benefits of this new validation system:
#
# 1. **Type Safety**: Every option has proper type checking
#    - layout.gaps must be a non-negative integer
#    - colors are validated (hex, CSS names, rgb functions)
#    - enums prevent typos (e.g., accel_profile must be "adaptive" or "flat")
#
# 2. **Comprehensive Descriptions**: Each option has detailed documentation
#    - Explains what the option does
#    - Shows valid values and ranges
#    - Provides usage examples
#
# 3. **Cross-validation**: References are checked
#    - window_rules.open_on_workspace must reference a defined workspace
#    - workspace.open_on_output must reference a defined output
#
# 4. **IDE Support**: Your editor can now provide:
#    - Autocomplete for all available options
#    - Type checking in real-time
#    - Documentation on hover
#    - Error highlighting for invalid values
#
# 5. **Better Error Messages**: Instead of cryptic KDL parse errors,
#    you get clear Nix evaluation errors pointing to the exact issue
#
# 6. **Action Library**: The config.lib.niri.actions provides:
#    - Type-safe action references
#    - Consistent underscore_case -> kebab-case conversion
#    - Helper functions like spawn() for commands
#
# This transforms niri configuration from error-prone manual KDL writing
# to a fully validated, documented, and IDE-friendly experience!