# Examples of using programs.niri.settings.extraConfig
# This demonstrates various use cases for raw KDL configuration

{ config, lib, pkgs, ... }:

{
  # Example 1: Basic extraConfig usage
  basic-extra = {
    programs.niri = {
      enable = true;
      settings = {
        # Regular structured configuration
        input.keyboard = {
          repeat-delay = 600;
          xkb.layout = "us";
        };

        layout.gaps = 16;
      };

      # Raw KDL for additional features
      extraConfig = ''
        // Experimental debug settings
        debug {
            render-drm true
            damage "off"
            dbus-interfaces-in-non-session-instances false
        }

        // Custom environment variables
        environment {
            CUSTOM_VAR "custom_value"
            EXPERIMENTAL_FEATURE "1"
        }
      '';
    };
  };

  # Example 2: Override and extend existing configuration
  override-extend = {
    programs.niri = {
      enable = true;
      settings = {
        # Define basic binds through Nix
        binds = with config.lib.niri.actions; {
          "Mod+Return".action = spawn "alacritty";
          "Mod+Q".action = close-window;
        };

        # Basic window rules
        window-rules = [
          {
            matches = [{ app-id = "^firefox$"; }];
            default-column-width = { proportion = 0.75; };
          }
        ];
      };

      # Extend with complex configurations
      extraConfig = ''
        // Additional complex binds that are hard to express in Nix
        binds {
            Mod+Alt+Shift+R {
                action = spawn "sh" "-c" "grim -g \"$(slurp)\" - | wl-copy";
            }
            Mod+Ctrl+Alt+S {
                action = spawn "bash" "-c" "systemctl --user restart pipewire";
            }
        }

        // Complex window rules with multiple conditions
        window-rule {
            matches app-id="^jetbrains-.*" title=".*\\.rs.*"
            default-column-width { proportion 0.8; }
            min-width 800
            exclude-from-screenshot false
        }

        window-rule {
            matches title="^Picture-in-Picture$"
            open-floating true
            min-width 320
            min-height 240
            default-column-width { fixed 400; }
        }
      '';
    };
  };

  # Example 3: Gaming setup with advanced configuration
  gaming-extraconfig = {
    programs.niri = {
      enable = true;
      settings = {
        # Standard gaming input setup
        input = {
          keyboard = {
            repeat-delay = 200;
            repeat-rate = 50;
          };
          mouse = {
            accel-speed = -0.3;
            accel-profile = "flat";
          };
        };

        # Basic layout
        layout.gaps = 8;
      };

      # Advanced gaming features via extraConfig
      extraConfig = ''
        // Gaming-specific optimizations
        debug {
            render-drm true
            damage "off"  // Reduce overhead for gaming
        }

        // Custom cursor configuration for gaming
        cursor {
            theme "Adwaita"
            size 24
        }

        // Gaming-specific window rules
        window-rule {
            matches app-id="^steam_app_.*"
            block-out-from "screencast"
            block-out-from "screen-capture"
            open-fullscreen true
            bypass-compositor true  // If this option exists in future
        }

        // Game launcher optimizations
        window-rule {
            matches app-id="^steam$" title="^Steam$"
            open-on-workspace "gaming"
            default-column-width { proportion 0.6; }
        }

        // Disable certain features during gaming
        animations {
            off true  // Turn off animations for better performance
        }

        // Custom bind for gaming mode toggle
        binds {
            Mod+F1 { action = spawn "toggle-gaming-mode.sh"; }
        }
      '';
    };
  };

  # Example 4: Development workflow with custom tools
  development-extraconfig = {
    programs.niri = {
      enable = true;
      settings = {
        # Standard development setup
        input.keyboard = {
          repeat-delay = 400;
          xkb = {
            layout = "us,us";
            variant = ",colemak";
            options = "grp:win_space_toggle,caps:escape";
          };
        };

        binds = with config.lib.niri.actions; {
          "Mod+Return".action = spawn "wezterm";
          "Mod+E".action = spawn "code";
        };
      };

      # Development-specific custom configuration
      extraConfig = ''
        // Custom development environment setup
        environment {
            EDITOR "nvim"
            BROWSER "firefox"
            TERMINAL "wezterm"

            // Development-specific variables
            NODE_ENV "development"
            RUST_LOG "debug"
            DEVELOPMENT_MODE "1"
        }

        // Advanced window rules for development tools
        window-rule {
            matches app-id="^code$" title=".*workspace.*"
            open-on-workspace "main"
            default-column-width { proportion 0.7; }
            min-width 1200
        }

        window-rule {
            matches title=".*DevTools.*"
            open-on-workspace "debug"
            default-column-width { proportion 0.5; }
            open-floating false
        }

        // Custom development bindings
        binds {
            // Quick project switcher
            Mod+Shift+P {
                action = spawn "sh" "-c" "cd ~/projects && find . -maxdepth 2 -name '.git' -type d | sed 's|/.git||' | sed 's|^./||' | wofi --dmenu | xargs -I{} code ~/projects/{}";
            }

            // Terminal in current project directory
            Mod+Shift+Return {
                action = spawn "sh" "-c" "wezterm start --cwd \"$(pwd)\"";
            }

            // Quick note taking
            Mod+N {
                action = spawn "sh" "-c" "code ~/notes/$(date +%Y-%m-%d).md";
            }
        }

        // Development startup programs
        spawn-at-startup {
            command "code"
        }
        spawn-at-startup {
            command "wezterm"
        }
        spawn-at-startup {
            command "firefox" "--new-window" "http://localhost:3000"
        }
      '';
    };
  };

  # Example 5: Streaming/Content Creation setup
  streaming-extraconfig = {
    programs.niri = {
      enable = true;
      settings = {
        # Basic streaming setup
        outputs = {
          "DP-1" = {
            mode = { width = 2560; height = 1440; refresh = 60.0; };
            position = { x = 0; y = 0; };
          };
          "HDMI-A-1" = {
            mode = { width = 1920; height = 1080; refresh = 60.0; };
            position = { x = 2560; y = 180; };
          };
        };
      };

      # Streaming-specific advanced configuration
      extraConfig = ''
        // Streaming optimizations
        debug {
            render-drm true
            damage "off"
        }

        // OBS-specific window rules
        window-rule {
            matches app-id="^com.obsproject.Studio$"
            open-on-output "DP-1"
            default-column-width { proportion 0.8; }
            exclude-from-screenshot true  // Don't capture OBS in screenshots
            block-out-from "screen-capture"  // Prevent recursive capture
        }

        // Chat overlay window
        window-rule {
            matches title=".*Chat.*Overlay.*"
            open-floating true
            open-on-output "DP-1"
            default-column-width { fixed 300; }
            opacity 0.8
        }

        // Stream deck / control panel
        window-rule {
            matches app-id="^streamdeck.*"
            open-on-output "HDMI-A-1"
            open-floating true
            default-column-width { fixed 400; }
        }

        // Custom streaming keybinds
        binds {
            // Quick scene switching (assuming external script)
            F13 { action = spawn "obs-cli" "scene" "Desktop"; }
            F14 { action = spawn "obs-cli" "scene" "Webcam"; }
            F15 { action = spawn "obs-cli" "scene" "Screen+Webcam"; }

            // Stream control
            F16 { action = spawn "obs-cli" "start-stream"; }
            F17 { action = spawn "obs-cli" "stop-stream"; }
            F18 { action = spawn "obs-cli" "toggle-mute" "Mic"; }

            // Quick screenshot for social media
            Mod+Print {
                action = spawn "sh" "-c" "grim ~/Pictures/stream-$(date +%Y%m%d_%H%M%S).png && notify-send 'Screenshot saved'";
            }
        }

        // Streaming startup applications
        spawn-at-startup {
            command "obs"
        }
        spawn-at-startup {
            command "discord"
        }
        spawn-at-startup {
            command "firefox" "https://twitch.tv/dashboard"
        }
      '';
    };
  };

  # Example 6: Mixed approach - Using both structured and raw config
  mixed-approach = {
    programs.niri = {
      enable = true;

      # Use structured config for type-safe, validated options
      settings = {
        input = {
          keyboard = {
            repeat-delay = 600;
            xkb = {
              layout = "us";
              options = "caps:escape,compose:ralt";
            };
          };
          touchpad = {
            tap = true;
            natural-scroll = true;
          };
        };

        layout = {
          gaps = 16;
          focus-ring = {
            enable = true;
            active-color = "#7fc8ff";
          };
        };

        # Structured binds for common actions
        binds = with config.lib.niri.actions; {
          "Mod+Return".action = spawn "alacritty";
          "Mod+Q".action = close-window;
          "Mod+F".action = fullscreen-window;
          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;
        };

        # Structured window rules for common cases
        window-rules = [
          {
            matches = [{ app-id = "^firefox$"; }];
            default-column-width = { proportion = 0.75; };
          }
          {
            matches = [{ app-id = "^code$"; }];
            default-column-width = { proportion = 0.6; };
          }
        ];
      };

      # Use extraConfig for advanced/experimental features
      extraConfig = ''
        // Experimental features not yet in the structured module
        experimental {
            new-feature true
            beta-option "enabled"
        }

        // Complex window rules that don't fit Nix structure well
        window-rule {
            matches app-id="^special-.*" title=".*[DEBUG].*"
            opacity 0.9
            exclude-from-screenshot true
            custom-property "special-value"
        }

        // Override specific parts of structured config if needed
        // (Note: extraConfig is appended, so this would add additional binds)
        binds {
            Mod+Shift+Escape {
                action = spawn "sh" "-c" "systemctl --user restart niri";
            }
        }

        // Custom debug settings
        debug {
            log-level "debug"
            custom-renderer true
        }
      '';
    };
  };
}