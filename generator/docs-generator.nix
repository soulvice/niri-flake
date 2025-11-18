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
    unique;

  # Format text for markdown
  escapeMarkdown = text:
    replaceStrings ["*" "_" "`" "[" "]"] ["\\*" "\\_" "\\`" "\\[" "\\]"] text;

  # Convert type to human-readable string
  typeToString = nixType:
    if nixType == lib.types.bool then "boolean"
    else if nixType == lib.types.str then "string"
    else if nixType == lib.types.int then "integer"
    else if nixType == lib.types.float then "float"
    else if nixType == lib.types.path then "path"
    else if nixType == lib.types.attrs then "attribute set"
    else if nixType == lib.types.package then "package"
    else if builtins.isFunction nixType then
      let
        typeStr = toString nixType;
      in
      if lib.hasInfix "listOf" typeStr then "list"
      else if lib.hasInfix "nullOr" typeStr then "null or value"
      else if lib.hasInfix "oneOf" typeStr then "one of multiple types"
      else if lib.hasInfix "submodule" typeStr then "submodule"
      else if lib.hasInfix "enum" typeStr then "enum"
      else if lib.hasInfix "between" typeStr then "number (with range)"
      else "complex type"
    else toString nixType;

  # Extract enum values from a type (simplified)
  extractEnumValues = nixType:
    # This is a simplified implementation - in practice, we'd need to
    # extract the actual enum values from the type definition
    [];

  # Format default value for display
  formatDefault = defaultValue:
    if defaultValue == null then "`null`"
    else if builtins.isBool defaultValue then
      if defaultValue then "`true`" else "`false`"
    else if builtins.isString defaultValue then "`\"${defaultValue}\"`"
    else if builtins.isInt defaultValue || builtins.isFloat defaultValue then
      "`${toString defaultValue}`"
    else if builtins.isList defaultValue then
      if length defaultValue == 0 then "`[]`"
      else "`[...]`"
    else if builtins.isAttrs defaultValue then
      if defaultValue == {} then "`{}`"
      else "`{...}`"
    else "`${toString defaultValue}`";

  # Generate option documentation
  generateOptionDoc = optionPath: option: depth:
    let
      indent = concatStringsSep "" (builtins.genList (x: "  ") depth);
      heading = concatStringsSep "" (builtins.genList (x: "#") (depth + 2));

      # Extract type information
      typeInfo = typeToString (option.type or lib.types.attrs);
      defaultInfo = formatDefault (option.default or null);
      exampleInfo = if option.example != null then
        formatDefault option.example
      else null;

      # Clean up description
      description = escapeMarkdown (option.description or "No description available.");

    in ''
      ${heading} `${optionPath}`

      **Type:** ${typeInfo}
      **Default:** ${defaultInfo}${if exampleInfo != null then ''
      **Example:** ${exampleInfo}'' else ""}

      ${description}

      ${if option ? options then
        let
          subOptions = mapAttrsToList (name: subOpt:
            generateOptionDoc "${optionPath}.${name}" subOpt (depth + 1)
          ) option.options;
        in
        concatStringsSep "\n\n" subOptions
      else ""}
    '';

  # Generate actions library documentation
  generateActionsDoc = actionsLib:
    let
      actionsList = mapAttrsToList (name: action: {
        inherit name action;
      }) actionsLib;

      sortedActions = sort (a: b: a.name < b.name) actionsList;

      formatAction = { name, action }:
        let
          actionDesc =
            if name == "spawn" then "Execute a command"
            else if name == "spawn_shell" then "Execute a shell command"
            else if name == "close_window" then "Close the focused window"
            else if name == "fullscreen_window" then "Toggle window fullscreen"
            else if name == "focus_left" then "Focus window to the left"
            else if name == "focus_right" then "Focus window to the right"
            else if name == "focus_up" then "Focus window above"
            else if name == "focus_down" then "Focus window below"
            else if name == "move_left" then "Move window left"
            else if name == "move_right" then "Move window right"
            else if name == "move_up" then "Move window up"
            else if name == "move_down" then "Move window down"
            else if name == "focus_workspace_next" then "Focus next workspace"
            else if name == "focus_workspace_previous" then "Focus previous workspace"
            else if name == "screenshot" then "Take a screenshot"
            else if name == "quit" then "Quit niri"
            else "Action: ${name}";

          usage =
            if name == "spawn" then ''`spawn "command"`''
            else if name == "spawn_shell" then ''`spawn_shell "shell command"`''
            else "`${name}`";
        in ''
          ### `${name}`

          ${actionDesc}

          **Usage:** ${usage}
        '';

    in ''
      ## Actions Library

      The niri module provides a convenient actions library accessible via `config.lib.niri.actions`. These actions can be used in keybindings to perform various operations.

      ### Usage in Bindings

      ```nix
      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "alacritty";
        "Mod+Q".action = close_window;
        "Mod+F".action = fullscreen_window;
      };
      ```

      ### Available Actions

      ${concatStringsSep "\n\n" (map formatAction sortedActions)}
    '';

  # Generate type documentation
  generateTypeDoc = nixTypes:
    let
      customTypes = [
        {
          name = "Color";
          description = "Color value in various formats";
          examples = [
            "`#ff0000`" "`#rgb`" "`red`" "`rgb(255, 0, 0)`" "`rgba(255, 0, 0, 0.5)`"
          ];
        }
        {
          name = "Gradient";
          description = "Color gradient definition";
          examples = [
            ''```nix
{
  from = "#ff0000";
  to = "#0000ff";
  angle = 45;
  relative_to = "window";
  color_space = "srgb";
}
```''
          ];
        }
        {
          name = "Corner Radius";
          description = "Border radius - single value or per-corner";
          examples = [
            "`12` (all corners)" "`[8, 12, 8, 12]` (top-left, top-right, bottom-right, bottom-left)"
          ];
        }
        {
          name = "Preset Size";
          description = "Size specification as proportion or fixed pixels";
          examples = [
            "`{ proportion = 0.5; }` (50% of available space)"
            "`{ fixed = 1920; }` (1920 pixels)"
          ];
        }
      ];

      formatCustomType = { name, description, examples }:
        ''
          ### ${name}

          ${description}

          **Examples:**
          ${concatStringsSep "  \n" examples}
        '';

    in ''
      ## Custom Types

      The niri module defines several custom types for type-safe configuration:

      ${concatStringsSep "\n\n" (map formatCustomType customTypes)}
    '';

  # Generate enum documentation
  generateEnumDoc =
    let
      enums = [
        {
          name = "Modifier Keys";
          values = [ "ctrl" "shift" "alt" "super" "iso-level3-shift" "iso-level5-shift" ];
          description = "Keyboard modifier keys for keybindings";
        }
        {
          name = "Transform";
          values = [ "normal" "90" "180" "270" "flipped" "flipped-90" "flipped-180" "flipped-270" ];
          description = "Output transformation/rotation";
        }
        {
          name = "Center Focused Column";
          values = [ "never" "always" "on-overflow" ];
          description = "When to center the focused column";
        }
        {
          name = "Acceleration Profile";
          values = [ "adaptive" "flat" ];
          description = "Mouse/touchpad acceleration profile";
        }
        {
          name = "Click Method";
          values = [ "clickfinger" "button-areas" ];
          description = "Touchpad click method";
        }
        {
          name = "Scroll Method";
          values = [ "no-scroll" "two-finger" "edge" "on-button-down" ];
          description = "Touchpad scroll method";
        }
      ];

      formatEnum = { name, values, description }:
        ''
          ### ${name}

          ${description}

          **Valid values:** ${concatStringsSep ", " (map (v: "`${v}`") values)}
        '';

    in ''
      ## Enums

      Many options accept only specific predefined values:

      ${concatStringsSep "\n\n" (map formatEnum enums)}
    '';

  # Generate validation documentation
  generateValidationDoc = ''
    ## Validation

    The niri module provides comprehensive validation to catch configuration errors at build time:

    ### Type Validation
    - All options have strongly-typed Nix types
    - Invalid types are caught during evaluation
    - Clear error messages guide users to correct issues

    ### Range Validation
    - Numeric values are validated against valid ranges
    - Examples: gaps must be non-negative, repeat rates have valid bounds

    ### Enum Validation
    - Only valid enum values are accepted
    - Unknown enum values result in build errors

    ### Cross-Option Validation
    - References between options are validated
    - Example: window rules referencing non-existent outputs or workspaces
    - Prevents runtime configuration errors

    ### Format Validation
    - Colors must be valid hex, CSS names, or RGB functions
    - Regular expressions are validated for syntax
    - File paths and other format-specific values are checked
  '';

  # Generate examples documentation
  generateExamplesDoc = ''
    ## Configuration Examples

    ### Basic Setup

    ```nix
    programs.niri = {
      enable = true;
      settings = {
        input = {
          keyboard = {
            xkb = {
              layout = "us";
              variant = "";
            };
            repeat-delay = 600;
            repeat-rate = 25;
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
            width = 4;
            active-color = "#7fc8ff";
          };
        };

        binds = with config.lib.niri.actions; {
          "Mod+Return".action = spawn "alacritty";
          "Mod+Q".action = close-window;
          "Mod+F".action = fullscreen-window;
        };
      };
    };
    ```

    ### Advanced Multi-Monitor Setup

    ```nix
    programs.niri.settings = {
      outputs = [
        {
          name = "eDP-1";
          scale = 1.25;
          position = { x = 0; y = 0; };
          mode = {
            width = 2560;
            height = 1600;
            refresh_rate = 165.0;
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

      window-rules = [
        {
          matches = [{ app-id = "firefox"; }];
          open-on-output = "DP-1";
          open-on-workspace = "browser";
        }
        {
          matches = [{ app-id = "Alacritty"; }];
          open-on-output = "eDP-1";
        }
      ];
    };
    ```

    ### Animation Configuration

    ```nix
    programs.niri.settings.animations = {
      slowdown = 0.8;

      workspace-switch = {
        spring = {
          damping-ratio = 1.2;
          stiffness = 800.0;
          epsilon = 0.0001;
        };
      };

      window-open = {
        easing = {
          duration-ms = 200;
          curve = "ease-out-expo";
        };
      };
    };
    ```
  '';

  # Main documentation generator
  generateModuleDocs = { nixTypes, actionsLib ? {}, moduleOptions ? {} }:
    let
      timestamp = "<!-- Generated on $(date -u +'%Y-%m-%d %H:%M:%S UTC') -->";

      # Generate table of contents
      toc = ''
        ## Table of Contents

        - [Overview](#overview)
        - [Installation](#installation)
        - [Module Options](#module-options)
        - [Actions Library](#actions-library)
        - [Custom Types](#custom-types)
        - [Enums](#enums)
        - [Validation](#validation)
        - [Configuration Examples](#configuration-examples)
        - [Troubleshooting](#troubleshooting)
      '';

      # Generate overview
      overview = ''
        ## Overview

        The niri home-manager module provides comprehensive, type-safe configuration for the niri Wayland compositor. This module is automatically generated from the niri source code to ensure complete coverage of all configuration options and maintain synchronization with niri development.

        ### Key Features

        - **Type Safety**: All configuration options are strongly typed with comprehensive validation
        - **Auto-Generated**: Automatically updated when niri configuration changes
        - **Complete Coverage**: All niri configuration options supported
        - **Documentation**: Rich documentation extracted from niri source code
        - **Actions Library**: Convenient helpers for keybindings and window management
        - **Validation**: Build-time validation prevents runtime configuration errors
      '';

      # Generate installation guide
      installation = ''
        ## Installation

        ### Using Flakes

        Add the niri flake to your system configuration:

        ```nix
        {
          inputs = {
            nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
            home-manager.url = "github:nix-community/home-manager";
            niri-flake.url = "github:your-username/niri-flake";
          };

          outputs = { nixpkgs, home-manager, niri-flake, ... }: {
            homeConfigurations.youruser = home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
              modules = [
                niri-flake.homeManagerModules.niri
                ./home.nix
              ];
            };
          };
        }
        ```

        ### In Your Home Configuration

        ```nix
        # home.nix
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

      # Generate options documentation
      optionsDoc = if moduleOptions != {} then
        let
          rootOptions = moduleOptions.programs.niri or {};
          optionsList = mapAttrsToList (name: option:
            generateOptionDoc "programs.niri.${name}" option 0
          ) rootOptions;
        in ''
          ## Module Options

          The following options are available for configuring niri:

          ${concatStringsSep "\n\n" optionsList}
        ''
      else ''
        ## Module Options

        Complete module options documentation will be generated from the actual niri configuration structures when the module is built with real niri source code.

        ### Core Options

        #### `programs.niri.enable`
        **Type:** boolean
        **Default:** `false`

        Whether to enable niri, a scrollable-tiling Wayland compositor.

        #### `programs.niri.package`
        **Type:** package
        **Default:** `pkgs.niri`

        The niri package to use.

        #### `programs.niri.settings`
        **Type:** attribute set
        **Default:** `{}`

        Niri configuration settings. This is where all niri configuration options are specified.

        #### `programs.niri.finalConfigFile`
        **Type:** path (read-only)

        The generated KDL configuration file path. This file is automatically created from your Nix configuration.
      '';

      # Generate troubleshooting section
      troubleshooting = ''
        ## Troubleshooting

        ### Common Issues

        #### Validation Errors
        If you encounter validation errors:
        1. Check that enum values match exactly (case-sensitive)
        2. Ensure numeric values are within valid ranges
        3. Verify color formats are valid (hex, CSS names, or RGB functions)
        4. Confirm all required fields are provided

        #### Missing Options
        If an option seems to be missing:
        1. Check if it's a new niri feature not yet in the generator
        2. Verify the option name matches the niri documentation exactly
        3. Update your flake to get the latest generated module

        #### KDL Generation Issues
        If the generated KDL configuration doesn't work:
        1. Check the generated file at `~/.config/niri/config.kdl`
        2. Verify string values don't contain unescaped special characters
        3. Ensure boolean values are `true`/`false`, not strings

        ### Getting Help

        1. Check the [niri documentation](https://github.com/YaLTeR/niri/wiki)
        2. Review the generated KDL file for syntax issues
        3. File issues on the niri-flake repository for module-specific problems
        4. Join the niri community for general compositor questions

        ### Debugging

        To debug configuration issues:

        ```bash
        # Check the generated configuration
        cat ~/.config/niri/config.kdl

        # Validate niri can parse the configuration
        niri validate

        # Run niri with verbose logging
        RUST_LOG=niri=debug niri
        ```
      '';

    in ''
      # Niri Home-Manager Module Documentation

      ${timestamp}

      ${toc}

      ${overview}

      ${installation}

      ${optionsDoc}

      ${generateActionsDoc actionsLib}

      ${generateTypeDoc nixTypes}

      ${generateEnumDoc}

      ${generateValidationDoc}

      ${generateExamplesDoc}

      ${troubleshooting}

      ---

      *This documentation is automatically generated from the niri source code. For the most up-to-date information, please refer to the [niri project](https://github.com/YaLTeR/niri).*
    '';

in {
  inherit
    generateModuleDocs
    generateOptionDoc
    generateActionsDoc
    generateTypeDoc
    generateEnumDoc
    generateValidationDoc
    generateExamplesDoc;

  # Helper functions for external use
  inherit
    typeToString
    formatDefault
    escapeMarkdown;
}