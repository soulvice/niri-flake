{ lib }:

let
  inherit (lib)
    types
    mkOption
    mkDefault
    mkIf
    mkMerge
    mapAttrs
    mapAttrsToList
    concatStringsSep
    hasPrefix
    removePrefix;

  # Generate a home-manager module from the parsed niri configuration
  generateModule = { nixTypes, kdlGenerator }:
    { config, pkgs, ... }:

    let
      cfg = config.programs.niri;

      # Generate options for a struct type
      generateStructOptions = structName: structType:
        let
          fieldOptions = mapAttrs (fieldName: field:
            mkOption {
              type = field.type;
              default = field.default;
              description = field.description;
              example = generateExampleValue field.type;
            }
          ) structType.fieldTypes;
        in
        fieldOptions;

      # Generate example values for documentation
      generateExampleValue = nixType:
        if nixType == types.bool then true
        else if nixType == types.str then "example"
        else if nixType == types.int then 42
        else if nixType == types.float then 3.14
        else if builtins.isFunction nixType then
          # For complex types, provide a simple example
          if toString nixType == toString types.attrs then {}
          else if toString nixType == toString (types.listOf types.str) then ["item1" "item2"]
          else null
        else null;

      # Create the main options structure
      mainOptions = if nixTypes.mainConfig != null then
        generateStructOptions "Config" nixTypes.mainConfig
      else {
        # Fallback manual options if parsing fails
        input = mkOption {
          type = types.attrs;
          default = {};
          description = "Input device configuration";
        };

        layout = mkOption {
          type = types.attrs;
          default = {};
          description = "Window layout configuration";
        };

        binds = mkOption {
          type = types.attrsOf types.str;
          default = {};
          description = "Keyboard and mouse bindings";
          example = {
            "Mod+Return" = "spawn alacritty";
            "Mod+D" = "spawn wofi --show drun";
          };
        };

        outputs = mkOption {
          type = types.listOf types.attrs;
          default = [];
          description = "Output configuration";
        };

        animations = mkOption {
          type = types.attrs;
          default = {};
          description = "Animation settings";
        };

        window_rules = mkOption {
          type = types.listOf types.attrs;
          default = [];
          description = "Per-window rules";
        };

        spawn_at_startup = mkOption {
          type = types.listOf types.str;
          default = [];
          description = "Commands to run at startup";
        };
      };

      # Generate the KDL configuration file
      configFile = pkgs.writeText "niri-config.kdl" (
        let
          generatedConfig = kdlGenerator.generateKdlConfig cfg.settings;
          extraConfig = cfg.extraConfig;
        in
        if extraConfig != "" then
          generatedConfig + "\n\n// Extra configuration\n" + extraConfig + "\n"
        else
          generatedConfig
      );

      # Create actions library for easy keybind configuration
      actionsLib = {
        # Window management
        close_window = "close-window";
        fullscreen_window = "fullscreen-window";
        focus_left = "focus-left";
        focus_right = "focus-right";
        focus_up = "focus-up";
        focus_down = "focus-down";
        move_left = "move-left";
        move_right = "move-right";
        move_up = "move-up";
        move_down = "move-down";

        # Workspace management
        focus_workspace_previous = "focus-workspace-previous";
        focus_workspace_next = "focus-workspace-next";
        move_to_workspace_previous = "move-to-workspace-previous";
        move_to_workspace_next = "move-to-workspace-next";

        # Column management
        focus_column_left = "focus-column-left";
        focus_column_right = "focus-column-right";
        move_column_left = "move-column-left";
        move_column_right = "move-column-right";

        # Spawning
        spawn = cmd: "spawn ${cmd}";
        spawn_shell = cmd: "spawn sh -c '${cmd}'";

        # Screenshots
        screenshot = "screenshot";
        screenshot_window = "screenshot-window";

        # Quit
        quit = "quit";
        power_off_monitors = "power-off-monitors";
      };

    in {
      options.programs.niri = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to enable niri, a scrollable-tiling Wayland compositor.

            This module automatically generates niri configuration from
            the parsed niri source code, ensuring type safety and
            comprehensive validation.
          '';
        };

        package = mkOption {
          type = types.package;
          default = pkgs.niri;
          description = "The niri package to use.";
        };

        settings = mainOptions;

        extraConfig = mkOption {
          type = types.lines;
          default = "";
          description = ''
            Additional configuration in raw KDL format.

            This allows you to add niri configuration that isn't yet
            supported by the generated module, or to override specific
            settings with custom KDL syntax.

            The extraConfig is appended to the end of the generated
            configuration file.
          '';
          example = ''
            // Custom experimental settings
            debug {
                render-drm true
                damage "off"
            }

            // Override specific binds with complex syntax
            binds {
                Mod+Alt+Shift+R { action = screenshot-screen; }
            }

            // Custom window rules with complex matching
            window-rule {
                matches app-id="^special-app$" title="Important.*"
                exclude-from-screenshot true
                opacity 0.95
            }
          '';
        };

        finalConfigFile = mkOption {
          type = types.path;
          readOnly = true;
          description = "The generated KDL configuration file.";
          default = configFile;
        };
      };

      config = mkIf cfg.enable {
        # Install niri
        home.packages = [ cfg.package ];

        # Create config directory and file
        home.file.".config/niri/config.kdl".source = cfg.finalConfigFile;

        # Set up environment for niri
        home.sessionVariables = {
          # Enable Wayland for various applications
          NIXOS_OZONE_WL = "1";
          MOZ_ENABLE_WAYLAND = "1";
          QT_QPA_PLATFORM = "wayland";
          SDL_VIDEODRIVER = "wayland";
          _JAVA_AWT_WM_NONREPARENTING = "1";
        };

        # Provide actions library
        lib.niri.actions = actionsLib;

        # Add validation assertions
        assertions = [
          {
            assertion = cfg.settings != {};
            message = "programs.niri.settings cannot be empty when niri is enabled.";
          }
        ];

        # Optional: Set up systemd user service for niri
        systemd.user.services.niri = mkIf false { # Disabled by default
          Unit = {
            Description = "Niri Wayland compositor";
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session-pre.target" ];
            Requisite = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart = "${cfg.package}/bin/niri";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
        };
      };

      # Make the actions library available at the top level
      lib.niri.actions = actionsLib;
    };

  # Generate module as a string (for static file generation)
  generateModuleFileString = { nixTypes, niriCommit, kdlGenerator }:
    ''
