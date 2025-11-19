# Final Example: Correct Kebab-Case Usage Throughout Niri Configuration
# This shows the proper kebab-case conventions for both Nix and generated KDL

{ config, lib, pkgs, ... }:

{
  programs.niri = {
    enable = true;

    settings = {
      # Input configuration - ALL using kebab-case
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            variant = "dvorak";
            options = "grp:alt_shift_toggle,caps:escape";
          };
          repeat-delay = 600;        # kebab-case → repeat-delay in KDL
          repeat-rate = 25;          # kebab-case → repeat-rate in KDL
          track-layout = "global";   # kebab-case → track-layout in KDL
        };

        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;     # kebab-case → natural-scroll in KDL
          accel-speed = 0.2;         # kebab-case → accel-speed in KDL
          accel-profile = "adaptive"; # kebab-case → accel-profile in KDL
          tap-button-map = "left-right-middle"; # kebab-case → tap-button-map in KDL
          click-method = "clickfinger";         # kebab-case → click-method in KDL
          scroll-method = "two-finger";         # kebab-case → scroll-method in KDL
        };

        mouse = {
          accel-profile = "flat";    # kebab-case → accel-profile in KDL
          accel-speed = 0.0;         # kebab-case → accel-speed in KDL
          natural-scroll = false;    # kebab-case → natural-scroll in KDL
        };

        # For tablets and touch devices
        tablet = {
          map-to-output = "DP-1";    # kebab-case → map-to-output in KDL
        };

        touch = {
          map-to-output = "eDP-1";   # kebab-case → map-to-output in KDL
        };
      };

      # Layout configuration with kebab-case
      layout = {
        gaps = 16;
        center-focused-column = "never";      # kebab-case → center-focused-column in KDL
        always-center-single-column = true;  # kebab-case → always-center-single-column in KDL

        # Column width configuration
        default-column-width = {             # kebab-case → default-column-width in KDL
          proportion = 0.5;
        };

        preset-column-widths = [             # kebab-case → preset-column-widths in KDL
          0.25 0.5 0.75 1920
        ];

        # Visual elements with kebab-case
        focus-ring = {                       # kebab-case → focus-ring in KDL
          enable = true;
          width = 4;
          active-color = "#7fc8ff";          # kebab-case → active-color in KDL
          inactive-color = "#505050";        # kebab-case → inactive-color in KDL
        };

        border = {
          enable = true;
          width = 2;
          active-color = "#ffffff";          # kebab-case → active-color in KDL
          inactive-color = "#808080";        # kebab-case → inactive-color in KDL
        };

        struts = {
          left = 0;
          right = 0;
          top = 32;
          bottom = 0;
        };
      };

      # Startup commands
      spawn-at-startup = [                   # kebab-case → spawn-at-startup in KDL
        "waybar"
        "mako"
        "swww init"
        "nm-applet --indicator"
      ];

      # Keybindings with kebab-case actions
      binds = with config.lib.niri.actions; {
        # Window management
        "Mod+Return".action = spawn "alacritty";
        "Mod+Q".action = close-window;                    # kebab-case action
        "Mod+F".action = fullscreen-window;               # kebab-case action
        "Mod+C".action = center-window;                   # kebab-case action

        # Focus navigation
        "Mod+Left".action = focus-column-left;            # kebab-case action
        "Mod+Right".action = focus-column-right;          # kebab-case action
        "Mod+Up".action = focus-window-up;                # kebab-case action
        "Mod+Down".action = focus-window-down;            # kebab-case action

        # Window movement
        "Mod+Shift+Left".action = move-column-left;       # kebab-case action
        "Mod+Shift+Right".action = move-column-right;     # kebab-case action
        "Mod+Shift+Up".action = move-window-up;           # kebab-case action
        "Mod+Shift+Down".action = move-window-down;       # kebab-case action

        # Workspace management
        "Mod+1".action = focus-workspace-down;            # kebab-case action
        "Mod+2".action = focus-workspace-up;              # kebab-case action

        # Monitor management
        "Mod+H".action = focus-monitor-left;              # kebab-case action
        "Mod+L".action = focus-monitor-right;             # kebab-case action

        # Floating windows
        "Mod+Space".action = toggle-window-floating;      # kebab-case action
        "Mod+Tab".action = switch-focus-between-floating-and-tiling; # kebab-case action

        # Screenshots
        "Print".action = screenshot;
        "Mod+Print".action = screenshot-window;           # kebab-case action
        "Mod+Shift+Print".action = screenshot-screen;     # kebab-case action

        # System control
        "Mod+Shift+Q".action = quit;
        "Mod+P".action = power-off-monitors;              # kebab-case action

        # Overview mode
        "Mod+O".action = toggle-overview;                 # kebab-case action
      };

      # Window rules with kebab-case fields
      window-rules = [                                    # kebab-case → window-rules in KDL
        {
          app-id = "^firefox$";                           # kebab-case → app-id in KDL
          open-on-workspace = "browser";                  # kebab-case → open-on-workspace in KDL
          open-on-output = "DP-1";                        # kebab-case → open-on-output in KDL
          opacity = 0.95;
        }
        {
          title = ".*YouTube.*";
          block-out-from = "screen-capture";             # kebab-case → block-out-from in KDL
        }
        {
          app-id = "^discord$";                           # kebab-case → app-id in KDL
          open-floating = true;                           # kebab-case → open-floating in KDL
          open-maximized = false;                         # kebab-case → open-maximized in KDL
          opacity = 0.9;
        }
        {
          app-id = "^steam_app_.*";                       # kebab-case → app-id in KDL
          open-fullscreen = true;                         # kebab-case → open-fullscreen in KDL
          block-out-from = "screencast";                 # kebab-case → block-out-from in KDL
        }
      ];

      # Output (monitor) configuration
      outputs = [
        {
          name = "DP-1";
          mode = {
            width = 2560;
            height = 1440;
            refresh = 144.0;
          };
          scale = 1.0;
          transform = "normal";
          position = { x = 0; y = 0; };
        }
        {
          name = "HDMI-A-1";
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
          scale = 1.0;
          position = { x = 2560; y = 0; };
        }
      ];

      # Workspaces with kebab-case
      workspaces = [
        { name = "main"; open-on-output = "DP-1"; }       # kebab-case → open-on-output in KDL
        { name = "browser"; open-on-output = "DP-1"; }    # kebab-case → open-on-output in KDL
        { name = "chat"; open-on-output = "HDMI-A-1"; }   # kebab-case → open-on-output in KDL
        { name = "gaming"; open-on-output = "DP-1"; }     # kebab-case → open-on-output in KDL
      ];

      # Animation configuration with kebab-case
      animations = {
        shaders = true;
        slowdown = 1.0;

        # Spring animations
        window-movement = {                               # kebab-case → window-movement in KDL
          damping-ratio = 1.0;                            # kebab-case → damping-ratio in KDL
          stiffness = 800.0;
          epsilon = 0.0001;
        };

        window-open = {                                   # kebab-case → window-open in KDL
          duration-ms = 250;                              # kebab-case → duration-ms in KDL
          curve = "ease-out-cubic";
        };

        window-close = {                                  # kebab-case → window-close in KDL
          duration-ms = 150;                              # kebab-case → duration-ms in KDL
          curve = "ease-out-quad";
        };

        window-resize = {                                 # kebab-case → window-resize in KDL
          damping-ratio = 1.2;                            # kebab-case → damping-ratio in KDL
          stiffness = 600.0;
          epsilon = 0.0001;
        };

        horizontal-view-movement = {                      # kebab-case → horizontal-view-movement in KDL
          damping-ratio = 1.0;                            # kebab-case → damping-ratio in KDL
          stiffness = 800.0;
          epsilon = 0.0001;
        };

        workspace-switch = "off";                         # kebab-case → workspace-switch in KDL

        config-notification-open-close = {               # kebab-case → config-notification-open-close in KDL
          duration-ms = 200;                              # kebab-case → duration-ms in KDL
          curve = "ease-out-cubic";
        };
      };

      # Environment variables
      environment = {
        EDITOR = "nvim";
        BROWSER = "firefox";
        TERM = "alacritty";
        RUST_LOG = "info";
      };

      # Cursor configuration
      cursor = {
        theme = "Adwaita";
        size = 24;
      };

      # Miscellaneous options
      prefer-no-csd = true;                              # kebab-case → prefer-no-csd in KDL
      screenshot-path = "~/Pictures/Screenshots";        # kebab-case → screenshot-path in KDL

      # Debug configuration (typically not needed in production)
      debug = {
        enable = false;
        dbus-interfaces-in-non-session-instances = false;  # kebab-case → dbus-interfaces-in-non-session-instances in KDL
        wait-for-frame-completion-before-queueing = false; # kebab-case → wait-for-frame-completion-before-queueing in KDL
        enable-color-transformations-capability = false;   # kebab-case → enable-color-transformations-capability in KDL
        emulate-zero-presentation-time = false;            # kebab-case → emulate-zero-presentation-time in KDL
      };
    };

    # Additional raw KDL for experimental features
    extraConfig = ''
      // Experimental features that may not be in the schema yet
      experimental {
          some-future-feature true
          beta-option "enabled"
      }

      // This raw KDL also uses kebab-case to match niri's conventions
      some-complex-rule {
          matches app-id="special-.*" title=".*DEBUG.*"
          custom-property "special-value"
          another-kebab-option true
      }
    '';
  };
}

