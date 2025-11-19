{ lib }:

let
  inherit (lib)
    mapAttrsToList
    mapAttrs
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
    hasSuffix
    hasInfix
    getAttr
    flatten;

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
      else "`[...]` (list with ${toString (length defaultValue)} items)"
    else if builtins.isAttrs defaultValue then
      if (attrNames defaultValue) == [] then "`{}` (empty set)"
      else
        # Safety check for complex attribute sets to avoid infinite recursion
        let attrCount = length (attrNames defaultValue);
        in if attrCount > 5 then "`{...}` (attribute set with ${toString attrCount} attributes)"
           else "`{...}` (attribute set)"
    else "`<complex value>`";

  # Extract options from nested type definitions with improved recursion
  extractOptionsFromType = type:
    if type ? getSubOptions then
      type.getSubOptions []
    else if type ? options then
      type.options
    else if type ? functor && type.functor ? wrapped then
      extractOptionsFromType type.functor.wrapped
    else if type ? nestedTypes then
      # Handle listOf, attrsOf, etc.
      let nestedType = type.nestedTypes.elemType or type.nestedTypes.functor.wrapped or null;
      in if nestedType != null then extractOptionsFromType nestedType else {}
    else {};

  # Generate all nested options recursively
  generateAllOptions = options: prefix:
    let
      # Generate options for current level
      currentLevel = mapAttrsToList (name: option:
        let
          fullName = if prefix == "" then name else "${prefix}.${name}";
          optionType = option.type or lib.types.unspecified;
          nestedOptions = extractOptionsFromType optionType;
          description = option.description or "No description available";
          defaultValue = option.default or null;
          hasDefault = option ? default;
          exampleValue = option.example or null;
          hasExample = option ? example;

          # Format default and example information
          defaultInfo = if hasDefault then formatDefault defaultValue else "No default";
          exampleInfo = if hasExample then formatDefault exampleValue else null;

          # Recursively generate nested options
          subOptionsDoc = if nestedOptions != {} then
            let subOptions = generateAllOptions nestedOptions fullName;
            in if subOptions != [] then "\n\n**Sub-options:**\n${concatStringsSep "\n" subOptions}" else ""
          else "";

        in ''
          #### `${fullName}`

          **Type:** ${typeToString optionType}
          **Default:** ${defaultInfo}${if exampleInfo != null then ''
          **Example:** ${exampleInfo}'' else ""}

          ${description}${subOptionsDoc}
        ''
      ) options;

      # Generate options for nested levels
      nestedLevels = filter (x: x != []) (mapAttrsToList (name: option:
        let
          fullName = if prefix == "" then name else "${prefix}.${name}";
          optionType = option.type or lib.types.unspecified;
          nestedOptions = extractOptionsFromType optionType;
        in
        if nestedOptions != {} then generateAllOptions nestedOptions fullName else []
      ) options);

    in currentLevel ++ (flatten nestedLevels);

  # Generate comprehensive actions documentation with all actions from actionsLib
  generateActionsDoc = actionsLib:
    let
      # Create comprehensive actions from the actual actions library
      allActions = mapAttrs (name: kdlAction: {
        kdl = name;
        isFunction = builtins.isFunction kdlAction;
        desc =
          # Generate descriptions based on action names
          if name == "quit" then "Quit niri compositor"
          else if name == "suspend" then "Suspend the system"
          else if lib.hasPrefix "power-" name then
            if lib.hasSuffix "-monitors" name then
              if lib.hasInfix "off" name then "Turn off all monitors"
              else "Turn on all monitors"
            else "Power management action"
          else if lib.hasPrefix "debug-" name || lib.hasInfix "debug" name then
            "Debug and development action"
          else if lib.hasPrefix "spawn" name then
            if name == "spawn-sh" then "Execute a shell command"
            else "Execute a command"
          else if lib.hasPrefix "screenshot" name then
            if lib.hasSuffix "-screen" name then "Take a screenshot of entire screen"
            else if lib.hasSuffix "-window" name then "Take a screenshot of current window"
            else "Take a screenshot"
          else if lib.hasPrefix "close" name then "Close the focused window"
          else if lib.hasPrefix "focus" name then
            if lib.hasInfix "workspace" name then "Focus workspace navigation"
            else if lib.hasInfix "window" name then "Focus window navigation"
            else if lib.hasInfix "monitor" name then "Focus monitor navigation"
            else if lib.hasInfix "column" name then "Focus column navigation"
            else "Focus navigation"
          else if lib.hasPrefix "move" name then
            if lib.hasInfix "workspace" name then "Move to workspace"
            else if lib.hasInfix "monitor" name then "Move to monitor"
            else if lib.hasInfix "column" name then "Move column"
            else if lib.hasInfix "window" name then "Move window"
            else "Move action"
          else if lib.hasInfix "fullscreen" name then "Toggle window fullscreen"
          else if lib.hasInfix "overview" name then
            if lib.hasPrefix "toggle" name then "Toggle overview mode"
            else if lib.hasPrefix "open" name then "Open overview mode"
            else if lib.hasPrefix "close" name then "Close overview mode"
            else "Overview mode action"
          else if lib.hasInfix "floating" name then "Toggle window floating"
          else "Niri action";
        example =
          if builtins.isFunction kdlAction then "${name} \"argument\""
          else name;
      }) actionsLib;

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
              bind "Mod+Key" action="${action.kdl}${if action.isFunction then " \"argument\"" else ""}"
          }
          ```
        '';

      actionsDoc = concatStringsSep "\n\n" (map formatAction sortedActions);

    in ''
      ## Actions Library

      The niri module provides ${toString (length sortedActions)} built-in actions for window management, workspace navigation, and system control. All actions are available through `config.lib.niri.actions`.

      ### Available Actions (${toString (length sortedActions)} total)

      ${concatStringsSep "\n\n" (map formatAction sortedActions)}
    '';

in {
  # Generate comprehensive documentation with all components
  generateComprehensiveDocs = { nixTypes ? {}, actionsLib ? {}, schema ? null, moduleOptions ? {} }:
    let
      # Extract module options from schema if available
      moduleOptionsDoc = if schema != null && schema ? niriSettingsType && schema.niriSettingsType ? getSubOptions then
        let
          settingsOptions = schema.niriSettingsType.getSubOptions [];
          allOptionsDoc = generateAllOptions settingsOptions "";
        in ''
          ## Module Options

          The niri module provides ${toString (length allOptionsDoc)} configuration options organized in a hierarchical structure.

          ${concatStringsSep "\n\n" allOptionsDoc}
        ''
      else ''
        ## Module Options

        *Module options documentation requires a schema to be provided.*
      '';

      # Generate actions documentation
      actionsDoc = if actionsLib != {} then generateActionsDoc actionsLib else ''
        ## Actions Library

        *Actions documentation requires actionsLib to be provided.*
      '';

      # Header with module info
      headerDoc = ''
        # Niri Home-Manager Module Documentation

        This documentation covers the complete niri home-manager module including all configuration options and available actions.

        ## Module Overview

        The niri module allows you to configure the niri Wayland compositor through Home Manager. The module provides:

        - Comprehensive configuration validation through a detailed schema
        - A complete actions library for keybindings
        - Automatic KDL configuration generation
        - Type-safe configuration with helpful error messages

      '';

      # Generate version info if available
      versionInfo = if moduleOptions ? commit then ''
        **Module Information:**
        - Niri commit: `${moduleOptions.commit}`
        ${if moduleOptions ? repository then "- Repository: `${moduleOptions.repository}`" else ""}
        ${if moduleOptions ? sha256 then "- SHA256: `${moduleOptions.sha256}`" else ""}

      '' else "";

    in headerDoc + versionInfo + moduleOptionsDoc + "\n\n" + actionsDoc;
}