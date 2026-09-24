# Static module — provides enable/package/extraConfig options and the config section.
# Options for programs.niri.settings.* live in generated-options.nix (auto-generated).
# Regenerate options: python3 generate.py
{ config, lib, pkgs, ... }:

let
  cfg = config.programs.niri;

  # ---------------------------------------------------------------------------
  # KDL serialiser
  # ---------------------------------------------------------------------------

  # Indent: 2 spaces × n
  ind = n: builtins.concatStringsSep "" (builtins.genList (_: "  ") n);

  # Wrap a string in KDL double-quoted string literal with proper escape sequences.
  escKdl = s:
    "\"" + builtins.replaceStrings
      [ "\\"  "\""  "\n"  "\r"  "\t" ]
      [ "\\\\" "\\\"" "\\n" "\\r" "\\t" ]
      s + "\"";

  # Render a KDL property list from an attrset (for match/exclude nodes).
  # Returns " key=val ..." with a leading space, or "" when nothing to emit.
  attrsToProps = attrs:
    builtins.concatStringsSep "" (lib.mapAttrsToList (k: v:
      if v == null then ""
      else if builtins.isAttrs v && v ? __kdl_null then " ${k}=null"
      else if builtins.isBool v          then " ${k}=${if v then "true" else "false"}"
      else if builtins.isInt v           then " ${k}=${toString v}"
      else if builtins.isFloat v         then " ${k}=${toString v}"
      else if builtins.isString v        then " ${k}=${escKdl v}"
      else ""
    ) attrs);

  # Render field k with value v at indent level n.
  # kk is the KDL node name (may differ from the Nix field name k).
  renderField = n: k: v:
    let
      kk = if k == "matches" then "match"
           else if k == "excludes" then "exclude"
           else k;
      p = ind n;
    in
    if v == null            then ""
    else if v == false      then ""                                       # Flag off → omit
    else if v == true       then "${p}${kk}\n"                            # Flag on → bare node
    else if builtins.isAttrs v && v ? __kdl_flag then "${p}${v.__kdl_flag}\n"
    else if builtins.isInt v    || builtins.isFloat v then "${p}${kk} ${toString v}\n"
    else if builtins.isString v then "${p}${kk} ${escKdl v}\n"
    else if builtins.isList v   then renderList n kk v
    else if builtins.isAttrs v  then renderAttrBlock n kk v
    else "";

  # Render a list for KDL node name kk at indent n.
  renderList = n: kk: items:
    if items == [] then ""
    else
      let first = builtins.head items; in
      # match / exclude → KDL property-style nodes
      if builtins.elem kk [ "match" "exclude" ] then
        builtins.concatStringsSep "" (map (item:
          let props = attrsToProps item;
          in if props == "" then "" else "${ind n}${kk}${props}\n"
        ) items)
      # Items with a "command" field → positional-arg node (spawn-at-startup, etc.)
      else if builtins.isAttrs first && first ? command then
        builtins.concatStringsSep "" (map (item:
          let
            cmdArgs =
              if builtins.isList item.command
              then builtins.concatStringsSep "" (map (a: " ${escKdl a}") item.command)
              else if builtins.isString item.command
              then " ${escKdl item.command}"
              else "";
            rest = builtins.removeAttrs item [ "command" ];
            children = builtins.concatStringsSep "" (
              lib.mapAttrsToList (ck: cv: renderField (n + 1) ck cv) rest
            );
          in
          if children == "" then "${ind n}${kk}${cmdArgs}\n"
          else "${ind n}${kk}${cmdArgs} {\n${children}${ind n}}\n"
        ) items)
      # Single-key scalar items → one block whose children are the list items
      # (preset-column-widths, preset-window-heights)
      else if builtins.isAttrs first
              && builtins.length (builtins.attrNames first) == 1
              && ! (builtins.isAttrs first.${builtins.head (builtins.attrNames first)})
      then
        let
          children = builtins.concatStringsSep "" (map (item:
            let nm = builtins.head (builtins.attrNames item);
            in renderField (n + 1) nm item.${nm}
          ) items);
        in
        if children == "" then "" else "${ind n}${kk} {\n${children}${ind n}}\n"
      # Standard: one node per list item (output, workspace, window-rule, …)
      else
        builtins.concatStringsSep "" (map (item:
          if builtins.isAttrs item then renderAttrBlock n kk item
          else renderField n kk item
        ) items);

  # Render a __niriAction sentinel as a single KDL action node (no wrapper).
  # { __niriAction = "spawn"; args = ["alacritty"]; props = {}; }  →  spawn "alacritty"
  renderAction = n: v:
    let
      p     = ind n;
      name  = v.__niriAction;
      args  = if v ? args  then v.args  else [];
      props = if v ? props then v.props else {};
      argStr = lib.concatStrings (map (a:
        if builtins.isString a                       then " ${escKdl a}"
        else if builtins.isInt a || builtins.isFloat a then " ${toString a}"
        else ""
      ) args);
      propStr = lib.concatStrings (lib.mapAttrsToList (pk: pv:
        if pv == null || pv == false then ""
        else if pv == true  then " ${pk}=true"
        else if builtins.isInt pv || builtins.isFloat pv then " ${pk}=${toString pv}"
        else " ${pk}=${escKdl (toString pv)}"
      ) props);
    in "${p}${name}${argStr}${propStr}\n";

  # Render the action submodule of a bind entry as KDL child nodes.
  # Legacy attrset form: { spawn = ["a" "b"]; } → spawn "a" "b"
  # Sentinel form handled by renderAction above.
  renderBindAction = n: action:
    builtins.concatStringsSep "" (lib.mapAttrsToList (ak: av:
      if av == null || av == false || av == [] then ""
      else if av == true then "${ind n}${ak}\n"
      else if builtins.isList av then
        "${ind n}${ak}${builtins.concatStringsSep "" (map (a: " ${escKdl a}") av)}\n"
      else renderField n ak av
    ) action);

  # Render an attrset as a KDL block.
  # If attrs has a string-valued "name" field it becomes the positional argument.
  # If attrs has an "action" field it is a bind entry: metadata → KDL properties,
  # action → KDL child node.
  renderAttrBlock = n: kk: attrs:
    if attrs ? action then
      # Bind entry: action is a child node; everything else is a KDL property.
      # hotkey-overlay submodule → hotkey-overlay-title property
      let
        rawProps = builtins.removeAttrs attrs [ "action" ];
        hoTitle  =
          if rawProps ? hotkey-overlay && rawProps.hotkey-overlay != null then
            let ho = rawProps.hotkey-overlay; in
            { "hotkey-overlay-title" =
                if ho.hidden then { __kdl_null = true; }
                else ho.title; }
          else {};
        props   = (builtins.removeAttrs rawProps [ "hotkey-overlay" ]) // hoTitle;
        propStr = attrsToProps props;
        body    =
          if attrs.action == null then ""
          else if builtins.isAttrs attrs.action && attrs.action ? __niriAction
          then renderAction (n + 1) attrs.action   # sentinel from config.lib.niri.actions.*
          else renderBindAction (n + 1) attrs.action;  # legacy: { spawn = ["..."]; }
      in
      if body == "" && propStr == "" then ""
      else "${ind n}${kk}${propStr} {\n${body}${ind n}}\n"
    else
      let
        posArg    = if attrs ? name && builtins.isString attrs.name
                    then " ${escKdl attrs.name}" else "";
        childAttrs = if attrs ? name && builtins.isString attrs.name
                     then builtins.removeAttrs attrs [ "name" ] else attrs;
        children  = builtins.concatStringsSep "" (
          lib.mapAttrsToList (ck: cv: renderField (n + 1) ck cv) childAttrs
        );
      in
      if children == "" && posArg == "" then ""
      else "${ind n}${kk}${posArg} {\n${children}${ind n}}\n";

  # Top-level conversion: settings attrset → KDL string.
  settingsToKdl = settings:
    builtins.concatStringsSep "" (
      lib.mapAttrsToList (k: v: renderField 0 k v) settings
    );

  kdlText = settingsToKdl cfg.settings + cfg.extraConfig;

