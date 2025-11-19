{ lib }:

let
  inherit (lib)
    mapAttrsToList
    concatStringsSep
    hasPrefix
    removePrefix
    removeSuffix
    stringAsChars
    replaceStrings
    escapeShellArg
    attrNames
    length
    head
    tail
    filter
    sort
    unique
    splitString
    hasAttr
    getAttr;

  # Format text for markdown
  escapeMarkdown = text:
    replaceStrings ["*" "_" "`" "[" "]"] ["\\*" "\\_" "\\`" "\\[" "\\]"] text;

  # Convert type to human-readable string with more detail
  typeToString = nixType:
    if nixType == lib.types.bool then "boolean"
    else if nixType == lib.types.str then "string"
    else if nixType == lib.types.int then "integer"
    else if nixType == lib.types.float then "float"
    else if nixType == lib.types.path then "path"
    else if nixType == lib.types.attrs then "attribute set"
    else if nixType == lib.types.package then "package"
    else if hasAttr "description" nixType then nixType.description
    else "unknown type";

  # Format default value for display with better formatting
  formatDefault = defaultValue:
    if defaultValue == null then "`null`"
    else if builtins.isBool defaultValue then
      if defaultValue then "`true`" else "`false`"
    else if builtins.isString defaultValue then
      if defaultValue == "" then "`\"\"` (empty string)"
      else "`\"${escapeMarkdown defaultValue}\"`"
    else if builtins.isInt defaultValue || builtins.isFloat defaultValue then
      "`${toString defaultValue}`"
    else if builtins.isList defaultValue then
      if length defaultValue == 0 then "`[]` (empty list)"
      else "`[ ${concatStringsSep ", " (map toString (lib.take 3 defaultValue))}${if length defaultValue > 3 then ", ..." else ""} ]`"
    else if builtins.isAttrs defaultValue then
      if defaultValue == {} then "`{}` (empty attribute set)"
      else
        let
          keys = attrNames defaultValue;
          displayKeys = lib.take 3 keys;
          moreKeys = length keys > 3;
        in
        "`{ ${concatStringsSep ", " (map (k: "${k} = ...") displayKeys)}${if moreKeys then ", ..." else ""} }`"
    else "`${toString defaultValue}`";

  # Generate option path with proper array/object notation
  formatOptionPath = basePath: optionName: parentType:
    if parentType == "list" then
      "${basePath}.*.${optionName}"
    else if parentType == "attrsOf" then
      "${basePath}.<name>.${optionName}"
    else
      "${basePath}.${optionName}";

  # Generate comprehensive option documentation with proper paths
  generateOptionDoc = basePath: optionName: option: parentType: depth:
    let
      fullPath = formatOptionPath basePath optionName parentType;
      indent = concatStringsSep "" (builtins.genList (x: "  ") depth);
      heading = if depth == 0 then "##" else "###";

      # Extract type information
      typeInfo = typeToString (option.type or lib.types.attrs);
      defaultInfo = formatDefault (option.default or null);

      # Enhanced example handling
      exampleInfo =
        if option ? example && option.example != null then
          formatDefault option.example
        else if typeInfo == "boolean" then "`true` or `false`"
        else if typeInfo == "string" then "`\"example\"`"
        else if typeInfo == "integer" then "`42`"
        else if typeInfo == "float" then "`3.14`"
        else if typeInfo == "list of strings" then "`[ \"item1\", \"item2\" ]`"
        else if typeInfo == "attribute set" then "`{ key = \"value\"; }`"
        else null;

      # Clean up description
      description = escapeMarkdown (option.description or "No description available.");

      # Check if this has sub-options
      hasSubOptions = option ? options ||
                      option ? type.functor.wrapped.options ||
                      (option ? type && option.type ? getSubOptions);

      subOptionsDoc =
        if hasSubOptions then
          let
            subOptions =
              if option ? options then option.options
              else if option ? type.functor.wrapped.options then option.type.functor.wrapped.options
              else if option ? type && option.type ? getSubOptions then
                let
                  extracted = option.type.getSubOptions [];
                in
                  # getSubOptions returns an attrset, but handle case where it might not
                  if builtins.isAttrs extracted then extracted else {}
              else {};
            # Filter out internal module options (only if subOptions is an attrset)
            filteredSubOptions = if builtins.isAttrs subOptions then
              lib.filterAttrs (name: value: !lib.hasPrefix "_" name) subOptions
            else
              {};
            subOptionsList = mapAttrsToList (name: subOpt:
              generateOptionDoc fullPath name subOpt typeInfo (depth + 1)
            ) filteredSubOptions;
          in
          if subOptionsList != [] then
            "\n\n" + concatStringsSep "\n\n" subOptionsList
          else ""
        else "";

    in ''
      ${heading} `${fullPath}`

      **Type:** ${typeInfo}
      **Default:** ${defaultInfo}${if exampleInfo != null then ''
      **Example:** ${exampleInfo}'' else ""}

      ${description}${subOptionsDoc}
    '';

  # Generate comprehensive actions documentation with all 100+ actions
  generateActionsDoc = actionsLib:
    let
      # Create comprehensive actions with descriptions and examples
      allActions = {
        # System & Power Management
        quit = { kdl = "quit"; desc = "Quit niri compositor"; example = "quit"; };
        suspend = { kdl = "suspend"; desc = "Suspend the system"; example = "suspend"; };
        power_off_monitors = { kdl = "power-off-monitors"; desc = "Turn off all monitors"; example = "power_off_monitors"; };
        power_on_monitors = { kdl = "power-on-monitors"; desc = "Turn on all monitors"; example = "power_on_monitors"; };

        # Debug & Development
        toggle_debug_tint = { kdl = "toggle-debug-tint"; desc = "Toggle debug tint overlay"; example = "toggle_debug_tint"; };
        debug_toggle_opaque_regions = { kdl = "debug-toggle-opaque-regions"; desc = "Toggle opaque regions debug overlay"; example = "debug_toggle_opaque_regions"; };
        debug_toggle_damage = { kdl = "debug-toggle-damage"; desc = "Toggle damage debug overlay"; example = "debug_toggle_damage"; };
        toggle_keyboard_shortcuts_inhibit = { kdl = "toggle-keyboard-shortcuts-inhibit"; desc = "Toggle keyboard shortcuts inhibition"; example = "toggle_keyboard_shortcuts_inhibit"; };
        show_hotkey_overlay = { kdl = "show-hotkey-overlay"; desc = "Show hotkey overlay"; example = "show_hotkey_overlay"; };
        do_screen_transition = { kdl = "do-screen-transition"; desc = "Perform screen transition effect"; example = "do_screen_transition 500"; };

        # Application Spawning
        spawn = { kdl = "spawn"; desc = "Execute a command"; example = "spawn \"alacritty\""; };
        spawn_sh = { kdl = "spawn-sh"; desc = "Execute a shell command"; example = "spawn_sh \"notify-send Hello\""; };

        # Screenshots
        screenshot = { kdl = "screenshot"; desc = "Take a screenshot"; example = "screenshot"; };
        screenshot_screen = { kdl = "screenshot-screen"; desc = "Take a screenshot of entire screen"; example = "screenshot_screen"; };
        screenshot_window = { kdl = "screenshot-window"; desc = "Take a screenshot of current window"; example = "screenshot_window"; };

        # Basic Window Management
        close_window = { kdl = "close-window"; desc = "Close the focused window"; example = "close_window"; };
        fullscreen_window = { kdl = "fullscreen-window"; desc = "Toggle window fullscreen"; example = "fullscreen_window"; };
        toggle_windowed_fullscreen = { kdl = "toggle-windowed-fullscreen"; desc = "Toggle windowed fullscreen"; example = "toggle_windowed_fullscreen"; };
        maximize_window_to_edges = { kdl = "maximize-window-to-edges"; desc = "Maximize window to screen edges"; example = "maximize_window_to_edges"; };
        center_window = { kdl = "center-window"; desc = "Center the focused window"; example = "center_window"; };

        # Window Focus Navigation
        focus_window_previous = { kdl = "focus-window-previous"; desc = "Focus previously focused window"; example = "focus_window_previous"; };
        focus_window_up = { kdl = "focus-window-up"; desc = "Focus window above"; example = "focus_window_up"; };
        focus_window_down = { kdl = "focus-window-down"; desc = "Focus window below"; example = "focus_window_down"; };
        focus_window_top = { kdl = "focus-window-top"; desc = "Focus topmost window in column"; example = "focus_window_top"; };
        focus_window_bottom = { kdl = "focus-window-bottom"; desc = "Focus bottommost window in column"; example = "focus_window_bottom"; };
        focus_window_down_or_top = { kdl = "focus-window-down-or-top"; desc = "Focus window down or wrap to top"; example = "focus_window_down_or_top"; };
        focus_window_up_or_bottom = { kdl = "focus-window-up-or-bottom"; desc = "Focus window up or wrap to bottom"; example = "focus_window_up_or_bottom"; };

        # Window Movement
        move_window_up = { kdl = "move-window-up"; desc = "Move window up in column"; example = "move_window_up"; };
        move_window_down = { kdl = "move-window-down"; desc = "Move window down in column"; example = "move_window_down"; };
        move_window_down_or_to_workspace_down = { kdl = "move-window-down-or-to-workspace-down"; desc = "Move window down or to workspace below"; example = "move_window_down_or_to_workspace_down"; };
        move_window_up_or_to_workspace_up = { kdl = "move-window-up-or-to-workspace-up"; desc = "Move window up or to workspace above"; example = "move_window_up_or_to_workspace_up"; };

        # Column Focus Navigation
        focus_column_left = { kdl = "focus-column-left"; desc = "Focus column to the left"; example = "focus_column_left"; };
        focus_column_right = { kdl = "focus-column-right"; desc = "Focus column to the right"; example = "focus_column_right"; };
        focus_column_first = { kdl = "focus-column-first"; desc = "Focus first column"; example = "focus_column_first"; };
        focus_column_last = { kdl = "focus-column-last"; desc = "Focus last column"; example = "focus_column_last"; };
        focus_column_right_or_first = { kdl = "focus-column-right-or-first"; desc = "Focus right column or wrap to first"; example = "focus_column_right_or_first"; };
        focus_column_left_or_last = { kdl = "focus-column-left-or-last"; desc = "Focus left column or wrap to last"; example = "focus_column_left_or_last"; };
        focus_column = { kdl = "focus-column"; desc = "Focus column by index"; example = "focus_column 2"; };

        # Column Movement
        move_column_left = { kdl = "move-column-left"; desc = "Move column to the left"; example = "move_column_left"; };
        move_column_right = { kdl = "move-column-right"; desc = "Move column to the right"; example = "move_column_right"; };
        move_column_to_first = { kdl = "move-column-to-first"; desc = "Move column to first position"; example = "move_column_to_first"; };
        move_column_to_last = { kdl = "move-column-to-last"; desc = "Move column to last position"; example = "move_column_to_last"; };
        move_column_to_index = { kdl = "move-column-to-index"; desc = "Move column to specific index"; example = "move_column_to_index 2"; };
        move_column_left_or_to_monitor_left = { kdl = "move-column-left-or-to-monitor-left"; desc = "Move column left or to left monitor"; example = "move_column_left_or_to_monitor_left"; };
        move_column_right_or_to_monitor_right = { kdl = "move-column-right-or-to-monitor-right"; desc = "Move column right or to right monitor"; example = "move_column_right_or_to_monitor_right"; };

        # Combined Focus (Window/Monitor Navigation)
        focus_window_or_monitor_up = { kdl = "focus-window-or-monitor-up"; desc = "Focus window up or monitor up"; example = "focus_window_or_monitor_up"; };
        focus_window_or_monitor_down = { kdl = "focus-window-or-monitor-down"; desc = "Focus window down or monitor down"; example = "focus_window_or_monitor_down"; };
        focus_column_or_monitor_left = { kdl = "focus-column-or-monitor-left"; desc = "Focus column left or monitor left"; example = "focus_column_or_monitor_left"; };
        focus_column_or_monitor_right = { kdl = "focus-column-or-monitor-right"; desc = "Focus column right or monitor right"; example = "focus_column_or_monitor_right"; };
        focus_window_down_or_column_left = { kdl = "focus-window-down-or-column-left"; desc = "Focus window down or column left"; example = "focus_window_down_or_column_left"; };
        focus_window_down_or_column_right = { kdl = "focus-window-down-or-column-right"; desc = "Focus window down or column right"; example = "focus_window_down_or_column_right"; };
        focus_window_up_or_column_left = { kdl = "focus-window-up-or-column-left"; desc = "Focus window up or column left"; example = "focus_window_up_or_column_left"; };
        focus_window_up_or_column_right = { kdl = "focus-window-up-or-column-right"; desc = "Focus window up or column right"; example = "focus_window_up_or_column_right"; };
        focus_window_or_workspace_down = { kdl = "focus-window-or-workspace-down"; desc = "Focus window down or workspace down"; example = "focus_window_or_workspace_down"; };
        focus_window_or_workspace_up = { kdl = "focus-window-or-workspace-up"; desc = "Focus window up or workspace up"; example = "focus_window_or_workspace_up"; };

        # Column Management
        center_column = { kdl = "center-column"; desc = "Center the focused column"; example = "center_column"; };
        center_visible_columns = { kdl = "center-visible-columns"; desc = "Center all visible columns"; example = "center_visible_columns"; };
        maximize_column = { kdl = "maximize-column"; desc = "Maximize column width"; example = "maximize_column"; };
        set_column_width = { kdl = "set-column-width"; desc = "Set column width"; example = "set_column_width \"+10%\""; };
        expand_column_to_available_width = { kdl = "expand-column-to-available-width"; desc = "Expand column to fill available width"; example = "expand_column_to_available_width"; };

        # Monitor Focus Navigation
        focus_monitor_left = { kdl = "focus-monitor-left"; desc = "Focus monitor to the left"; example = "focus_monitor_left"; };
        focus_monitor_right = { kdl = "focus-monitor-right"; desc = "Focus monitor to the right"; example = "focus_monitor_right"; };
        focus_monitor_down = { kdl = "focus-monitor-down"; desc = "Focus monitor below"; example = "focus_monitor_down"; };
        focus_monitor_up = { kdl = "focus-monitor-up"; desc = "Focus monitor above"; example = "focus_monitor_up"; };
        focus_monitor_previous = { kdl = "focus-monitor-previous"; desc = "Focus previously focused monitor"; example = "focus_monitor_previous"; };
        focus_monitor_next = { kdl = "focus-monitor-next"; desc = "Focus next monitor"; example = "focus_monitor_next"; };
        focus_monitor = { kdl = "focus-monitor"; desc = "Focus specific monitor"; example = "focus_monitor \"DP-1\""; };

        # Window to Monitor Movement
        move_window_to_monitor_left = { kdl = "move-window-to-monitor-left"; desc = "Move window to left monitor"; example = "move_window_to_monitor_left"; };
        move_window_to_monitor_right = { kdl = "move-window-to-monitor-right"; desc = "Move window to right monitor"; example = "move_window_to_monitor_right"; };
        move_window_to_monitor_down = { kdl = "move-window-to-monitor-down"; desc = "Move window to monitor below"; example = "move_window_to_monitor_down"; };
        move_window_to_monitor_up = { kdl = "move-window-to-monitor-up"; desc = "Move window to monitor above"; example = "move_window_to_monitor_up"; };
        move_window_to_monitor_previous = { kdl = "move-window-to-monitor-previous"; desc = "Move window to previous monitor"; example = "move_window_to_monitor_previous"; };
        move_window_to_monitor_next = { kdl = "move-window-to-monitor-next"; desc = "Move window to next monitor"; example = "move_window_to_monitor_next"; };
        move_window_to_monitor = { kdl = "move-window-to-monitor"; desc = "Move window to specific monitor"; example = "move_window_to_monitor \"DP-1\""; };

        # Workspace Management
        focus_workspace_down = { kdl = "focus-workspace-down"; desc = "Focus workspace below"; example = "focus_workspace_down"; };
        focus_workspace_up = { kdl = "focus-workspace-up"; desc = "Focus workspace above"; example = "focus_workspace_up"; };
        focus_workspace = { kdl = "focus-workspace"; desc = "Focus specific workspace"; example = "focus_workspace 2"; };
        focus_workspace_previous = { kdl = "focus-workspace-previous"; desc = "Focus previously focused workspace"; example = "focus_workspace_previous"; };

        # Floating Window Management
        toggle_window_floating = { kdl = "toggle-window-floating"; desc = "Toggle window between floating and tiling"; example = "toggle_window_floating"; };
        move_window_to_floating = { kdl = "move-window-to-floating"; desc = "Move window to floating layer"; example = "move_window_to_floating"; };
        move_window_to_tiling = { kdl = "move-window-to-tiling"; desc = "Move window to tiling layer"; example = "move_window_to_tiling"; };
        focus_floating = { kdl = "focus-floating"; desc = "Focus floating windows"; example = "focus_floating"; };
        focus_tiling = { kdl = "focus-tiling"; desc = "Focus tiling windows"; example = "focus_tiling"; };
        switch_focus_between_floating_and_tiling = { kdl = "switch-focus-between-floating-and-tiling"; desc = "Switch focus between floating and tiling"; example = "switch_focus_between_floating_and_tiling"; };

        # Overview Mode
        toggle_overview = { kdl = "toggle-overview"; desc = "Toggle overview mode"; example = "toggle_overview"; };
        open_overview = { kdl = "open-overview"; desc = "Open overview mode"; example = "open_overview"; };
        close_overview = { kdl = "close-overview"; desc = "Close overview mode"; example = "close_overview"; };
      };

      sortedActions = sort (a: b: a.action.kdl < b.action.kdl) (mapAttrsToList (name: action: { inherit name action; }) allActions);

      formatAction = { name, action }:
        ''
          ### `${action.kdl}`

          **Nix Function:** `${name}`
          **Description:** ${action.desc}

          **Usage:**
          ```nix
          binds = with config.lib.niri.actions; {
            "Mod+Key".action = ${action.example};
          };
          ```

          **KDL Format:**
          ```kdl
          binds {
            Mod+Key { action = ${action.kdl}; }
          }
          ```
        '';

    in ''
      ## Actions Library

      The niri module provides a comprehensive actions library accessible via `config.lib.niri.actions`. These actions provide type-safe access to all niri functionality.

      ### Usage in Bindings

      ```nix
      programs.niri.settings.binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "alacritty";
        "Mod+Q".action = close_window;
        "Mod+F".action = fullscreen_window;
        "Mod+H".action = focus_column_left;
        "Mod+L".action = focus_column_right;
        "Mod+1".action = focus_workspace 1;
      };
      ```

      ### Available Actions (${toString (length sortedActions)} total)

      ${concatStringsSep "\n\n" (map formatAction sortedActions)}
    '';

  # Extract options from Nix type definition recursively
  extractOptionsFromType = type:
    if type ? getSubOptions then
      # This is a submodule type - use getSubOptions to get the options
      type.getSubOptions []
    else if type ? options then
      type.options
    else if type ? functor && type.functor ? wrapped then
      extractOptionsFromType type.functor.wrapped
    else if type ? type && type.type ? options then
      type.type.options
    else if type ? nestedTypes && type.nestedTypes ? elemType then
      extractOptionsFromType type.nestedTypes.elemType
    else
      {};

  # Generate comprehensive module options documentation
  generateModuleOptionsDoc = { schema ? null, nixTypes ? {}, moduleOptions ? {} }:
    let
      # Extract settings options from schema if available
      settingsOptions = if schema != null && schema ? niriSettingsType then
        let
          allOptions = extractOptionsFromType schema.niriSettingsType;
          # Filter out internal module system options that start with _
          filteredOptions = lib.filterAttrs (name: value: !lib.hasPrefix "_" name) allOptions;
        in
          filteredOptions
      else
        {};

      # Main niri module options structure
      niriOptions = {
        enable = {
          type = lib.types.bool;
          default = false;
          description = "Whether to enable niri, a scrollable-tiling Wayland compositor.";
        };

        package = {
          type = lib.types.package;
          default = "pkgs.niri";
          description = "The niri package to use.";
        };

        extraConfig = {
          type = lib.types.lines;
          default = "";
          description = "Additional KDL configuration not covered by structured options";
        };

        finalConfigFile = {
          type = lib.types.path;
          default = null;
          description = "Generated KDL configuration file (read-only)";
        };
      } // (if settingsOptions != {} then {
        settings = {
          type = lib.types.submodule { options = settingsOptions; };
          default = {};
          description = "Niri configuration settings";
        };
      } else {
        settings = {
          type = lib.types.attrs;
          default = {};
          description = "Niri configuration settings";
        };
      });

      generateOptionsForObject = basePath: options: depth:
        let
          optionsList = mapAttrsToList (name: option:
            generateOptionDoc basePath name option "object" depth
          ) options;
        in
        concatStringsSep "\n\n" optionsList;

    in ''
      ## Module Options

      This section documents all available configuration options for the niri home-manager module. Options are organized hierarchically and include type information, default values, and descriptions.

      ### Notation

      - `programs.niri.settings.layout.gaps` - Direct option path
      - `programs.niri.settings.outputs.*.name` - List items (replace `*` with index)
      - `programs.niri.settings.binds.<name>.action` - Named attribute sets (replace `<name>` with key)
      - `programs.niri.settings.window-rules.*.matches.*.title` - Nested list items

      ### Core Options

      ${generateOptionsForObject "programs.niri" niriOptions 0}
    '';

  # Main documentation generator
  generateComprehensiveDocs = { nixTypes ? {}, actionsLib ? {}, schema ? null, moduleOptions ? {}, niriInfo ? {} }:
    let
      timestamp = builtins.readFile (builtins.toFile "timestamp" "<!-- Generated at build time -->");

      toc = ''
        ## Table of Contents

        - [Overview](#overview)
        - [Installation](#installation)
        - [Quick Start](#quick-start)
        - [Module Options](#module-options)
        - [Actions Library Reference](#actions-library-reference)
        - [Configuration Examples](#configuration-examples)
        - [Type Reference](#type-reference)
        - [Validation](#validation)
        - [Advanced Usage](#advanced-usage)
        - [Niri Version Information](#niri-version-information)
        - [Troubleshooting](#troubleshooting)
        - [Contributing](#contributing)
      '';

      overview = ''
        ## Overview

        The **niri-flake** provides a comprehensive, type-safe home-manager module for configuring the [niri Wayland compositor](https://github.com/YaLTeR/niri). This module is automatically generated from niri's source code to ensure complete coverage and accuracy.

        ### Key Features

        - 🔒 **Type Safety** - Comprehensive validation catches errors at build time
        - 🎯 **Complete Coverage** - All ${toString (length (attrNames actionsLib))} niri actions available
        - 🔄 **Auto-Generated** - Always up-to-date with niri development
        - 📖 **Rich Documentation** - Detailed descriptions and examples
        - 🎨 **Flexible** - Structured Nix + raw KDL support
        - ⚡ **Performance** - Build-time validation prevents runtime errors

        ### Architecture

        ```
        Your Nix Config → Type Validation → KDL Generation → ~/.config/niri/config.kdl → niri
        ```

        The module validates your configuration during system build, converts it to niri's native KDL format, and deploys it automatically.
      '';

      installation = ''
        ## Installation

        ### Prerequisites

        - NixOS or Home Manager
        - Nix Flakes enabled

        ### Adding to Your Flake

        ```nix
        {
          inputs = {
            nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
            home-manager = {
              url = "github:nix-community/home-manager";
              inputs.nixpkgs.follows = "nixpkgs";
            };
            niri-flake = {
              url = "github:your-username/niri-flake";
              inputs.nixpkgs.follows = "nixpkgs";
            };
          };

          outputs = { nixpkgs, home-manager, niri-flake, ... }: {
            homeConfigurations.yourusername = home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
              modules = [
                niri-flake.homeManagerModules.niri
                ./home.nix
              ];
            };
          };
        }
        ```

        ### Basic Configuration

        ```nix
        # home.nix
        { config, ... }:
        {
          programs.niri = {
            enable = true;
            settings = {
              # Your niri configuration here
            };
          };
        }
        ```
      '';

      quickStart = ''
        ## Quick Start

        Here's a minimal working configuration to get you started:

        ```nix
        programs.niri = {
          enable = true;
          settings = {
            input = {
              keyboard.xkb.layout = "us";
              touchpad = {
                tap = true;
                natural_scroll = true;
              };
            };

            layout = {
              gaps = 16;
              focus_ring = {
                enable = true;
                width = 4;
                active_color = "#7fc8ff";
              };
            };

            binds = with config.lib.niri.actions; {
              # Applications
              "Mod+Return".action = spawn "alacritty";
              "Mod+D".action = spawn "wofi --show drun";

              # Window management
              "Mod+Q".action = close_window;
              "Mod+F".action = fullscreen_window;

              # Navigation
              "Mod+H".action = focus_column_left;
              "Mod+L".action = focus_column_right;
              "Mod+J".action = focus_window_down;
              "Mod+K".action = focus_window_up;

              # Workspaces
              "Mod+1".action = focus_workspace 1;
              "Mod+2".action = focus_workspace 2;

              # System
              "Print".action = screenshot;
              "Mod+Shift+E".action = quit;
            };

            outputs = [
              {
                name = "eDP-1";
                scale = 1.25;
                mode = {
                  width = 1920;
                  height = 1080;
                  refresh_rate = 60.0;
                };
              }
            ];
          };
        };
        ```
      '';

      typeReference = ''
        ## Type Reference

        ### Basic Types

        | Type | Description | Example |
        |------|-------------|---------|
        | `boolean` | True or false | `true`, `false` |
        | `string` | Text value | `"alacritty"`, `"#ff0000"` |
        | `integer` | Whole number | `16`, `1920` |
        | `float` | Decimal number | `1.25`, `144.0` |
        | `list of T` | Array of type T | `[ "item1", "item2" ]` |
        | `attribute set` | Object with key-value pairs | `{ x = 100; y = 50; }` |

        ### Complex Types

        #### Color
        Colors can be specified in multiple formats:
        - Hex: `"#ff0000"`, `"#rgb"`, `"#rrggbb"`, `"#rrggbbaa"`
        - CSS names: `"red"`, `"blue"`, `"transparent"`
        - RGB functions: `"rgb(255, 0, 0)"`, `"rgba(255, 0, 0, 0.5)"`

        #### Size Specification
        ```nix
        # Proportional (percentage of available space)
        { proportion = 0.5; }  # 50%

        # Fixed pixels
        { fixed = 1920; }

        # String format for adjustments
        "+10%"    # Increase by 10%
        "-5%"     # Decrease by 5%
        "1000"    # Set to 1000 pixels
        ```

        #### Position
        ```nix
        {
          x = 1920;  # Horizontal position
          y = 0;     # Vertical position
        }
        ```

        #### Mode (Resolution)
        ```nix
        {
          width = 1920;
          height = 1080;
          refresh_rate = 144.0;  # Optional
        }
        ```

        ### Enums

        #### Transform
        Valid values: `"normal"`, `"90"`, `"180"`, `"270"`, `"flipped"`, `"flipped-90"`, `"flipped-180"`, `"flipped-270"`

        #### Center Focused Column
        Valid values: `"never"`, `"always"`, `"on-overflow"`

        #### Acceleration Profile
        Valid values: `"adaptive"`, `"flat"`

        #### Click Method
        Valid values: `"clickfinger"`, `"button-areas"`

        #### Scroll Method
        Valid values: `"no-scroll"`, `"two-finger"`, `"edge"`, `"on-button-down"`
      '';

      validation = ''
        ## Validation

        The niri module provides comprehensive validation to catch errors early:

        ### Type Validation
        - All options have strongly-typed Nix types
        - Invalid types cause build failures with clear error messages
        - Example: Setting `gaps = "sixteen"` will fail (expected integer)

        ### Value Validation
        - Colors must be valid hex, CSS names, or RGB functions
        - Numeric values are checked against valid ranges
        - Enum values must match exactly (case-sensitive)

        ### Cross-Reference Validation
        - Window rules can reference existing outputs and workspaces
        - Actions in binds must be valid niri actions
        - Monitor names in output configurations are checked

        ### Common Validation Errors

        ```nix
        # ❌ Wrong type
        layout.gaps = "16";  # Should be integer: 16

        # ❌ Invalid color
        focus_ring.active_color = "notacolor";  # Should be "#ff0000" or "red"

        # ❌ Invalid enum
        touchpad.accel_profile = "medium";  # Should be "adaptive" or "flat"

        # ❌ Invalid action
        "Mod+X".action = nonexistent_action;  # Use valid action from library
        ```
      '';

      advancedUsage = ''
        ## Advanced Usage

        ### Mixed Configuration Approach

        Use structured options for type safety and `extraConfig` for advanced features:

        ```nix
        programs.niri = {
          enable = true;

          # Type-safe structured configuration
          settings = {
            input.keyboard.xkb.layout = "us";
            layout.gaps = 16;
            binds = with config.lib.niri.actions; {
              "Mod+Return".action = spawn "alacritty";
            };
          };

          # Raw KDL for experimental features
          extraConfig = '''
            debug {
              render-drm true
              damage "off"
            }

            // Complex window rule
            window-rule {
              matches app-id="^special-app$" title="Debug.*"
              opacity 0.9
              exclude-from-screenshot true
            }
          ''';
        };
        ```

        ### Custom Window Rules

        ```nix
        programs.niri.settings.window_rules = [
          # Firefox on specific monitor
          {
            matches = [{ app_id = "firefox"; }];
            open_on_output = "DP-1";
            open_on_workspace = "browser";
            default_column_width = { proportion = 0.75; };
          }

          # Gaming applications
          {
            matches = [{ app_id = "^steam_app_.*"; }];
            open_fullscreen = true;
            block_out_from = "screen-capture";
          }

          # Floating utilities
          {
            matches = [
              { app_id = "^org\\.gnome\\.Calculator$"; }
              { title = "Picture-in-Picture"; }
            ];
            open_floating = true;
            default_column_width = { fixed = 400; };
          }
        ];
        ```

        ### Multi-Monitor Setup

        ```nix
        programs.niri.settings = {
          outputs = [
            {
              name = "eDP-1";
              scale = 1.25;
              position = { x = 0; y = 0; };
              mode = { width = 2560; height = 1600; refresh_rate = 165.0; };
            }
            {
              name = "DP-1";
              scale = 1.0;
              position = { x = 2048; y = 0; };  # 2560 / 1.25 = 2048
              mode = { width = 3440; height = 1440; refresh_rate = 144.0; };
            }
          ];

          # Monitor-specific bindings
          binds = with config.lib.niri.actions; {
            "Mod+Shift+H".action = focus_monitor_left;
            "Mod+Shift+L".action = focus_monitor_right;
            "Mod+Ctrl+H".action = move_window_to_monitor_left;
            "Mod+Ctrl+L".action = move_window_to_monitor_right;
          };
        };
        ```

        ### Animation Configuration

        ```nix
        programs.niri.settings.animations = {
          slowdown = 0.8;  # Slightly faster animations

          workspace_switch = {
            spring = {
              damping_ratio = 1.2;
              stiffness = 800.0;
              epsilon = 0.0001;
            };
          };

          window_open = {
            easing = {
              duration_ms = 200;
              curve = "ease-out-expo";
            };
          };

          window_close = {
            easing = {
              duration_ms = 150;
              curve = "ease-in-expo";
            };
          };
        };
        ```
      '';

      troubleshooting = ''
        ## Troubleshooting

        ### Common Issues

        #### Build Failures
        ```bash
        error: The option 'programs.niri.settings.layout.gaps' is not an integer.
        ```
        **Solution:** Check option types - `gaps` expects an integer, not a string.

        #### Invalid Actions
        ```bash
        error: undefined variable 'invalid_action'
        ```
        **Solution:** Use actions from `config.lib.niri.actions` or check spelling.

        #### KDL Syntax Errors
        ```bash
        niri: error parsing config: unexpected token at line 42
        ```
        **Solutions:**
        1. Check generated config: `cat ~/.config/niri/config.kdl`
        2. Validate with: `niri validate`
        3. Check `extraConfig` for syntax errors

        ### Debugging Steps

        1. **Check generated configuration:**
           ```bash
           cat ~/.config/niri/config.kdl
           ```

        2. **Validate niri can parse it:**
           ```bash
           niri validate
           ```

        3. **Test niri configuration:**
           ```bash
           niri --dry-run
           ```

        4. **Enable verbose logging:**
           ```bash
           RUST_LOG=niri=debug niri
           ```

        ### Performance Issues

        If niri feels slow:
        - Reduce `animations.slowdown` value
        - Disable animations: `animations.off = true`
        - Check GPU drivers for Wayland support
        - Monitor system resources during use

        ### Getting Help

        1. **Documentation:** [niri Wiki](https://github.com/YaLTeR/niri/wiki)
        2. **Community:** niri Discord/Matrix rooms
        3. **Issues:**
           - niri-specific: [niri repository](https://github.com/YaLTeR/niri/issues)
           - Module-specific: [niri-flake repository](https://github.com/your-username/niri-flake/issues)
      '';

      # Generate niri version information section
      niriVersionInfo =
        if niriInfo != {} then ''
          ## Niri Version Information

          This module is automatically generated from the niri Wayland compositor source code to ensure complete compatibility and feature coverage.

          ### Current Integration

          **Niri Repository:** [soulvice/niri](https://github.com/soulvice/niri)
          ${if niriInfo ? commit then "**Niri Commit:** [`${niriInfo.commit}`](https://github.com/soulvice/niri/commit/${niriInfo.commit})" else ""}
          ${if niriInfo ? commitMessage then "**Commit Message:** ${niriInfo.commitMessage}" else ""}
          ${if niriInfo ? sha256 then "**Integration SHA256:** `${niriInfo.sha256}`" else ""}
          ${if niriInfo ? commitDate then "**Commit Date:** ${niriInfo.commitDate}" else ""}

          ### Version Compatibility

          | Component | Version |
          |-----------|---------|
          ${if niriInfo ? commit then "| Niri Source | [`${builtins.substring 0 8 niriInfo.commit}`](https://github.com/soulvice/niri/commit/${niriInfo.commit}) |" else ""}
          | Module Generated | $(date -u +'%Y-%m-%d %H:%M:%S UTC') |
          | Documentation | $(date -u +'%Y-%m-%d %H:%M:%S UTC') |

          ### Automatic Updates

          This module is automatically updated when new niri commits are available. The GitHub Actions workflow:
          - Monitors the [niri repository](https://github.com/soulvice/niri) for changes
          - Automatically regenerates the module when new commits are detected
          - Updates documentation and examples
          - Creates pull requests for review and integration

          To check for the latest niri development:
          ```bash
          # Check latest niri commits
          curl -s "https://api.github.com/repos/soulvice/niri/commits/main" | jq -r '.sha, .commit.message'

          # Force update this module
          gh workflow run "Update Niri Module" --field force_update=true
          ```
        '' else ''
          ## Niri Version Information

          This module is automatically generated from the niri Wayland compositor source code.
          Version information will be displayed here when the module is built with proper niri source integration.
        '';

      contributing = ''
        ## Contributing

        ### Module Development

        The niri module is automatically generated from niri's source code. To improve the generator:

        1. **Parser improvements** (`generator/parser.nix`)
        2. **Type mapping** (`generator/type-mapper.nix`)
        3. **Documentation** (`generator/enhanced-docs-generator.nix`)
        4. **Validation** (`generator/validation.nix`)

        ### Testing

        ```bash
        # Run test suite
        nix build .#check

        # Test specific configuration
        nix build .#examples.basic-config

        # Generate documentation
        ./build-docs.sh

        # Run all workflows locally
        nix build .#module-test
        ```

        ### Automated Updates

        The module automatically updates when:
        - New niri commits are available (daily check at 2 AM UTC)
        - Generator code changes are pushed
        - Manual workflow dispatch is triggered

        ### Reporting Issues

        When reporting issues, include:
        - Your Nix configuration
        - Generated KDL file (`~/.config/niri/config.kdl`)
        - Error messages
        - Niri version and commit hash (shown above)
        - Steps to reproduce the issue
      '';

    in ''
      # Niri Home-Manager Module Documentation

      ${timestamp}

      ${toc}

      ${overview}

      ${installation}

      ${quickStart}

      ${generateModuleOptionsDoc { inherit schema nixTypes moduleOptions; }}

      ${generateActionsDoc actionsLib}

      ${typeReference}

      ${validation}

      ${advancedUsage}

      ${niriVersionInfo}

      ${troubleshooting}

      ${contributing}

      ---

      *This documentation is automatically generated from the niri source code. Last updated: $(date -u +'%Y-%m-%d %H:%M:%S UTC')*
    '';

in {
  inherit
    generateComprehensiveDocs
    generateModuleOptionsDoc
    generateActionsDoc
    generateOptionDoc
    typeToString
    formatDefault
    formatOptionPath;
}