/*
## Key Corrections Made:

### 1. **Consistent Kebab-Case Throughout**
- Nix configuration uses kebab-case: `repeat-delay`, `accel-profile`, etc.
- Generated KDL preserves kebab-case: `repeat-delay=600`, `accel-profile="adaptive"`
- Actions library uses kebab-case: `close-window`, `focus-column-left`, etc.

### 2. **No Unnecessary Conversion**
- Previous incorrect: kebab-case → snake_case → kebab-case
- Current correct: kebab-case → kebab-case (direct mapping)

### 3. **Benefits of This Approach**
- **Consistent**: Same case convention throughout (Nix → KDL)
- **Simple**: No conversion logic needed
- **Maintainable**: Single source of truth
- **Compatible**: Works with both Nix and niri expectations
- **IDE-Friendly**: Consistent autocomplete and validation

### 4. **Generated KDL Output Example**
```kdl
input {
    keyboard {
        repeat-delay 600
        repeat-rate 25
        track-layout "global"
    }
    touchpad {
        accel-profile "adaptive"
        accel-speed 0.200000
        natural-scroll true
        click-method "clickfinger"
    }
}

layout {
    gaps 16
    center-focused-column "never"
    focus-ring {
        enable true
        width 4
        active-color "#7fc8ff"
    }
}

window-rules app-id="^firefox$" open-on-workspace="browser" opacity=0.95
```

This matches niri's native kebab-case KDL format perfectly!
*/