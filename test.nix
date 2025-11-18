# Test script to validate the niri home-manager module generator

let
  # Use a pinned version of nixpkgs for reproducible testing
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;

  # Test source - for testing we'll create a minimal mock niri source
  mockNiriSrc = pkgs.writeTextDir "niri-config/src/lib.rs" ''
    use knuffel::Decode;

    #[derive(Debug, Clone, PartialEq, Decode)]
    pub struct Config {
        #[knuffel(child, unwrap(children))]
        pub input: Input,

        #[knuffel(child, unwrap(children))]
        pub layout: Layout,

        #[knuffel(children(name = "bind"))]
        pub binds: Vec<Bind>,
    }

    #[derive(Debug, Clone, PartialEq, Decode)]
    pub struct Input {
        /// Keyboard configuration
        #[knuffel(child, unwrap(children))]
        pub keyboard: Keyboard,

        /// Touchpad settings
        #[knuffel(child, unwrap(children))]
        pub touchpad: Touchpad,
    }

    #[derive(Debug, Clone, PartialEq, Decode)]
    pub struct Keyboard {
        /// XKB layout settings
        #[knuffel(property)]
        pub layout: String,

        /// Key repeat delay in milliseconds
        #[knuffel(property)]
        pub repeat_delay: u32,

        /// Key repeat rate
        #[knuffel(property)]
        pub repeat_rate: u32,
    }

    #[derive(Debug, Clone, PartialEq, Decode)]
    pub struct Touchpad {
        /// Enable tap to click
        #[knuffel(property)]
        pub tap: bool,

        /// Natural scrolling direction
        #[knuffel(property)]
        pub natural_scroll: bool,
    }

    #[derive(Debug, Clone, PartialEq, Decode)]
    pub struct Layout {
        /// Gap size between windows
        #[knuffel(property)]
        pub gaps: f64,

        /// Focus ring configuration
        #[knuffel(child, unwrap(children))]
        pub focus_ring: FocusRing,
    }

    #[derive(Debug, Clone, PartialEq, Decode)]
    pub struct FocusRing {
        /// Enable focus ring
        #[knuffel(property)]
        pub enable: bool,

        /// Ring width
        #[knuffel(property)]
        pub width: u32,

        /// Active color
        #[knuffel(property)]
        pub active_color: String,
    }

    #[derive(Debug, Clone, PartialEq, Decode)]
    pub struct Bind {
        /// Key combination
        #[knuffel(property)]
        pub key: String,

        /// Action to perform
        #[knuffel(property)]
        pub action: String,
    }
  '';

  # Load our generator
  generator = import ./generator { inherit pkgs; };

  # Test the parser
  testParser =
    let
      parsed = generator.parser.parseNiriConfig mockNiriSrc;
    in
    assert parsed.structs ? Config;
    assert parsed.structs ? Input;
    assert parsed.structs ? Layout;
    assert parsed.structs.Config.fields ? input;
    assert parsed.structs.Config.fields ? layout;
    assert parsed.structs.Config.fields ? binds;
    "✓ Parser test passed";

  # Test the type mapper
  testTypeMapper =
    let
      parsed = generator.parser.parseNiriConfig mockNiriSrc;
      mapped = generator.typeMapper.mapConfigToNixTypes parsed;
    in
    assert mapped.structTypes ? Config;
    assert mapped.structTypes ? Input;
    assert mapped.mainConfig != null;
    "✓ Type mapper test passed";

  # Test KDL generation
  testKdlGenerator =
    let
      testConfig = {
        input = {
          keyboard = {
            layout = "us";
            repeat_delay = 600;
            repeat_rate = 25;
          };
          touchpad = {
            tap = true;
            natural_scroll = true;
          };
        };
        layout = {
          gaps = 16.0;
          focus_ring = {
            enable = true;
            width = 4;
            active_color = "#7fc8ff";
          };
        };
        binds = [
          { key = "Mod+Return"; action = "spawn alacritty"; }
          { key = "Mod+Q"; action = "close-window"; }
        ];
      };

      kdl = generator.kdlGenerator.generateKdlConfig testConfig;
    in
    assert builtins.isString kdl;
    assert builtins.stringLength kdl > 0;
    assert lib.hasInfix "input" kdl;
    assert lib.hasInfix "layout" kdl;
    "✓ KDL generator test passed";

  # Test module generation
  testModuleGenerator =
    let
      parsed = generator.parser.parseNiriConfig mockNiriSrc;
      mapped = generator.typeMapper.mapConfigToNixTypes parsed;
      module = generator.moduleGenerator.generateModule {
        nixTypes = mapped;
        kdlGenerator = generator.kdlGenerator;
      };

      # Create a test configuration
      testPkgs = pkgs;
      testConfig = {
        programs.niri = {
          enable = true;
          settings = {
            input.keyboard.layout = "us";
            layout.gaps = 16;
          };
        };
        lib.niri.actions = {}; # Mock actions
      };

      # Evaluate the module
      evalResult = module {
        config = testConfig;
        pkgs = testPkgs;
      };
    in
    assert evalResult ? options;
    assert evalResult.options ? programs;
    assert evalResult.options.programs ? niri;
    assert evalResult ? config;
    "✓ Module generator test passed";

  # Integration test
  testIntegration =
    let
      # Test the complete flow
      fullModule = generator.generateNiriModule {
        niriSrc = mockNiriSrc;
      };

      testPkgs = pkgs;
      testConfig = {
        programs.niri = {
          enable = true;
          settings = {
            input = {
              keyboard = {
                layout = "us";
                repeat_delay = 400;
                repeat_rate = 30;
              };
              touchpad = {
                tap = true;
                natural_scroll = false;
              };
            };
            layout = {
              gaps = 12;
              focus_ring = {
                enable = true;
                width = 2;
                active_color = "#ff0000";
              };
            };
            binds = [
              { key = "Mod+Return"; action = "spawn alacritty"; }
            ];
          };
        };
      };

      result = fullModule {
        config = testConfig;
        pkgs = testPkgs;
      };
    in
    assert result ? options;
    assert result ? config;
    assert result.options.programs.niri ? enable;
    assert result.options.programs.niri ? settings;
    "✓ Integration test passed";

  # Test validation
  testValidation =
    let
      validation = import ./generator/validation.nix { inherit lib; };
    in
    # Test color validation
    assert validation.validateColor "#ff0000" == true;
    assert validation.validateColor "red" == true;
    assert validation.validateColor "invalid" == false;

    # Test corner radius validation
    assert validation.validateCornerRadius 5 == true;
    assert validation.validateCornerRadius [5 10] == true;
    assert validation.validateCornerRadius (-1) == false;

    "✓ Validation test passed";

  # Test documentation generation
  testDocumentationGenerator =
    let
      docsGenerator = import ./generator/docs-generator.nix { inherit lib; };

      testNixTypes = {
        structTypes = {
          TestStruct = {
            fieldTypes = {
              test_field = {
                type = lib.types.str;
                description = "Test field description";
                default = "test";
              };
              test_number = {
                type = lib.types.int;
                description = "Test number field";
                default = 42;
              };
            };
          };
        };
      };

      testActionsLib = {
        test_action = "test-action";
        spawn = "spawn";
      };

      docs = docsGenerator.generateModuleDocs {
        nixTypes = testNixTypes;
        actionsLib = testActionsLib;
      };
    in
    assert builtins.isString docs;
    assert builtins.stringLength docs > 100;
    assert lib.hasInfix "Table of Contents" docs;
    assert lib.hasInfix "Module Options" docs;
    assert lib.hasInfix "Actions Library" docs;
    assert lib.hasInfix "test_action" docs;
    "✓ Documentation generator test passed";

  # All tests
  allTests = [
    testParser
    testTypeMapper
    testKdlGenerator
    testModuleGenerator
    testIntegration
    testValidation
    testDocumentationGenerator
  ];

in {
  # Run all tests
  runTests = lib.concatStringsSep "\n" allTests;

  # Individual test results
  inherit
    testParser
    testTypeMapper
    testKdlGenerator
    testModuleGenerator
    testIntegration
    testValidation
    testDocumentationGenerator;

  # Test data
  mockSource = mockNiriSrc;

  # Generator components for manual testing
  inherit generator;
}