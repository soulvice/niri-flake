{ lib }:

let
  inherit (lib)
    types
    mkOption
    mkDefault
    hasPrefix
    removePrefix
    removeSuffix
    match
    head
    tail
    length
    elem
    listToAttrs
    attrValues
    foldl
    mapAttrs
    concatStringsSep
    replaceStrings;

  # Convert snake_case to kebab-case for option names
  snakeToKebab = str: replaceStrings ["_"] ["-"] str;

  # Extract generic type parameters from a type string
  extractGenericParams = typeStr:
    let
      # Match patterns like "Vec<T>", "Option<T>", "FloatOrInt<MIN, MAX>"
      genericMatch = match "^([A-Za-z_][A-Za-z0-9_]*)<([^>]+)>$" typeStr;
    in
    if genericMatch != null then {
      baseType = head genericMatch;
      params = lib.splitString "," (head (tail genericMatch));
    } else {
      baseType = typeStr;
      params = [];
    };

  # Map Rust primitive types to Nix types
  mapPrimitiveType = rustType:
    let
      cleanType = lib.removePrefix " " (lib.removeSuffix " " rustType);
    in
    if cleanType == "bool" then types.bool
    else if cleanType == "String" then types.str
    else if cleanType == "str" then types.str
    else if lib.elem cleanType ["u8" "u16" "u32" "u64" "usize"] then types.ints.unsigned
    else if lib.elem cleanType ["i8" "i16" "i32" "i64" "isize"] then types.int
    else if lib.elem cleanType ["f32" "f64"] then types.float
    else if hasPrefix "FloatOrInt" cleanType then
      let
        params = extractGenericParams cleanType;
        # Extract min/max if available
        min = if length params.params >= 1 then lib.toInt (lib.removePrefix " " (head params.params)) else null;
        max = if length params.params >= 2 then lib.toInt (lib.removePrefix " " (head (tail params.params))) else null;
      in
      if min != null && max != null then
        types.numbers.between min max
      else
        types.float
    else
      # Unknown primitive type, default to string
      types.str;

  # Map complex Rust types to Nix types
  mapComplexType = rustType: structs: enums:
    let
      cleanType = lib.removePrefix " " (lib.removeSuffix " " rustType);
      genericInfo = extractGenericParams cleanType;
      baseType = genericInfo.baseType;
      params = genericInfo.params;
    in

    # Handle generic container types
    if baseType == "Vec" && length params == 1 then
      types.listOf (mapRustTypeToNix (head params) structs enums)

    else if baseType == "Option" && length params == 1 then
      types.nullOr (mapRustTypeToNix (head params) structs enums)

    else if baseType == "HashMap" && length params == 2 then
      types.attrsOf (mapRustTypeToNix (head (tail params)) structs enums)

    # Handle custom niri types
    else if baseType == "Color" then
      # Color type validation will be handled in the validation system
      types.str

    else if baseType == "Gradient" then
      # Gradient is an attrset with from/to colors, angle, etc.
      types.attrs

    else if baseType == "RegexEq" then
      types.str

    else if baseType == "Flag" then
      types.bool

    else if baseType == "PresetSize" then
      # PresetSize is Proportion(f64) or Fixed(i32)
      types.oneOf [ types.float types.int ]

    else if baseType == "CornerRadius" then
      # CornerRadius can be a single value or per-corner
      types.oneOf [ types.float (types.listOf types.float) ]

    # Check if it's an enum
    else if enums ? ${baseType} then
      let
        enumDef = enums.${baseType};
        # Extract variant names - simplified version
        variantNames = [ "todo" ]; # Will be populated from actual enum parsing
      in
      types.enum variantNames

    # Check if it's a struct
    else if structs ? ${baseType} then
      # For structs, we'll create an attrset type
      let
        structDef = structs.${baseType};
        # Convert field names to kebab-case for options
        fieldOptions = lib.mapAttrs' (fieldName: field:
          let
            kebabName = snakeToKebab fieldName;
          in {
            name = kebabName;
            value = mkOption {
              type = mapRustTypeToNix field.type structs enums;
              description = lib.concatStringsSep " " (field.docs or []);
              default = getDefaultValue field.type;
              # Store original name for KDL generation
              _meta.originalName = fieldName;
            };
          }
        ) structDef.fields;
      in
      types.submodule {
        options = fieldOptions;
      }

    else
      # Fallback to string for unknown types
      types.str;

  # Main function to map Rust type to Nix type
  mapRustTypeToNix = rustType: structs: enums:
    let
      cleanType = lib.removePrefix " " (lib.removeSuffix " " rustType);

      # First try primitive types
      primitiveResult = mapPrimitiveType cleanType;
    in
    # If it's a known primitive, use it; otherwise, try complex types
    if primitiveResult != types.str || lib.elem cleanType ["String" "str"] then
      primitiveResult
    else
      mapComplexType cleanType structs enums;

  # Get default value for a type
  getDefaultValue = rustType:
    let
      cleanType = lib.removePrefix " " (lib.removeSuffix " " rustType);
    in
    if cleanType == "bool" then false
    else if lib.elem cleanType ["String" "str"] then ""
    else if lib.elem cleanType ["u8" "u16" "u32" "u64" "usize" "i8" "i16" "i32" "i64" "isize"] then 0
    else if lib.elem cleanType ["f32" "f64"] then 0.0
    else if hasPrefix "Vec" cleanType then []
    else if hasPrefix "Option" cleanType then null
    else if hasPrefix "HashMap" cleanType then {}
    else null;

  # Map the entire configuration structure to Nix types
  mapConfigToNixTypes = configStructs:
    let
      structs = configStructs.structs;
      enums = configStructs.enums;

      # Convert each struct to a Nix type definition
      structTypes = lib.mapAttrs (structName: structDef:
        let
          # Convert field names from snake_case to kebab-case
          fieldTypes = lib.mapAttrs' (fieldName: field:
            let
              kebabName = snakeToKebab fieldName;
            in {
              name = kebabName;
              value = {
                type = mapRustTypeToNix field.type structs enums;
                description = lib.concatStringsSep " " (field.docs or []);
                default = getDefaultValue field.type;
                # Store original name for KDL generation
                _originalName = fieldName;
              };
            }
          ) structDef.fields;
        in {
          inherit fieldTypes;
          docs = structDef.docs or [];
        }
      ) structs;

      # Convert each enum to a Nix enum type
      enumTypes = lib.mapAttrs (enumName: enumDef: {
        variants = []; # Will be populated from actual enum parsing
        docs = enumDef.docs or [];
      }) enums;

    in {
      inherit structTypes enumTypes;
      mainConfig = structTypes.Config or null;
    };

in {
  inherit
    mapConfigToNixTypes
    mapRustTypeToNix
    mapPrimitiveType
    mapComplexType
    getDefaultValue
    extractGenericParams;
}