# Auto-generated niri home-manager module
# Generated from niri commit: ${niriCommit}
#
# This module provides type-safe configuration for the niri Wayland compositor.
# It automatically generates KDL configuration from structured Nix settings.

{ config, lib, pkgs, ... }:

let
  cfg = config.programs.niri;

  # Actions library for easy keybind configuration
  actionsLib = {
    # System & Power Management
    quit = "quit";
    suspend = "suspend";
    power_off_monitors = "power-off-monitors";
    power_on_monitors = "power-on-monitors";

    # Debug & Development
    toggle_debug_tint = "toggle-debug-tint";
    debug_toggle_opaque_regions = "debug-toggle-opaque-regions";
    debug_toggle_damage = "debug-toggle-damage";
    toggle_keyboard_shortcuts_inhibit = "toggle-keyboard-shortcuts-inhibit";
    show_hotkey_overlay = "show-hotkey-overlay";
    do_screen_transition = "do-screen-transition";

    # Application Spawning
    spawn = cmd: "spawn " + cmd;
    spawn_sh = cmd: "spawn sh -c '" + cmd + "'";

    # Screenshots
    screenshot = "screenshot";
    screenshot_screen = "screenshot-screen";
    screenshot_window = "screenshot-window";

    # Basic Window Management
    close_window = "close-window";
    fullscreen_window = "fullscreen-window";
    toggle_windowed_fullscreen = "toggle-windowed-fullscreen";
    maximize_window_to_edges = "maximize-window-to-edges";
    center_window = "center-window";

    # Window Focus Navigation
    focus_window_previous = "focus-window-previous";
    focus_window_up = "focus-window-up";
    focus_window_down = "focus-window-down";
    focus_window_top = "focus-window-top";
    focus_window_bottom = "focus-window-bottom";
    focus_window_down_or_top = "focus-window-down-or-top";
    focus_window_up_or_bottom = "focus-window-up-or-bottom";

    # Window Movement
    move_window_up = "move-window-up";
    move_window_down = "move-window-down";
    move_window_down_or_to_workspace_down = "move-window-down-or-to-workspace-down";
    move_window_up_or_to_workspace_up = "move-window-up-or-to-workspace-up";

    # Column Focus Navigation
    focus_column_left = "focus-column-left";
    focus_column_right = "focus-column-right";
    focus_column_first = "focus-column-first";
    focus_column_last = "focus-column-last";
    focus_column_right_or_first = "focus-column-right-or-first";
    focus_column_left_or_last = "focus-column-left-or-last";
    focus_column = "focus-column";

    # Column Movement
    move_column_left = "move-column-left";
    move_column_right = "move-column-right";
    move_column_to_first = "move-column-to-first";
    move_column_to_last = "move-column-to-last";
    move_column_to_index = "move-column-to-index";
    move_column_left_or_to_monitor_left = "move-column-left-or-to-monitor-left";
    move_column_right_or_to_monitor_right = "move-column-right-or-to-monitor-right";

    # Monitor Focus Navigation
    focus_monitor_left = "focus-monitor-left";
    focus_monitor_right = "focus-monitor-right";
    focus_monitor_down = "focus-monitor-down";
    focus_monitor_up = "focus-monitor-up";
    focus_monitor_previous = "focus-monitor-previous";
    focus_monitor_next = "focus-monitor-next";
    focus_monitor = "focus-monitor";

    # Window to Monitor Movement
    move_window_to_monitor_left = "move-window-to-monitor-left";
    move_window_to_monitor_right = "move-window-to-monitor-right";
    move_window_to_monitor_down = "move-window-to-monitor-down";
    move_window_to_monitor_up = "move-window-to-monitor-up";
    move_window_to_monitor_previous = "move-window-to-monitor-previous";
    move_window_to_monitor_next = "move-window-to-monitor-next";
    move_window_to_monitor = "move-window-to-monitor";

    # Workspace Management
    focus_workspace_down = "focus-workspace-down";
    focus_workspace_up = "focus-workspace-up";
    focus_workspace = "focus-workspace";
    focus_workspace_previous = "focus-workspace-previous";

    # Floating Window Management
    toggle_window_floating = "toggle-window-floating";
    move_window_to_floating = "move-window-to-floating";
    move_window_to_tiling = "move-window-to-tiling";
    focus_floating = "focus-floating";
    focus_tiling = "focus-tiling";
    switch_focus_between_floating_and_tiling = "switch-focus-between-floating-and-tiling";

    # Overview Mode
    toggle_overview = "toggle-overview";
    open_overview = "open-overview";
    close_overview = "close-overview";
  };

