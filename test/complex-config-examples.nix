# Complex Configuration Examples for Testing
# These examples test various advanced features of the niri home-manager module

{ config, lib, pkgs, ... }:

{
  # Example 1: Gaming Setup with Multiple Monitors
  gaming-setup = {
    programs.niri = {
      enable = true;
      settings = {
        # High refresh rate gaming inputs
        input = {
          keyboard = {
            xkb = {
              layout = "us";
              options = "caps:escape,compose:ralt";
            };
            repeat-delay = 200;
            repeat-rate = 50;
          };
          mouse = {
            accel-speed = -0.3;
            accel-profile = "flat"; # Raw input for gaming
          };
          focus-follows-mouse = {
            enable = false; # Disable for gaming
          };
        };

        # Multi-monitor gaming layout
        outputs = {
          "DP-1" = {
            mode = { width = 2560; height = 1440; refresh = 144.0; };
            scale = 1.0;
            position = { x = 0; y = 0; };
          };
          "DP-2" = {
            mode = { width = 1920; height = 1080; refresh = 60.0; };
            scale = 1.0;
            position = { x = 2560; y = 360; };
            transform = { rotation = 270; flipped = false; };
          };
        };

        # Gaming-optimized layout
        layout = {
          gaps = 8;
          center-focused-column = "never";
          preset-column-widths = [
            { fixed = 1920; }
            { proportion = 0.5; }
            { proportion = 0.75; }
            { fixed = 480; }
          ];
          focus-ring = {
            enable = true;
            active-color = "#ff6b6b";
            width = 3;
          };
          border.enable = false;
        };

        # Fast animations for gaming
        animations = {
          slowdown = 0.5; # Faster animations
          window-open.easing = {
            duration-ms = 100;
            curve = "ease-out-quad";
          };
          window-close.easing = {
            duration-ms = 80;
            curve = "ease-in-quad";
          };
          workspace-switch.spring = {
            damping-ratio = 0.9;
            stiffness = 1200;
            epsilon = 0.001;
          };
        };

        # Gaming bindings
        binds = with config.lib.niri.actions; {
          # Quick launchers
          "Mod+Return".action = spawn "alacritty";
          "Mod+G".action = spawn "steam";
          "Mod+B".action = spawn "firefox";

          # Gaming toggles
          "Mod+F11".action = toggle-debug-tint;
          "Mod+Shift+F".action = fullscreen-window;

          # Monitor focus
          "Mod+U".action = focus-monitor-left;
          "Mod+I".action = focus-monitor-right;
          "Mod+Shift+U".action = move-window-to-monitor-left;
          "Mod+Shift+I".action = move-window-to-monitor-right;
        };

        # Gaming window rules
        window-rules = [
          {
            matches = [{ app-id = "^steam_app_.*"; }];
            open-on-output = "DP-1";
            open-fullscreen = true;
            block-out-from = "screen-capture";
          }
          {
            matches = [{ app-id = "^discord$"; }];
            open-on-output = "DP-2";
            default-column-width = { fixed = 400; };
          }
          {
            matches = [{ app-id = "^obs$"; }];
            open-on-output = "DP-2";
            open-maximized = true;
          }
        ];

        # Workspaces for gaming
        workspaces = {
          "game" = { open-on-output = "DP-1"; };
          "stream" = { open-on-output = "DP-2"; };
          "browser" = {};
        };
      };
    };
  };

  # Example 2: Development Workflow Setup
  development-setup = {
    programs.niri = {
      enable = true;
      settings = {
        input = {
          keyboard = {
            xkb = {
              layout = "us,us";
              variant = ",colemak";
              options = "grp:win_space_toggle,caps:escape";
            };
            repeat-delay = 400;
            repeat-rate = 30;
          };
          touchpad = {
            tap = true;
            dwt = true;
            natural-scroll = true;
            accel-speed = 0.3;
            click-method = "clickfinger";
            scroll-method = "two-finger";
            tap-button-map = "left-right-middle";
          };
          focus-follows-mouse = {
            enable = true;
            max-scroll-amount = "10%";
          };
        };

        # Development-friendly layout
        layout = {
          gaps = 12;
          center-focused-column = "on-overflow";
          preset-column-widths = [
            { proportion = 0.25; } # Sidebar
            { proportion = 0.5; }  # Main editor
            { proportion = 0.75; } # Wide view
          ];
          default-column-width = { proportion = 0.6; };

          focus-ring = {
            enable = true;
            active-color = "#61dafb"; # React blue
            inactive-color = "#404040";
            width = 2;
          };

          border = {
            enable = true;
            active-color = "#f39c12"; # Orange
            inactive-color = "#34495e";
            width = 1;
          };

          struts = {
            left = 0;
            right = 0;
            top = 32;    # Space for top bar
            bottom = 0;
          };
        };

        # Smooth development animations
        animations = {
          slowdown = 1.0;
          window-open.spring = {
            damping-ratio = 0.8;
            stiffness = 800;
            epsilon = 0.0001;
          };
          window-close.spring = {
            damping-ratio = 0.9;
            stiffness = 1000;
            epsilon = 0.0001;
          };
          workspace-switch.spring = {
            damping-ratio = 0.75;
            stiffness = 600;
            epsilon = 0.001;
          };
          horizontal-view-movement.easing = {
            duration-ms = 250;
            curve = "ease-out-cubic";
          };
          window-movement.spring = {
            damping-ratio = 0.8;
            stiffness = 900;
            epsilon = 0.0001;
          };
          window-resize.spring = {
            damping-ratio = 0.75;
            stiffness = 700;
            epsilon = 0.0001;
          };
        };

        # Development bindings
        binds = with config.lib.niri.actions; {
          # Terminals
          "Mod+Return".action = spawn "wezterm";
          "Mod+Shift+Return".action = spawn "alacritty";

          # Editors
          "Mod+E".action = spawn "code";
          "Mod+Shift+E".action = spawn "nvim-qt";

          # Browsers for testing
          "Mod+B".action = spawn "firefox";
          "Mod+Shift+B".action = spawn "firefox" "--private-window";

          # Development tools
          "Mod+D".action = spawn "rofi" "-show" "drun";
          "Mod+P".action = spawn "1password" "--quick-access";

          # Window management optimized for coding
          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;
          "Mod+J".action = focus-window-down-or-column-left;
          "Mod+K".action = focus-window-up-or-column-right;

          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+L".action = move-column-right;
          "Mod+Shift+J".action = move-window-down-or-column-left;
          "Mod+Shift+K".action = move-window-up-or-column-right;

          # Column sizing for code layout
          "Mod+Equal".action = set-column-width { proportion = 0.5; };
          "Mod+Minus".action = set-column-width { proportion = 0.33333; };
          "Mod+0".action = set-column-width { proportion = 0.66667; };

          # Workspace switching for project management
          "Mod+1".action = focus-workspace "main";
          "Mod+2".action = focus-workspace "frontend";
          "Mod+3".action = focus-workspace "backend";
          "Mod+4".action = focus-workspace "testing";
          "Mod+5".action = focus-workspace "docs";

          "Mod+Shift+1".action = move-column-to-workspace "main";
          "Mod+Shift+2".action = move-column-to-workspace "frontend";
          "Mod+Shift+3".action = move-column-to-workspace "backend";
          "Mod+Shift+4".action = move-column-to-workspace "testing";
          "Mod+Shift+5".action = move-column-to-workspace "docs";
        };

        # Development window rules
        window-rules = [
          # Code editors get optimal sizing
          {
            matches = [
              { app-id = "^code.*"; }
              { app-id = "^nvim.*"; }
              { app-id = "^emacs.*"; }
            ];
            default-column-width = { proportion = 0.6; };
            open-on-workspace = "main";
          }

          # Terminals for different purposes
          {
            matches = [{ title = "^.*Development.*"; }];
            default-column-width = { proportion = 0.4; };
            open-on-workspace = "main";
          }

          # Browsers for testing
          {
            matches = [
              { app-id = "^firefox.*"; }
              { app-id = "^chromium.*"; }
            ];
            default-column-width = { proportion = 0.7; };
            open-on-workspace = "frontend";
          }

          # Documentation and reference
          {
            matches = [
              { title = ".*Documentation.*"; }
              { app-id = "^zeal$"; }
              { app-id = "^devdocs.*"; }
            ];
            default-column-width = { proportion = 0.5; };
            open-on-workspace = "docs";
          }

          # Communication tools
          {
            matches = [
              { app-id = "^slack$"; }
              { app-id = "^discord$"; }
              { app-id = "^element$"; }
            ];
            default-column-width = { fixed = 400; };
          }
        ];

        # Development workspaces
        workspaces = {
          "main" = {};
          "frontend" = {};
          "backend" = {};
          "testing" = {};
          "docs" = {};
          "communication" = {};
        };

        # Development environment
        environment = {
          "EDITOR" = "nvim";
          "BROWSER" = "firefox";
          "TERMINAL" = "wezterm";
          "QT_QPA_PLATFORM" = "wayland";
          "GDK_BACKEND" = "wayland,x11";
          "MOZ_ENABLE_WAYLAND" = "1";
          "CLUTTER_BACKEND" = "wayland";
          "SDL_VIDEODRIVER" = "wayland";
        };

        # Auto-start development tools
        spawn-at-startup = [
          { command = ["wezterm"]; }
          { command = ["firefox"]; }
          { command = ["code"]; }
          { command = ["1password"]; }
        ];
      };
    };
  };

  # Example 3: Content Creation & Streaming Setup
  streaming-setup = {
    programs.niri = {
      enable = true;
      settings = {
        # Streaming-optimized inputs
        input = {
          keyboard = {
            xkb = {
              layout = "us";
              options = "compose:ralt";
            };
            repeat-delay = 300;
            repeat-rate = 40;
          };

          mouse = {
            accel-speed = 0.0;
            accel-profile = "flat";
          };

          # Stream deck integration would go here
          focus-follows-mouse.enable = false;
        };

        # Multi-monitor streaming setup
        outputs = {
          # Main monitor for streaming software
          "DP-1" = {
            mode = { width = 2560; height = 1440; refresh = 60.0; };
            scale = 1.0;
            position = { x = 0; y = 0; };
          };
          # Secondary monitor for chat/monitoring
          "HDMI-A-1" = {
            mode = { width = 1920; height = 1080; refresh = 60.0; };
            scale = 1.0;
            position = { x = 2560; y = 180; };
            transform = { rotation = 0; flipped = false; };
          };
        };

        # Content creation layout
        layout = {
          gaps = 16;
          center-focused-column = "never";
          preset-column-widths = [
            { fixed = 320; }  # Chat sidebar
            { proportion = 0.6; } # Main content
            { proportion = 0.4; } # Tools/preview
          ];

          focus-ring = {
            enable = true;
            active-color = "#e74c3c"; # Stream red
            width = 4;
          };

          border = {
            enable = true;
            active-color = "#9b59b6"; # Purple accent
            width = 2;
          };
        };

        # Smooth content creation animations
        animations = {
          slowdown = 0.8; # Slightly faster for content work

          workspace-switch.spring = {
            damping-ratio = 0.8;
            stiffness = 800;
            epsilon = 0.001;
          };

          window-open.easing = {
            duration-ms = 200;
            curve = "ease-out-cubic";
          };
        };

        # Streaming keybindings
        binds = with config.lib.niri.actions; {
          # Quick access to streaming tools
          "Mod+O".action = spawn "obs";
          "Mod+Shift+O".action = spawn "obs" "--startstreaming";

          # Content creation tools
          "Mod+G".action = spawn "gimp";
          "Mod+I".action = spawn "inkscape";
          "Mod+A".action = spawn "audacity";
          "Mod+V".action = spawn "kdenlive";

          # Communication
          "Mod+C".action = spawn "discord";
          "Mod+T".action = spawn "telegram-desktop";

          # Browser for research/streaming platforms
          "Mod+B".action = spawn "firefox";

          # Monitor switching for streaming
          "Mod+M".action = focus-monitor-left;
          "Mod+Shift+M".action = focus-monitor-right;

          # Scene switching (could integrate with OBS)
          "F13".action = spawn "obs-cli" "scene" "Desktop";
          "F14".action = spawn "obs-cli" "scene" "Webcam";
          "F15".action = spawn "obs-cli" "scene" "Screen+Webcam";

          # Stream control
          "F16".action = spawn "obs-cli" "start-stream";
          "F17".action = spawn "obs-cli" "stop-stream";
          "F18".action = spawn "obs-cli" "toggle-mute";
        };

        # Content creation window rules
        window-rules = [
          # OBS gets main monitor and full attention
          {
            matches = [{ app-id = "^com.obsproject.Studio$"; }];
            open-on-output = "DP-1";
            default-column-width = { proportion = 0.8; };
            open-on-workspace = "streaming";
          }

          # Chat applications go to secondary monitor
          {
            matches = [
              { app-id = "^discord$"; }
              { app-id = "^org.telegram.desktop$"; }
              { title = ".*Twitch.*Chat.*"; }
            ];
            open-on-output = "HDMI-A-1";
            default-column-width = { fixed = 400; };
            open-on-workspace = "chat";
          }

          # Content creation tools
          {
            matches = [
              { app-id = "^gimp.*"; }
              { app-id = "^org.inkscape.Inkscape$"; }
              { app-id = "^kdenlive$"; }
              { app-id = "^audacity$"; }
            ];
            open-on-output = "DP-1";
            default-column-width = { proportion = 0.75; };
            open-on-workspace = "creation";
          }

          # Browser for streaming platforms
          {
            matches = [{ title = ".*Twitch.*|.*YouTube.*|.*OBS.*"; }];
            open-on-output = "DP-1";
            default-column-width = { proportion = 0.6; };
          }
        ];

        # Workspaces for content workflow
        workspaces = {
          "streaming" = { open-on-output = "DP-1"; };
          "creation" = { open-on-output = "DP-1"; };
          "chat" = { open-on-output = "HDMI-A-1"; };
          "browser" = {};
        };

        # Streaming environment variables
        environment = {
          "QT_QPA_PLATFORM" = "wayland";
          "GDK_BACKEND" = "wayland";
          # OBS Wayland support
          "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
        };

        # Auto-start streaming setup
        spawn-at-startup = [
          { command = ["obs"]; }
          { command = ["discord"]; }
          { command = ["firefox"]; }
        ];

        # Debug settings for streaming performance
        debug = {
          render-drm = true; # Better performance for streaming
          damage = "off"; # Reduce overhead
        };
      };
    };
  };
}