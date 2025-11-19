{ pkgs }:

let
  lib = pkgs.lib;

  # Import our generator modules
  parser = import ./parser.nix { inherit lib; };
  typeMapper = import ./type-mapper.nix { inherit lib; };
  kdlGenerator = import ./kdl-generator.nix { inherit lib; };
  moduleGenerator = import ./module-generator.nix { inherit lib; };
  docsGenerator = import ./docs-generator.nix { inherit lib; };
  enhancedDocsGenerator = import ./enhanced-docs-generator.nix { inherit lib; };

in {
  # Main function to generate the niri home-manager module
  generateNiriModule = { niriSrc }:
    let
      # Parse the niri configuration from source
      configStructs = parser.parseNiriConfig niriSrc;

      # Map Rust types to Nix types
      nixTypes = typeMapper.mapConfigToNixTypes configStructs;

      # Generate the home-manager module
      module = moduleGenerator.generateModule {
        inherit nixTypes;
        kdlGenerator = kdlGenerator;
      };
    in
    module;

  # Generate documentation (legacy)
  generateDocs = { nixTypes, actionsLib ? {}, moduleOptions ? {} }:
    docsGenerator.generateModuleDocs {
      inherit nixTypes actionsLib moduleOptions;
    };

  # Generate comprehensive documentation
  generateComprehensiveDocs = { nixTypes ? {}, actionsLib ? {}, moduleOptions ? {} }:
    enhancedDocsGenerator.generateComprehensiveDocs {
      inherit nixTypes actionsLib moduleOptions;
    };

  # Expose individual components for testing
  inherit parser typeMapper kdlGenerator moduleGenerator docsGenerator enhancedDocsGenerator;
}