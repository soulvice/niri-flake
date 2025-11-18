{ lib }:

let
  inherit (lib)
    types
    mkOption
    hasPrefix
    removePrefix
    match
    head
    tail
    length
    isString
    isInt
    isFloat
    isBool
    isList
    isAttrs
    elem
    any
    all
    filter;

  # Color validation for niri Color type
  validateColor = value:
    if !isString value then false
    else
      let
        # Check for hex color (#RGB, #RRGGBB, #RRGGBBAA)
        hexMatch = match "^#([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$" value;

        # Check for CSS color names (simplified list)
        cssColors = [
          "red" "green" "blue" "white" "black" "gray" "grey"
          "yellow" "cyan" "magenta" "orange" "purple" "brown"
          "pink" "lime" "navy" "maroon" "olive" "teal"
          "transparent"
        ];

        # Check for rgb/rgba functions
        rgbMatch = match "^rgba?\\([0-9., ]+\\)$" value;
      in
      hexMatch != null || elem value cssColors || rgbMatch != null;

  # Create a color type with validation
  colorType = types.addCheck types.str validateColor // {
    description = "color (hex, CSS name, or rgb/rgba function)";
    descriptionClass = "noun";
  };

  # FloatOrInt type with bounds checking
  floatOrIntType = min: max:
    let
      validateRange = value:
        if isInt value || isFloat value then
          value >= min && value <= max
        else false;
    in
    types.addCheck (types.either types.int types.float) validateRange // {
      description = "number between ${toString min} and ${toString max}";
      descriptionClass = "noun";
    };

  # Regex validation
  validateRegex = value:
    if !isString value then false
    else
      # Basic regex validation - check for common regex patterns
      # In a full implementation, we would compile the regex to validate it
      builtins.tryEval (builtins.match value "test") != null;

  regexType = types.addCheck types.str validateRegex // {
    description = "regular expression";
    descriptionClass = "noun";
  };

  # Corner radius type - can be single value or list of 1-4 values
  validateCornerRadius = value:
    if isInt value || isFloat value then
      value >= 0
    else if isList value then
      let
        validLength = elem (length value) [1 2 3 4];
        validValues = all (v: (isInt v || isFloat v) && v >= 0) value;
      in
      validLength && validValues
    else false;

  cornerRadiusType = types.addCheck (types.oneOf [
    types.numbers.nonnegative
    (types.listOf types.numbers.nonnegative)
  ]) validateCornerRadius // {
    description = "corner radius (single value or list of 1-4 values)";
    descriptionClass = "noun";
  };

  # Preset size type - Proportion or Fixed
  presetSizeType = types.oneOf [
    (types.addCheck types.float (v: v > 0 && v <= 1) // {
      description = "proportion (0.0-1.0)";
    })
    (types.addCheck types.int (v: v > 0) // {
      description = "fixed size in pixels";
    })
  ] // {
    description = "preset size (proportion 0.0-1.0 or fixed pixels)";
    descriptionClass = "noun";
  };

  # Gradient type
  gradientType = types.submodule {
    options = {
      from = mkOption {
        type = colorType;
        description = "Starting color of the gradient";
      };

      to = mkOption {
        type = colorType;
        description = "Ending color of the gradient";
      };

      angle = mkOption {
        type = types.numbers.between 0 360;
        default = 90;
        description = "Gradient angle in degrees (0-360)";
      };

      relative_to = mkOption {
        type = types.enum ["window" "workspace-view"];
        default = "window";
        description = "What the gradient is relative to";
      };

      color_space = mkOption {
        type = types.enum ["srgb" "srgb-linear" "oklab" "oklch"];
        default = "srgb";
        description = "Color space for interpolation";
      };
    };
  } // {
    description = "color gradient";
    descriptionClass = "noun";
  };

  # Niri-specific enum types
  createEnumType = enumName: variants: types.enum variants // {
    description = "${enumName} (${lib.concatStringsSep ", " variants})";
    descriptionClass = "noun";
  };

  # Common niri enum types
  modKeyType = createEnumType "modifier key" [
    "ctrl" "shift" "alt" "super"
    "iso-level3-shift" "iso-level5-shift"
  ];

  transformType = createEnumType "transform" [
    "normal" "90" "180" "270"
    "flipped" "flipped-90" "flipped-180" "flipped-270"
  ];

  centerFocusedColumnType = createEnumType "center focused column" [
    "never" "always" "on-overflow"
  ];

  columnDisplayType = createEnumType "column display" [
    "normal" "tabbed"
  ];

  accelProfileType = createEnumType "acceleration profile" [
    "adaptive" "flat"
  ];

  clickMethodType = createEnumType "click method" [
    "clickfinger" "button-areas"
  ];

  scrollMethodType = createEnumType "scroll method" [
    "no-scroll" "two-finger" "edge" "on-button-down"
  ];

  tapButtonMapType = createEnumType "tap button map" [
    "left-right-middle" "left-middle-right"
  ];

  trackLayoutType = createEnumType "track layout" [
    "global" "window"
  ];

  # Animation curve types
  animationCurveType = types.oneOf [
    (types.enum ["linear" "ease-out-quad" "ease-out-cubic" "ease-out-expo"])
    (types.submodule {
      options = {
        cubic_bezier = mkOption {
          type = types.listOf (types.numbers.between 0 1);
          description = "Cubic bezier curve parameters [x1, y1, x2, y2]";
        };
      };
    })
  ] // {
    description = "animation curve";
    descriptionClass = "noun";
  };

  # Spring animation parameters
  springParamsType = types.submodule {
    options = {
      damping_ratio = mkOption {
        type = types.numbers.between 0.1 10.0;
        default = 1.0;
        description = "Spring damping ratio (0.1-10.0)";
      };

      stiffness = mkOption {
        type = types.addCheck types.numbers.positive (v: v >= 1);
        default = 800.0;
        description = "Spring stiffness (>= 1)";
      };

      epsilon = mkOption {
        type = types.numbers.between 0.00001 0.1;
        default = 0.0001;
        description = "Spring epsilon (0.00001-0.1)";
      };
    };
  } // {
    description = "spring animation parameters";
    descriptionClass = "noun";
  };

  # Easing animation parameters
  easingParamsType = types.submodule {
    options = {
      duration_ms = mkOption {
        type = types.ints.positive;
        default = 250;
        description = "Animation duration in milliseconds";
      };

      curve = mkOption {
        type = animationCurveType;
        default = "ease-out-cubic";
        description = "Animation curve";
      };
    };
  } // {
    description = "easing animation parameters";
    descriptionClass = "noun";
  };

  # Animation type - can be off, spring, or easing
  animationType = types.oneOf [
    (types.enum ["off"])
    springParamsType
    easingParamsType
  ] // {
    description = "animation (off, spring, or easing)";
    descriptionClass = "noun";
  };

  # Cross-validation functions
  validateOutputReferences = config:
    let
      # Extract output names from outputs configuration
      outputNames = if config.outputs != null && isList config.outputs then
        map (output: output.name or "unknown") config.outputs
      else [];

      # Check window rules for invalid output references
      invalidWindowRules = if config.window_rules != null then
        filter (rule:
          rule ? open_on_output &&
          rule.open_on_output != null &&
          !elem rule.open_on_output outputNames
        ) config.window_rules
      else [];

    in length invalidWindowRules == 0;

  validateWorkspaceReferences = config:
    let
      # Extract workspace names
      workspaceNames = if config.workspaces != null && isList config.workspaces then
        map (ws: ws.name or "unknown") config.workspaces
      else [];

      # Check window rules for invalid workspace references
      invalidWindowRules = if config.window_rules != null then
        filter (rule:
          rule ? open_on_workspace &&
          rule.open_on_workspace != null &&
          !elem rule.open_on_workspace workspaceNames
        ) config.window_rules
      else [];

    in length invalidWindowRules == 0;

  # Create validation assertion for a config
  createConfigAssertion = assertionFunc: message: config: {
    assertion = assertionFunc config;
    inherit message;
  };

  # All cross-validation assertions
  crossValidationAssertions = config: [
    (createConfigAssertion validateOutputReferences
      "Window rules reference non-existent outputs" config)
    (createConfigAssertion validateWorkspaceReferences
      "Window rules reference non-existent workspaces" config)
  ];

in {
  # Export all validation types
  inherit
    colorType
    floatOrIntType
    regexType
    cornerRadiusType
    presetSizeType
    gradientType
    modKeyType
    transformType
    centerFocusedColumnType
    columnDisplayType
    accelProfileType
    clickMethodType
    scrollMethodType
    tapButtonMapType
    trackLayoutType
    animationCurveType
    springParamsType
    easingParamsType
    animationType
    crossValidationAssertions;

  # Validation functions
  inherit
    validateColor
    validateRegex
    validateCornerRadius
    validateOutputReferences
    validateWorkspaceReferences;

  # Utility functions
  inherit
    createEnumType
    createConfigAssertion;
}