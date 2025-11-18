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
        kdlGenerator.generateKdlConfig cfg.settings
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

in {
  inherit generateModule;
}