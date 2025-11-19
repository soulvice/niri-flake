# Comprehensive niri settings schema with validation and descriptions
# This file defines the complete structure of programs.niri.settings with
# proper types, validation, and documentation for each option.

{ lib }:

let
  inherit (lib) types mkOption;

  # Import existing validation types
  validation = import ./validation.nix { inherit lib; };

  inherit (validation)
    colorType
    floatOrIntType
    regexType
    cornerRadiusType
    presetSizeType
    gradientType
    modKeyType
    transformType
    centerFocusedColumnType
    columnDisplayType
    accelProfileType
    clickMethodType
    scrollMethodType
    tapButtonMapType
    trackLayoutType
    animationCurveType
    springParamsType
    easingParamsType
    animationType;

  # Additional custom types for niri configuration
  workspaceNameType = types.str // {
    description = "workspace name";
    descriptionClass = "noun";
  };

  outputNameType = types.str // {
    description = "output (monitor) name";
    descriptionClass = "noun";
  };

  bindingType = types.submodule {
    options = {
      action = mkOption {
        type = types.str;
        description = ''
          The action to perform when this binding is triggered.

          Use the actions from config.lib.niri.actions for type safety,
          or provide a raw action string.
        '';
        example = "close-window";
      };

      cooldown = mkOption {
        type = types.nullOr types.ints.positive;
        default = null;
        description = ''
          Cooldown in milliseconds to prevent rapid activation.

          Useful for actions like screenshot to prevent accidental spam.
        '';
        example = 1000;
      };
    };
  };

  # Window rule matching criteria
  windowRuleType = types.submodule {
    options = {
      # Matching criteria
      app-id = mkOption {
        type = types.nullOr regexType;
        default = null;
        description = ''
          Match windows by their application ID (Wayland) or WM_CLASS (X11).

          Supports regular expressions for flexible matching.
        '';
        example = "^firefox$";
      };

      title = mkOption {
        type = types.nullOr regexType;
        default = null;
        description = ''
          Match windows by their title/name.

          Supports regular expressions for flexible matching.
        '';
        example = ".*YouTube.*";
      };

      is-active = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = ''
          Match only the currently active window.

          Useful for rules that should only apply to focused windows.
        '';
      };

      is-floating = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = ''
          Match only floating or tiling windows.

          true = floating windows only
          false = tiling windows only
          null = both floating and tiling
        '';
      };

      # Actions to perform
      open-on-output = mkOption {
        type = types.nullOr outputNameType;
        default = null;
        description = ''
          Which output (monitor) to open this window on.

          Must reference an output defined in the outputs section.
        '';
        example = "DP-1";
      };

      open-on-workspace = mkOption {
        type = types.nullOr workspaceNameType;
        default = null;
        description = ''
          Which workspace to open this window on.

          Must reference a workspace defined in the workspaces section.
        '';
        example = "main";
      };

      open-floating = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = ''
          Whether to open this window as floating.

          true = always floating
          false = always tiling
          null = use default behavior
        '';
      };

      open-maximized = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = ''
          Whether to open this window maximized.

          Only applies to tiling windows.
        '';
      };

      open-fullscreen = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = ''
          Whether to open this window in fullscreen mode.
        '';
      };

      opacity = mkOption {
        type = types.nullOr (floatOrIntType 0.0 1.0);
        default = null;
        description = ''
          Window opacity/transparency level.

          0.0 = fully transparent
          1.0 = fully opaque
        '';
        example = 0.9;
      };

      block-out-from = mkOption {
        type = types.nullOr (types.enum ["screencast" "screen-capture"]);
        default = null;
        description = ''
          Block this window from appearing in screencasts or screenshots.

          Useful for sensitive windows like password managers.
        '';
      };
    };
  };

