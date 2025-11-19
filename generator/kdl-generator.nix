{ lib }:

let
  inherit (lib)
    concatStringsSep
    mapAttrsToList
    hasPrefix
    removePrefix
    removeSuffix
    escapeShellArg
    stringAsChars
    filter
    length
    head
    tail
    isString
    isBool
    isInt
    isFloat
    isList
    isAttrs
    replaceStrings;

  # Escape a string for KDL
  escapeKdlString = str:
    let
      # KDL string escaping rules
      escaped = builtins.replaceStrings
        ["\"" "\\" "\n" "\r" "\t"]
        ["\\\"" "\\\\" "\\n" "\\r" "\\t"]
        str;
    in "\"${escaped}\"";

  # Format a KDL identifier (node names, property names)
  # Niri uses kebab-case in KDL, so we keep kebab-case as-is
  formatKdlIdentifier = name:
    if builtins.match "^[a-zA-Z][a-zA-Z0-9_-]*$" name != null then
      name
    else
      escapeKdlString name;

  # Format a KDL value based on its type
  formatKdlValue = value:
    if value == null then "null"
    else if isBool value then
      if value then "true" else "false"
    else if isInt value then toString value
    else if isFloat value then toString value
    else if isString value then escapeKdlString value
    else if isList value then
      # KDL doesn't have native arrays, so we represent as multiple nodes
      throw "Lists should be handled at the node level, not as values"
    else if isAttrs value then
      throw "Attrs should be handled at the node level, not as values"
    else
      escapeKdlString (toString value);

  # Generate KDL properties from an attribute set
  formatKdlProperties = props: indent:
    let
      propList = mapAttrsToList (name: value:
        let
          kdlName = formatKdlIdentifier name;
          kdlValue = formatKdlValue value;
        in
        if value != null then "${kdlName}=${kdlValue}" else null
      ) props;
      filteredProps = filter (prop: prop != null) propList;
    in
    if length filteredProps > 0 then
      " " + concatStringsSep " " filteredProps
    else "";

  # Generate KDL children from an attribute set
  formatKdlChildren = children: indent:
    let
      childIndent = indent + "    ";
      childList = mapAttrsToList (name: value:
        formatKdlNode name value childIndent
      ) children;
      filteredChildren = filter (child: child != "") childList;
    in
    if length filteredChildren > 0 then
      " {\n" + concatStringsSep "\n" filteredChildren + "\n" + indent + "}"
    else "";

  # Generate a single KDL node
  formatKdlNode = name: value: indent:
    let
      kdlName = formatKdlIdentifier name;
    in
    if value == null then ""
    else if isBool value then
      if value then "${indent}${kdlName}" else ""
    else if isInt value || isFloat value || isString value then
      "${indent}${kdlName} ${formatKdlValue value}"
    else if isList value then
      # Handle lists as multiple nodes with the same name
      let
        listItems = map (item:
          if isAttrs item then
            formatKdlNode name item indent
          else
            "${indent}${kdlName} ${formatKdlValue item}"
        ) value;
      in
      concatStringsSep "\n" (filter (item: item != "") listItems)
    else if isAttrs value then
      let
        # Separate simple properties from complex children
        simpleProps = lib.filterAttrs (k: v: !isAttrs v && !isList v) value;
        complexChildren = lib.filterAttrs (k: v: isAttrs v || isList v) value;

        propsStr = formatKdlProperties simpleProps indent;
        childrenStr = formatKdlChildren complexChildren indent;
      in
      if simpleProps == {} && complexChildren == {} then ""
      else "${indent}${kdlName}${propsStr}${childrenStr}"
    else
      "${indent}${kdlName} ${formatKdlValue value}";

  # Generate the complete KDL configuration
  generateKdlConfig = config:
    let
      # Handle special niri configuration sections
      processSection = sectionName: sectionValue:
        if sectionName == "binds" then
          # Special handling for keybinds
          formatBindsSection sectionValue
        else if sectionName == "window_rules" then
          # Special handling for window rules
          formatWindowRulesSection sectionValue
        else if sectionName == "layer_rules" then
          # Special handling for layer rules
          formatLayerRulesSection sectionValue
        else if sectionName == "spawn_at_startup" then
          # Special handling for startup commands
          formatSpawnSection sectionValue
        else if sectionName == "outputs" then
          # Special handling for output configurations
          formatOutputsSection sectionValue
        else if sectionName == "workspaces" then
          # Special handling for workspace definitions
          formatWorkspacesSection sectionValue
        else
          # Regular section formatting
          formatKdlNode sectionName sectionValue "";

      sections = mapAttrsToList processSection config;
      filteredSections = filter (section: section != "") sections;
    in
    concatStringsSep "\n\n" filteredSections;

  # Format the binds section
  formatBindsSection = binds:
    let
      bindList = mapAttrsToList (key: action:
        let
          # Convert bind key notation
          kdlKey = formatKdlValue key;
          actionStr = if isString action then
            formatKdlValue action
          else if isAttrs action then
            # Handle complex action objects
            toString action  # Simplified for now
          else
            formatKdlValue (toString action);
        in
        "bind ${kdlKey} { ${actionStr}; }"
      ) binds;
    in
    concatStringsSep "\n" bindList;

  # Format window rules section
  formatWindowRulesSection = rules:
    let
      ruleList = map (rule:
        let
          # Extract match conditions and rules
          matches = lib.filterAttrs (k: v: hasPrefix "match" k || lib.elem k ["app_id" "title" "is_active"]) rule;
          ruleProps = lib.filterAttrs (k: v: !hasPrefix "match" k && !lib.elem k ["app_id" "title" "is_active"]) rule;

          matchStr = formatKdlProperties matches "";
          rulesStr = formatKdlChildren ruleProps "";
        in
        "window-rule${matchStr}${rulesStr}"
      ) rules;
    in
    concatStringsSep "\n\n" ruleList;

  # Format layer rules section
  formatLayerRulesSection = rules:
    let
      ruleList = map (rule:
        formatKdlNode "layer-rule" rule ""
      ) rules;
    in
    concatStringsSep "\n\n" ruleList;

  # Format spawn at startup section
  formatSpawnSection = spawns:
    let
      spawnList = map (spawn:
        if isString spawn then
          "spawn-at-startup ${formatKdlValue spawn}"
        else if isAttrs spawn then
          formatKdlNode "spawn-at-startup" spawn ""
        else
          "spawn-at-startup ${formatKdlValue (toString spawn)}"
      ) spawns;
    in
    concatStringsSep "\n" spawnList;

  # Format outputs section
  formatOutputsSection = outputs:
    if isList outputs then
      let
        outputList = map (output:
          formatKdlNode "output" output ""
        ) outputs;
      in
      concatStringsSep "\n\n" outputList
    else if isAttrs outputs then
      # Handle single output or named outputs
      let
        outputList = mapAttrsToList (name: output:
          if name == "default" then
            formatKdlNode "output" output ""
          else
            formatKdlNode "output" (output // { name = name; }) ""
        ) outputs;
      in
      concatStringsSep "\n\n" outputList
    else "";

  # Format workspaces section
  formatWorkspacesSection = workspaces:
    let
      workspaceList = map (workspace:
        formatKdlNode "workspace" workspace ""
      ) workspaces;
    in
    concatStringsSep "\n\n" workspaceList;

in {
  inherit
    generateKdlConfig
    formatKdlNode
    formatKdlValue
    formatKdlIdentifier
    escapeKdlString;
}