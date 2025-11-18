{ lib }:

let
  inherit (lib)
    splitString
    filter
    head
    tail
    length
    concatStringsSep
    hasPrefix
    removePrefix
    removeSuffix
    stringAsChars
    escapeShellArg
    match
    replaceStrings;

  # Regex patterns for parsing Rust code
  patterns = {
    # Match struct definitions: pub struct StructName {
    struct = "^[[:space:]]*pub[[:space:]]+struct[[:space:]]+([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*\\{";

    # Match field definitions: pub field_name: Type,
    field = "^[[:space:]]*pub[[:space:]]+([a-z_][a-z0-9_]*)[[:space:]]*:[[:space:]]*([^,]+),?";

    # Match derive attributes: #[derive(...)]
    derive = "^[[:space:]]*#\\[derive\\(([^\\)]+)\\)\\]";

    # Match serde/knuffel attributes: #[knuffel(...)]
    knuffel_attr = "^[[:space:]]*#\\[knuffel\\(([^\\)]+)\\)\\]";

    # Match documentation comments: /// Comment text
    doc_comment = "^[[:space:]]*///[[:space:]]*(.*)$";

    # Match end of struct: }
    struct_end = "^[[:space:]]*\\}[[:space:]]*$";

    # Match enum definitions: pub enum EnumName {
    enum = "^[[:space:]]*pub[[:space:]]+enum[[:space:]]+([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*\\{";

    # Match enum variants: VariantName, or VariantName(Type), or VariantName { field: Type }
    enum_variant = "^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*)([^,]*),?";
  };

  # Parse a single Rust source file
  parseRustFile = filePath: fileContent:
    let
      lines = splitString "\n" fileContent;

      # Parse lines iteratively, maintaining state
      parseLines = lines: state:
        if length lines == 0 then state
        else
          let
            line = head lines;
            rest = tail lines;

            # Check what kind of line this is
            structMatch = match patterns.struct line;
            enumMatch = match patterns.enum line;
            fieldMatch = match patterns.field line;
            docMatch = match patterns.doc_comment line;
            endMatch = match patterns.struct_end line;

          in
          if structMatch != null then
            # Start of a new struct
            let
              structName = head structMatch;
              newState = state // {
                currentStruct = structName;
                structs = state.structs // {
                  ${structName} = {
                    name = structName;
                    fields = {};
                    docs = [];
                    attributes = [];
                  };
                };
                pendingDocs = [];
                pendingAttrs = [];
              };
            in
            parseLines rest newState

          else if enumMatch != null then
            # Start of a new enum
            let
              enumName = head enumMatch;
              newState = state // {
                currentEnum = enumName;
                enums = state.enums // {
                  ${enumName} = {
                    name = enumName;
                    variants = [];
                    docs = state.pendingDocs;
                  };
                };
                pendingDocs = [];
              };
            in
            parseLines rest newState

          else if fieldMatch != null && state.currentStruct != null then
            # Field in current struct
            let
              fieldName = head fieldMatch;
              fieldType = head (tail fieldMatch);
              currentStructName = state.currentStruct;
              currentStruct = state.structs.${currentStructName};

              newField = {
                name = fieldName;
                type = lib.removePrefix " " (lib.removeSuffix " " fieldType);
                docs = state.pendingDocs;
                attributes = state.pendingAttrs;
              };

              updatedStruct = currentStruct // {
                fields = currentStruct.fields // {
                  ${fieldName} = newField;
                };
              };

              newState = state // {
                structs = state.structs // {
                  ${currentStructName} = updatedStruct;
                };
                pendingDocs = [];
                pendingAttrs = [];
              };
            in
            parseLines rest newState

          else if docMatch != null then
            # Documentation comment
            let
              docText = head docMatch;
              newState = state // {
                pendingDocs = state.pendingDocs ++ [ docText ];
              };
            in
            parseLines rest newState

          else if endMatch != null then
            # End of struct/enum
            let
              newState = state // {
                currentStruct = null;
                currentEnum = null;
              };
            in
            parseLines rest newState

          else
            # Continue with next line
            parseLines rest state;

      initialState = {
        structs = {};
        enums = {};
        currentStruct = null;
        currentEnum = null;
        pendingDocs = [];
        pendingAttrs = [];
      };

    in
    parseLines lines initialState;

  # Extract configuration structures from niri source
  parseNiriConfig = niriSrc:
    let
      # Read the main config file
      configFile = "${niriSrc}/niri-config/src/lib.rs";
      configContent = builtins.readFile configFile;
      configParsed = parseRustFile configFile configContent;

      # Read additional module files
      moduleFiles = [
        "input.rs"
        "output.rs"
        "layout.rs"
        "animations.rs"
        "binds.rs"
        "gestures.rs"
        "window_rule.rs"
        "layer_rule.rs"
        "workspace.rs"
        "recent_windows.rs"
        "appearance.rs"
        "debug.rs"
        "misc.rs"
        "utils.rs"
      ];

      parseModuleFile = fileName:
        let
          filePath = "${niriSrc}/niri-config/src/${fileName}";
          content = builtins.readFile filePath;
        in
        parseRustFile filePath content;

      moduleParsed = lib.listToAttrs (map (fileName: {
        name = lib.removeSuffix ".rs" fileName;
        value = parseModuleFile fileName;
      }) moduleFiles);

      # Combine all parsed results
      allStructs = lib.foldl (acc: module: acc // module.structs)
        configParsed.structs
        (lib.attrValues moduleParsed);

      allEnums = lib.foldl (acc: module: acc // module.enums)
        configParsed.enums
        (lib.attrValues moduleParsed);

    in {
      structs = allStructs;
      enums = allEnums;
      mainConfig = configParsed.structs.Config or null;
    };

in {
  inherit parseNiriConfig parseRustFile patterns;
}