in {
  # Main niri configuration type
  niriSettingsType = types.submodule {
    options = {
      # Input configuration
      input = mkOption {
        type = types.nullOr (types.submodule {
          options = {
            keyboard = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  xkb = mkOption {
                    type = types.nullOr (types.submodule {
                      options = {
                        rules = mkOption {
                          type = types.nullOr types.str;
                          default = null;
                          description = "XKB rules file to use";
                          example = "evdev";
                        };

                        model = mkOption {
                          type = types.nullOr types.str;
                          default = null;
                          description = "XKB keyboard model";
                          example = "pc105";
                        };

                        layout = mkOption {
                          type = types.nullOr types.str;
                          default = null;
                          description = "XKB keyboard layout(s)";
                          example = "us,de";
                        };

                        variant = mkOption {
                          type = types.nullOr types.str;
                          default = null;
                          description = "XKB layout variant(s)";
                          example = "dvorak";
                        };

                        options = mkOption {
                          type = types.nullOr types.str;
                          default = null;
                          description = "XKB options";
                          example = "grp:alt_shift_toggle,caps:escape";
                        };
                      };
                    });
                    default = null;
                    description = ''
                      XKB (X Keyboard Extension) configuration.

                      Controls keyboard layout, variant, and options.
                    '';
                  };

                  repeat-delay = mkOption {
                    type = types.nullOr types.ints.positive;
                    default = null;
                    description = ''
                      Delay in milliseconds before key repeat starts.

                      Higher values mean you need to hold a key longer before it starts repeating.
                    '';
                    example = 600;
                  };

                  repeat-rate = mkOption {
                    type = types.nullOr types.ints.positive;
                    default = null;
                    description = ''
                      Key repeat rate in characters per second.

                      Higher values mean faster key repeat when holding a key.
                    '';
                    example = 25;
                  };

                  track-layout = mkOption {
                    type = types.nullOr trackLayoutType;
                    default = null;
                    description = ''
                      How to track keyboard layout changes.

                      "global" = same layout for all windows
                      "window" = remember layout per window
                    '';
                  };
                };
              });
              default = null;
              description = "Keyboard input configuration";
            };

            touchpad = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  tap = mkOption {
                    type = types.nullOr types.bool;
                    default = null;
                    description = ''
                      Enable tap-to-click on touchpad.

                      When enabled, lightly tapping the touchpad will register as a click.
                    '';
                  };

                  dwt = mkOption {
                    type = types.nullOr types.bool;
                    default = null;
                    description = ''
                      Disable touchpad while typing.

                      Prevents accidental touchpad activation when typing.
                    '';
                  };

                  natural_scroll = mkOption {
                    type = types.nullOr types.bool;
                    default = null;
                    description = ''
                      Enable natural (reversed) scrolling direction.

                      Scrolling down moves content down (like on mobile devices).
                    '';
                  };

                  accel_speed = mkOption {
                    type = types.nullOr (floatOrIntType (-1.0) 1.0);
                    default = null;
                    description = ''
                      Touchpad acceleration speed.

                      -1.0 = slowest
                       0.0 = default
                       1.0 = fastest
                    '';
                    example = 0.2;
                  };

                  accel_profile = mkOption {
                    type = types.nullOr accelProfileType;
                    default = null;
                    description = ''
                      Touchpad acceleration profile.

                      "adaptive" = cursor speed adapts to movement speed
                      "flat" = constant cursor speed regardless of movement
                    '';
                  };

                  tap_button_map = mkOption {
                    type = types.nullOr tapButtonMapType;
                    default = null;
                    description = ''
                      Touchpad tap button mapping.

                      "left-right-middle" = 1-finger=left, 2-finger=right, 3-finger=middle
                      "left-middle-right" = 1-finger=left, 2-finger=middle, 3-finger=right
                    '';
                  };

                  click_method = mkOption {
                    type = types.nullOr clickMethodType;
                    default = null;
                    description = ''
                      Touchpad click method.

                      "clickfinger" = click location determines button (modern)
                      "button-areas" = touchpad areas determine button (traditional)
                    '';
                  };

                  scroll_method = mkOption {
                    type = types.nullOr scrollMethodType;
                    default = null;
                    description = ''
                      Touchpad scroll method.

                      "two-finger" = scroll with two fingers (most common)
                      "edge" = scroll by moving along touchpad edge
                      "on-button-down" = scroll while holding button
                      "no-scroll" = disable scrolling
                    '';
                  };
                };
              });
              default = null;
              description = "Touchpad input configuration";
            };

            mouse = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  accel_speed = mkOption {
                    type = types.nullOr (floatOrIntType (-1.0) 1.0);
                    default = null;
                    description = ''
                      Mouse acceleration speed.

                      -1.0 = slowest
                       0.0 = default
                       1.0 = fastest
                    '';
                    example = 0.0;
                  };

                  accel_profile = mkOption {
                    type = types.nullOr accelProfileType;
                    default = null;
                    description = ''
                      Mouse acceleration profile.

                      "adaptive" = cursor speed adapts to movement speed
                      "flat" = constant cursor speed regardless of movement
                    '';
                  };

                  natural_scroll = mkOption {
                    type = types.nullOr types.bool;
                    default = null;
                    description = ''
                      Enable natural (reversed) scrolling direction.

                      Scrolling down moves content down (like on mobile devices).
                    '';
                  };
                };
              });
              default = null;
              description = "Mouse input configuration";
            };

            trackball = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  accel_speed = mkOption {
                    type = types.nullOr (floatOrIntType (-1.0) 1.0);
                    default = null;
                    description = "Trackball acceleration speed (-1.0 to 1.0)";
                    example = 0.0;
                  };

                  accel_profile = mkOption {
                    type = types.nullOr accelProfileType;
                    default = null;
                    description = "Trackball acceleration profile";
                  };

                  natural_scroll = mkOption {
                    type = types.nullOr types.bool;
                    default = null;
                    description = "Enable natural scrolling for trackball";
                  };
                };
              });
              default = null;
              description = "Trackball input configuration";
            };

            tablet = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  map_to_output = mkOption {
                    type = types.nullOr outputNameType;
                    default = null;
                    description = ''
                      Map tablet input to specific output.

                      Must reference an output defined in the outputs section.
                    '';
                    example = "DP-1";
                  };
                };
              });
              default = null;
              description = "Graphics tablet input configuration";
            };

            touch = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  map_to_output = mkOption {
                    type = types.nullOr outputNameType;
                    default = null;
                    description = ''
                      Map touch input to specific output.

                      Must reference an output defined in the outputs section.
                    '';
                    example = "eDP-1";
                  };
                };
              });
              default = null;
              description = "Touchscreen input configuration";
            };
          };
        });
        default = null;
        description = ''
          Input device configuration.

          Controls keyboards, mice, touchpads, tablets, and other input devices.
        '';
      };

      # Layout configuration
      layout = mkOption {
        type = types.nullOr (types.submodule {
          options = {
            gaps = mkOption {
              type = types.nullOr types.ints.unsigned;
              default = null;
              description = ''
                Gap size in pixels between windows and screen edges.

                Sets uniform gaps around all windows for a clean, spaced look.
              '';
              example = 16;
            };

            center_focused_column = mkOption {
              type = types.nullOr centerFocusedColumnType;
              default = null;
              description = ''
                When to center the focused column on screen.

                "never" = never center columns
                "always" = always center the focused column
                "on-overflow" = center only when columns don't fit on screen
              '';
            };

            always_center_single_column = mkOption {
              type = types.nullOr types.bool;
              default = null;
              description = ''
                Whether to center single columns on the screen.

                When only one column is present, center it instead of placing it at the left edge.
              '';
            };

            default_column_width = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  proportion = mkOption {
                    type = types.nullOr (floatOrIntType 0.1 10.0);
                    default = null;
                    description = ''
                      Default column width as proportion of screen width.

                      1.0 = full screen width
                      0.5 = half screen width
                      Values > 1.0 create wider-than-screen columns
                    '';
                    example = 0.5;
                  };

                  fixed = mkOption {
                    type = types.nullOr types.ints.positive;
                    default = null;
                    description = ''
                      Default column width in pixels.

                      Fixed pixel width regardless of screen size.
                    '';
                    example = 1920;
                  };
                };
              });
              default = null;
              description = ''
                Default width for new columns.

                Can be specified as either a proportion of screen width or fixed pixels.
                Only one of proportion or fixed should be set.
              '';
            };

            preset_column_widths = mkOption {
              type = types.nullOr (types.listOf presetSizeType);
              default = null;
              description = ''
                Predefined column widths for quick switching.

                List of widths that can be cycled through with keybindings.
                Values can be proportions (0.0-1.0) or fixed pixel sizes.
              '';
              example = [ 0.25 0.5 0.75 1920 ];
            };

            focus_ring = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  enable = mkOption {
                    type = types.nullOr types.bool;
                    default = null;
                    description = ''
                      Whether to show a focus ring around the active window.

                      Visual indicator to highlight which window has focus.
                    '';
                  };

                  width = mkOption {
                    type = types.nullOr types.ints.positive;
                    default = null;
                    description = ''
                      Focus ring width in pixels.

                      Thickness of the border drawn around the focused window.
                    '';
                    example = 4;
                  };

                  active_color = mkOption {
                    type = types.nullOr (types.oneOf [ colorType gradientType ]);
                    default = null;
                    description = ''
                      Color or gradient for the active window focus ring.

                      Can be a solid color or a gradient for visual effects.
                    '';
                    example = "#7fc8ff";
                  };

                  inactive_color = mkOption {
                    type = types.nullOr (types.oneOf [ colorType gradientType ]);
                    default = null;
                    description = ''
                      Color or gradient for inactive window focus rings.

                      Used for non-focused windows when they have visible focus indicators.
                    '';
                    example = "#505050";
                  };
                };
              });
              default = null;
              description = ''
                Focus ring visual indicator configuration.

                Shows a colored border around focused windows.
              '';
            };

            border = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  enable = mkOption {
                    type = types.nullOr types.bool;
                    default = null;
                    description = ''
                      Whether to show borders around windows.

                      Persistent borders around all windows, separate from focus rings.
                    '';
                  };

                  width = mkOption {
                    type = types.nullOr types.ints.positive;
                    default = null;
                    description = "Window border width in pixels";
                    example = 2;
                  };

                  active_color = mkOption {
                    type = types.nullOr (types.oneOf [ colorType gradientType ]);
                    default = null;
                    description = "Border color for the active window";
                    example = "#ffffff";
                  };

                  inactive_color = mkOption {
                    type = types.nullOr (types.oneOf [ colorType gradientType ]);
                    default = null;
                    description = "Border color for inactive windows";
                    example = "#808080";
                  };
                };
              });
              default = null;
              description = "Window border configuration";
            };

            struts = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  left = mkOption {
                    type = types.nullOr types.ints.unsigned;
                    default = null;
                    description = "Reserved space on left edge in pixels";
                    example = 64;
                  };

                  right = mkOption {
                    type = types.nullOr types.ints.unsigned;
                    default = null;
                    description = "Reserved space on right edge in pixels";
                    example = 64;
                  };

                  top = mkOption {
                    type = types.nullOr types.ints.unsigned;
                    default = null;
                    description = "Reserved space on top edge in pixels";
                    example = 32;
                  };

                  bottom = mkOption {
                    type = types.nullOr types.ints.unsigned;
                    default = null;
                    description = "Reserved space on bottom edge in pixels";
                    example = 32;
                  };
                };
              });
              default = null;
              description = ''
                Reserved screen edge space.

                Prevents windows from using specified screen areas, useful for panels/docks.
              '';
            };
          };
        });
        default = null;
        description = ''
          Window layout and visual configuration.

          Controls window positioning, spacing, borders, and visual indicators.
        '';
      };

      # Spawn at startup
      spawn_at_startup = mkOption {
        type = types.nullOr (types.listOf types.str);
        default = null;
        description = ''
          Commands to run when niri starts.

          List of shell commands that will be executed during niri initialization.
          Useful for starting essential applications like status bars, notification daemons, etc.
        '';
        example = [
          "waybar"
          "mako"
          "swww init"
        ];
      };

      # Keybindings
      binds = mkOption {
        type = types.nullOr (types.attrsOf (types.oneOf [ types.str bindingType ]));
        default = null;
        description = ''
          Keyboard and mouse bindings.

          Maps key combinations to actions. Use config.lib.niri.actions for predefined actions.

          Key syntax:
          - Modifiers: Mod (Super), Alt, Ctrl, Shift
          - Keys: letters, numbers, function keys (F1-F12), special keys
          - Mouse: click actions can be bound to mouse buttons

          Examples:
          - "Mod+Return" - Super + Enter
          - "Alt+Shift+Q" - Alt + Shift + Q
          - "Ctrl+Alt+Delete" - Ctrl + Alt + Delete
        '';
        example = {
          "Mod+Return" = "spawn alacritty";
          "Mod+Q" = "close-window";
          "Mod+D" = "spawn wofi --show drun";
        };
      };

      # Window rules
      window_rules = mkOption {
        type = types.nullOr (types.listOf windowRuleType);
        default = null;
        description = ''
          Per-window behavior rules.

          Configure how specific windows should behave based on their properties.
          Rules are evaluated in order, and the first matching rule applies.
        '';
        example = [
          {
            app_id = "^firefox$";
            open_on_workspace = "browser";
            opacity = 0.95;
          }
          {
            title = ".*YouTube.*";
            block_out_from = "screen-capture";
          }
        ];
      };

      # Outputs (monitors)
      outputs = mkOption {
        type = types.nullOr (types.listOf (types.submodule {
          options = {
            name = mkOption {
              type = outputNameType;
              description = ''
                Output connector name.

                Use `niri msg outputs` or check system logs to find available output names.
                Common examples: "DP-1", "HDMI-A-1", "eDP-1"
              '';
              example = "DP-1";
            };

            mode = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  width = mkOption {
                    type = types.ints.positive;
                    description = "Display width in pixels";
                    example = 1920;
                  };

                  height = mkOption {
                    type = types.ints.positive;
                    description = "Display height in pixels";
                    example = 1080;
                  };

                  refresh = mkOption {
                    type = types.nullOr (floatOrIntType 1 1000);
                    default = null;
                    description = "Refresh rate in Hz";
                    example = 144.0;
                  };
                };
              });
              default = null;
              description = ''
                Display mode configuration.

                If not specified, niri will use the preferred mode from EDID.
              '';
            };

            scale = mkOption {
              type = types.nullOr (floatOrIntType 0.1 10.0);
              default = null;
              description = ''
                Display scaling factor.

                1.0 = no scaling (100%)
                2.0 = 2x scaling (200%)
                1.5 = 1.5x scaling (150%)

                Higher values make UI elements larger for high-DPI displays.
              '';
              example = 1.5;
            };

            transform = mkOption {
              type = types.nullOr transformType;
              default = null;
              description = ''
                Display rotation and reflection.

                "normal" = no rotation
                "90", "180", "270" = clockwise rotation in degrees
                "flipped-*" = mirror horizontally then rotate
              '';
            };

            position = mkOption {
              type = types.nullOr (types.submodule {
                options = {
                  x = mkOption {
                    type = types.int;
                    description = "Horizontal position in pixels";
                    example = 1920;
                  };

                  y = mkOption {
                    type = types.int;
                    description = "Vertical position in pixels";
                    example = 0;
                  };
                };
              });
              default = null;
              description = ''
                Output position in the global coordinate space.

                Used for multi-monitor setups to specify monitor arrangement.
                If not specified, niri will arrange outputs automatically.
              '';
            };
          };
        }));
        default = null;
        description = ''
          Display output configuration.

          Configure connected monitors/displays including resolution, scaling, and positioning.
          Use `niri msg outputs` to see available outputs.
        '';
        example = [
          {
            name = "DP-1";
            mode = { width = 2560; height = 1440; refresh = 144.0; };
            scale = 1.0;
            position = { x = 0; y = 0; };
          }
          {
            name = "HDMI-A-1";
            mode = { width = 1920; height = 1080; };
            scale = 1.0;
            position = { x = 2560; y = 0; };
          }
        ];
      };

      # Workspaces
      workspaces = mkOption {
        type = types.nullOr (types.listOf (types.submodule {
          options = {
            name = mkOption {
              type = workspaceNameType;
              description = "Workspace name/identifier";
              example = "main";
            };

            open_on_output = mkOption {
              type = types.nullOr outputNameType;
              default = null;
              description = ''
                Which output this workspace should open on.

                Must reference an output defined in the outputs section.
              '';
              example = "DP-1";
            };
          };
        }));
        default = null;
        description = ''
          Workspace definitions.

          Define named workspaces that can be referenced in window rules and keybindings.
        '';
        example = [
          { name = "main"; open_on_output = "DP-1"; }
          { name = "browser"; open_on_output = "DP-1"; }
          { name = "chat"; open_on_output = "HDMI-A-1"; }
        ];
      };

      # Animations
      animations = mkOption {
        type = types.nullOr (types.submodule {
          options = {
            shaders = mkOption {
              type = types.nullOr types.bool;
              default = null;
              description = ''
                Whether to use GPU shaders for animations.

                Provides smoother animations but may increase GPU usage.
              '';
            };

            slowdown = mkOption {
              type = types.nullOr (floatOrIntType 0.001 100.0);
              default = null;
              description = ''
                Global animation speed multiplier.

                1.0 = normal speed
                2.0 = half speed (slower)
                0.5 = double speed (faster)
              '';
              example = 1.0;
            };

            window_movement = mkOption {
              type = types.nullOr animationType;
              default = null;
              description = ''
                Animation for window movement between columns.

                Controls how smoothly windows animate when moved around.
              '';
            };

            window_open = mkOption {
              type = types.nullOr animationType;
              default = null;
              description = ''
                Animation for new window appearance.

                Controls how new windows animate when they first appear.
              '';
            };

            window_close = mkOption {
              type = types.nullOr animationType;
              default = null;
              description = ''
                Animation for window closure.

                Controls how windows animate when being closed.
              '';
            };

            window_resize = mkOption {
              type = types.nullOr animationType;
              default = null;
              description = ''
                Animation for window resizing.

                Controls how smoothly windows animate when being resized.
              '';
            };

            horizontal_view_movement = mkOption {
              type = types.nullOr animationType;
              default = null;
              description = ''
                Animation for horizontal workspace/column scrolling.

                Controls smoothness when moving between columns or workspaces.
              '';
            };

            workspace_switch = mkOption {
              type = types.nullOr animationType;
              default = null;
              description = ''
                Animation for workspace switching.

                Controls how smoothly the view transitions between workspaces.
              '';
            };

            config_notification_open_close = mkOption {
              type = types.nullOr animationType;
              default = null;
              description = ''
                Animation for configuration reload notifications.

                Controls how config change notifications appear and disappear.
              '';
            };
          };
        });
        default = null;
        description = ''
          Animation configuration.

          Controls various animations throughout the compositor for smooth visual transitions.
        '';
      };

      # Environment variables
      environment = mkOption {
        type = types.nullOr (types.attrsOf types.str);
        default = null;
        description = ''
          Environment variables to set for spawned processes.

          These variables will be available to all applications launched by niri.
        '';
        example = {
          EDITOR = "nvim";
          BROWSER = "firefox";
          TERM = "alacritty";
        };
      };

      # Cursor configuration
      cursor = mkOption {
        type = types.nullOr (types.submodule {
          options = {
            theme = mkOption {
              type = types.nullOr types.str;
              default = null;
              description = ''
                Cursor theme name.

                Must be installed on the system and available in cursor theme directories.
              '';
              example = "Adwaita";
            };

            size = mkOption {
              type = types.nullOr types.ints.positive;
              default = null;
              description = ''
                Cursor size in pixels.

                Larger values make the cursor bigger and more visible.
              '';
              example = 24;
            };
          };
        });
        default = null;
        description = ''
          Mouse cursor appearance configuration.

          Controls the visual appearance of the mouse cursor.
        '';
      };

      # Prefer no CSD (client-side decorations)
      prefer_no_csd = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = ''
          Whether to prefer server-side decorations over client-side.

          When true, asks applications to use server-side window decorations
          instead of drawing their own title bars and borders.
        '';
      };

      # Screenshot path
      screenshot_path = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Directory path for saving screenshots.

          Screenshots taken with niri will be saved to this directory.
          If not specified, uses the default Pictures directory.
        '';
        example = "~/Screenshots";
      };

      # Debug configuration
      debug = mkOption {
        type = types.nullOr (types.submodule {
          options = {
            enable = mkOption {
              type = types.nullOr types.bool;
              default = null;
              description = ''
                Enable debug mode.

                Shows additional debugging information and overlays.
              '';
            };

            dbus_interfaces_in_non_session_instances = mkOption {
              type = types.nullOr types.bool;
              default = null;
              description = ''
                Enable D-Bus interfaces in non-session instances.

                Useful for debugging and testing when niri isn't running as the main session.
              '';
            };

            wait_for_frame_completion_before_queueing = mkOption {
              type = types.nullOr types.bool;
              default = null;
              description = ''
                Wait for frame completion before queueing next frame.

                May reduce performance but can help debug frame timing issues.
              '';
            };

            enable_color_transformations_capability = mkOption {
              type = types.nullOr types.bool;
              default = null;
              description = ''
                Enable color transformation capability.

                Experimental feature for advanced color management.
              '';
            };

            emulate_zero_presentation_time = mkOption {
              type = types.nullOr types.bool;
              default = null;
              description = ''
                Emulate zero presentation time.

                Debugging option for timing-related issues.
              '';
            };
          };
        });
        default = null;
        description = ''
          Debug and development options.

          These options are primarily useful for development and troubleshooting.
        '';
      };
    };
  };
}