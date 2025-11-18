{ config, pkgs, ... }:

{
  programs.niri = {
    enable = true;

    settings = {
      # Advanced input configuration
      input = {
        keyboard = {
          xkb = {
            layout = "us,ru";
            variant = ",";
            options = "grp:alt_shift_toggle,caps:escape";
          };
          repeat-delay = 400;
          repeat-rate = 30;
          track-layout = "window";
        };

        touchpad = {
          tap = true;
          drag = true;
          drag-lock = false;
          natural-scroll = true;
          accel-profile = "adaptive";
          accel-speed = 0.3;
          scroll-method = "two-finger";
          click-method = "clickfinger";
          tap-button-map = "left-right-middle";
        };

        mouse = {
          accel-profile = "flat";
          accel-speed = 0.0;
          natural-scroll = false;
        };

        focus-follows-mouse = {
          max-scroll-amount = 5;
        };

        workspace-auto-back-and-forth = true;
      };

      # Multiple outputs configuration
      outputs = [
        {
          name = "eDP-1";
          scale = 1.25;
          transform = "normal";
          position = { x = 0; y = 0; };
          mode = {
            width = 2560;
            height = 1600;
            refresh-rate = 165.0;
          };
        }
        {
          name = "DP-1";
          scale = 1.0;
          position = { x = 2560; y = 0; };
          mode = {
            width = 3440;
            height = 1440;
            refresh-rate = 144.0;
          };
        }
      ];

      # Advanced layout configuration
      layout = {
        gaps = 12;
        center-focused-column = "on-overflow";
        always-center-single-column = true;

        focus-ring = {
          enable = true;
          width = 2;
          active-color = "#7fc8ff";
          inactive-color = "#404040";
        };

        border = {
          enable = true;
          width = 1;
          active-color = "#7fc8ff";
          inactive-color = "#404040";
        };

        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 0.75; }
        ];
      };

      # Animation configuration
      animations = {
        slowdown = 0.8;
        workspace-switch = "spring";
        window-open = "easing";
        window-close = "easing";
      };

      # Key bindings
      binds = with config.lib.niri.actions; {
        # Application launching
        "Mod+Return".action = spawn "alacritty";
        "Mod+E".action = spawn "nautilus";
        "Mod+B".action = spawn "firefox";
        "Mod+D".action = spawn "wofi --show drun";

        # Window management
        "Mod+Q".action = close-window;
        "Mod+F".action = fullscreen-window;

        # Focus movement
        "Mod+H".action = focus-left;
        "Mod+J".action = focus-down;
        "Mod+K".action = focus-up;
        "Mod+L".action = focus-right;

        # Window movement
        "Mod+Shift+H".action = move-left;
        "Mod+Shift+J".action = move-down;
        "Mod+Shift+K".action = move-up;
        "Mod+Shift+L".action = move-right;

        # Workspace navigation
        "Mod+1".action = "focus-workspace 1";
        "Mod+2".action = "focus-workspace 2";
        "Mod+3".action = "focus-workspace 3";
        "Mod+4".action = "focus-workspace 4";

        # Screenshots
        "Print".action = screenshot;

        # System
        "Mod+Shift+E".action = quit;
      };

      # Window rules
      window-rules = [
        {
          matches = [{ app-id = "firefox"; }];
          open-on-workspace = "browser";
        }
        {
          matches = [{ app-id = "Alacritty"; }];
          open-on-workspace = "terminal";
        }
        {
          matches = [{ app-id = "mpv"; }];
          open-floating = true;
        }
      ];

      # Workspaces
      workspaces = [
        { name = "browser"; }
        { name = "terminal"; }
        { name = "editor"; }
        { name = "media"; }
      ];

      # Startup applications
      spawn-at-startup = [
        "waybar"
        "mako"
        "swww-daemon"
      ];
    };
  };
}