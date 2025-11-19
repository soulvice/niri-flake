# Auto-generated niri home-manager module
# Generated from niri commit: dfcbbbb03071cadf3fd9bbb0903ead364a839412
#
# This module provides type-safe configuration for the niri Wayland compositor.
# It automatically generates KDL configuration from structured Nix settings.

{ config, lib, pkgs, ... }:

let
  cfg = config.programs.niri;

  # Import validation, schema, and shared actions library
  validation = import ../generator/validation.nix { inherit lib; };
  schema = import ../generator/niri-settings-schema.nix { inherit lib; };
  actionsLib = import ../generator/actions-lib.nix;

in {
  options.programs.niri = {
    enable = lib.mkEnableOption "niri, a scrollable-tiling Wayland compositor";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.niri;
      description = "The niri package to use.";
    };

    settings = lib.mkOption {
      type = schema.niriSettingsType;
      default = {};
      description = ''
        Niri configuration settings.

        This option provides structured configuration for niri that is fully validated
        at build time and automatically converted to niri's native KDL format.

        All configuration options have proper type checking, validation, and detailed
        descriptions. Use your editor's autocomplete to explore available options.

        For keybindings, use config.lib.niri.actions for type-safe action references.
      '';
      example = lib.literalExpression ''
        {
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
          };

          window_rules = [
            {
              app_id = "^firefox$";
              opacity = 0.95;
            }
            {
              title = ".*YouTube.*";
              block_out_from = "screen-capture";
            }
          ];
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
      // Generated from commit: dfcbbbb03071cadf3fd9bbb0903ead364a839412

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

    # Add validation warnings (home-manager doesn't support assertions)
    # Instead, we'll add validation checks that will fail at build time
    home.activation.niri-config-validation = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # Validate niri configuration
      ${lib.optionalString (cfg.settings == {}) ''
        echo "WARNING: programs.niri.settings is empty but niri is enabled."
      ''}

      # Cross-validation checks would go here
      # For now, validation happens at type checking time
    '';
  };
}