in
{
  imports = [ ./generated-options.nix ];

  options.programs.niri = {
    enable = lib.mkEnableOption "niri Wayland compositor";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.niri;
      defaultText = lib.literalExpression "pkgs.niri";
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = lib.mdDoc ''
        Raw KDL appended verbatim after the generated config.
        Use this for constructs the structured options cannot yet express.
      '';
    };

    finalConfig = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      readOnly = true;
      description = lib.mdDoc ''
        The fully rendered niri config KDL that will be written to
        `~/.config/niri/config.kdl`. Read-only — useful for inspecting exactly
        what the module generates, e.g. `nix eval .#homeConfigurations.you.config.programs.niri.finalConfig`.
      '';
    };
  };

  config = lib.mkMerge [
  {
    lib.niri.actions = import ./lib/actions.nix;
  }
  (lib.mkIf cfg.enable {
    programs.niri.finalConfig = kdlText;

    home.packages = [ cfg.package ];

    # Write the config file via a derivation so that niri validate runs at
    # every `home-manager switch` build — a bad config is a build failure.
    xdg.configFile."niri/config.kdl".source =
      pkgs.runCommand "niri-config-validated" {
        nativeBuildInputs = [ cfg.package ];
        text = kdlText;
        passAsFile = [ "text" ];
      } ''
        cp "$textPath" "$out"
        HOME=$(mktemp -d) \
          XDG_CONFIG_HOME="$HOME/.config" \
          XDG_DATA_HOME="$HOME/.local/share" \
          niri validate --config "$out"
      '';
  })
  ];
}