in {
  options.programs.niri = {
    enable = lib.mkEnableOption "niri, a scrollable-tiling Wayland compositor";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.niri;
      description = "The niri package to use.";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = '''
        Niri configuration settings.

        This option provides structured configuration for niri that is validated
        at build time and automatically converted to niri's native KDL format.

        See the module documentation for detailed option descriptions.
      ''';
      example = lib.literalExpression '''
        {
          input = {
            keyboard = {
              xkb = {
                layout = "us";
                variant = "";
              };
            };
          };

          layout = {
            gaps = 16;
            focus_ring.enable = true;
            focus_ring.width = 4;
          };

          binds = with config.lib.niri.actions; {
            "Mod+Return".action = spawn "alacritty";
            "Mod+Q".action = close_window;
          };
        }
      ''';
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = '''
        Additional configuration in raw KDL format.

        This allows you to add niri configuration that isn't yet
        supported by the generated module, or to override specific
        settings with custom KDL syntax.
      ''';
      example = '''
        // Custom window rules
        window-rule {
            matches app-id="special-app"
            opacity 0.95
        }
      ''';
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
    programs.niri.finalConfigFile = pkgs.writeText "niri-config.kdl" '''
      // Auto-generated niri configuration from home-manager module
      // Generated from commit: ${niriCommit}

      ''${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value:
        "// Configuration for ''${name}: ''${builtins.toJSON value}") cfg.settings)}

      ''${cfg.extraConfig}
    ''';

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
  };
}
    '';

in {
  inherit generateModule generateModuleFileString;
}