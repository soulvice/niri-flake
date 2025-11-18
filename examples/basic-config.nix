{ config, pkgs, ... }:

{
  programs.niri = {
    enable = true;

    settings = {
      # Input device configuration
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            variant = "";
            options = "";
          };
          repeat-delay = 600;
          repeat-rate = 25;
          track-layout = "global";
        };

        touchpad = {
          tap = true;
          drag = true;
          natural-scroll = true;
          accel-profile = "adaptive";
          click-method = "clickfinger";
          scroll-method = "two-finger";
        };

        mouse = {
          accel-profile = "flat";
          natural-scroll = false;
        };

        focus-follows-mouse = {
          max-scroll-amount = 0;
        };
      };

      # Layout configuration
      layout = {
        gaps = 16;
        center-focused-column = "never";
        always-center-single-column = false;

        focus-ring = {
          enable = true;
          width = 4;
          active-color = "#7fc8ff";
          inactive-color = "#505050";
        };

        border = {
          enable = false;
          width = 4;
          active-color = "#ffc87f";
          inactive-color = "#505050";
        };

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
      };

      # Animation settings
      animations = {
        slowdown = 1.0;

        workspace-switch = {
          spring = {
            damping-ratio = 1.0;
            stiffness = 1000.0;
            epsilon = 0.0001;
          };
        };

        window-open = {
          easing = {
            duration-ms = 150;
            curve = "ease-out-expo";
          };
        };

        window-close = {
          easing = {
            duration-ms = 150;
            curve = "ease-out-quad";
          };
        };
      };

      # Startup commands
      spawn-at-startup = [
        "waybar"
        "mako"
        "swww-daemon"
      ];

      # Key bindings using the actions library
      binds = with config.lib.niri.actions; {
        # Terminal and launcher
        "Mod+Return".action = spawn "alacritty";
        "Mod+D".action = spawn "wofi --show drun";
        "Mod+Shift+Return".action = spawn "nautilus";

        # Window management
        "Mod+Q".action = close-window;
        "Mod+F".action = fullscreen-window;
        "Mod+Shift+F".action = maximize-window;

        # Focus movement
        "Mod+Left".action = focus-left;
        "Mod+Right".action = focus-right;
        "Mod+Up".action = focus-up;
        "Mod+Down".action = focus-down;

        "Mod+H".action = focus-left;
        "Mod+L".action = focus-right;
        "Mod+K".action = focus-up;
        "Mod+J".action = focus-down;

        # Window movement
        "Mod+Shift+Left".action = move-left;
        "Mod+Shift+Right".action = move-right;
        "Mod+Shift+Up".action = move-up;
        "Mod+Shift+Down".action = move-down;

        "Mod+Shift+H".action = move-left;
        "Mod+Shift+L".action = move-right;
        "Mod+Shift+K".action = move-up;
        "Mod+Shift+J".action = move-down;

        # Workspace navigation
        "Mod+Page_Up".action = focus-workspace-previous;
        "Mod+Page_Down".action = focus-workspace-next;
        "Mod+Ctrl+Up".action = focus-workspace-previous;
        "Mod+Ctrl+Down".action = focus-workspace-next;

        # Move to workspace
        "Mod+Shift+Page_Up".action = move-to-workspace-previous;
        "Mod+Shift+Page_Down".action = move-to-workspace-next;
        "Mod+Shift+Ctrl+Up".action = move-to-workspace-previous;
        "Mod+Shift+Ctrl+Down".action = move-to-workspace-next;

        # Column management
        "Mod+Ctrl+Left".action = focus-column-left;
        "Mod+Ctrl+Right".action = focus-column-right;
        "Mod+Ctrl+H".action = focus-column-left;
        "Mod+Ctrl+L".action = focus-column-right;

        "Mod+Shift+Ctrl+Left".action = move-column-left;
        "Mod+Shift+Ctrl+Right".action = move-column-right;
        "Mod+Shift+Ctrl+H".action = move-column-left;
        "Mod+Shift+Ctrl+L".action = move-column-right;

        # Screenshots
        "Print".action = screenshot;
        "Ctrl+Print".action = screenshot-window;

        # System
        "Mod+Shift+E".action = quit;
        "Mod+Shift+P".action = power-off-monitors;
      };

      # Window rules
      window-rules = [
        {
          matches = [ { app-id = "^org\\.gnome\\.Calculator$"; } ];
          default-column-width = { proportion = 0.25; };
          open-floating = true;
        }
        {
          matches = [ { title = "^Picture-in-Picture$"; } ];
          open-floating = true;
          geometry-corner-radius = 12.0;
        }
        {
          matches = [ { app-id = "^firefox$"; title = "^Developer Tools"; } ];
          open-on-output = "eDP-1";
        }
      ];

      # Named workspaces
      workspaces = [
        { name = "browser"; }
        { name = "terminal"; }
        { name = "editor"; }
        { name = "chat"; }
      ];
    };
  };
}