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

  # Render an attrset as a KDL block.
  # If attrs has a string-valued "name" field it becomes the positional argument.
  renderAttrBlock = n: kk: attrs:
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

        Use this for constructs the structured options cannot express, such as
        `binds { }` blocks or any section not yet covered by the generator.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
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
  };
}
