{ config, ... }:

{
  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            variant = "";
          };
          repeat_delay = 600;
          repeat_rate = 25;
        };

        touchpad = {
          tap = true;
          natural_scroll = true;
          accel_profile = "adaptive";
        };

        focus_follows_mouse = {
          max_scroll_amount = 0;
        };
      };

      layout = {
        gaps = 16;
        center_focused_column = "never";

        focus_ring = {
          enable = true;
          width = 4;
          active_color = "#7fc8ff";
          inactive_color = "#505050";
        };

        border = {
          enable = false;
        };
      };

      spawn_at_startup = [
        "waybar"
        "mako"
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "alacritty";
        "Mod+D".action = spawn "wofi --show drun";
        "Mod+Q".action = close_window;
        "Mod+F".action = fullscreen_window;

        "Mod+Left".action = focus_left;
        "Mod+Right".action = focus_right;
        "Mod+Up".action = focus_up;
        "Mod+Down".action = focus_down;

        "Mod+Shift+Left".action = move_left;
        "Mod+Shift+Right".action = move_right;
        "Mod+Shift+Up".action = move_up;
        "Mod+Shift+Down".action = move_down;

        "Mod+Page_Up".action = focus_workspace_previous;
        "Mod+Page_Down".action = focus_workspace_next;

        "Print".action = screenshot;
        "Mod+Shift+E".action = quit;
      };
    };
  };
}
