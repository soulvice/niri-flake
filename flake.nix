{
  description = "Automated NixOS home-manager module generator for niri wayland compositor";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      # Use the static module we already have (system independent)
      homeManagerModules = {
        niri = import ./module/niri.nix;
        default = import ./module/niri.nix;
      };

      # Make the module easily testable
      nixosModules.niri = import ./module/niri.nix;
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Import our generator
        generator = import ./generator { inherit pkgs; };

        # Fetch niri source (using a recent commit for testing)
        niriSrc = pkgs.fetchFromGitHub {
          owner = "soulvice";
          repo = "niri";
          rev = "dfcbbbb03071cadf3fd9bbb0903ead364a839412"; # Recent commit for testing
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Placeholder - will be updated by workflow
        };

        # Generate the home-manager module
        generatedModule = generator.generateNiriModule {
          inherit niriSrc;
        };

        # Create a derivation containing the generated module file
        moduleDerivation =
          let
            # Parse the configuration and generate types
            configStructs = generator.parser.parseNiriConfig niriSrc;
            nixTypes = generator.typeMapper.mapConfigToNixTypes configStructs;

            # Generate the module file as a string
            moduleFileContent = generator.generateModuleFile {
              inherit nixTypes niriSrc;
            };
          in
          pkgs.runCommand "niri-module" {} ''
            mkdir -p $out
            cat > $out/default.nix << 'EOF'
${moduleFileContent}
EOF
          '';

        # Generate documentation
        documentation =
          let
            # Parse the configuration for documentation
            configStructs = generator.parser.parseNiriConfig niriSrc;
            nixTypes = generator.typeMapper.mapConfigToNixTypes configStructs;

            # Use shared actions library
            actionsLib = import ./generator/actions-lib.nix;

            # Extract niri version info
            niriInfo = {
              commit = "dfcbbbb03071cadf3fd9bbb0903ead364a839412";
              sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
              repository = "soulvice/niri";
            };

            docs = generator.generateComprehensiveDocs {
              inherit nixTypes actionsLib;
              moduleOptions = niriInfo;
            };
          in
          pkgs.writeText "niri-module-docs.md" docs;
      in
      {
        # Make generator functions available
        lib.niri-generator = generator;

        packages = {
          # Create a generator package that contains the generator functions
          generator = pkgs.runCommand "niri-generator" { } ''
            mkdir -p $out/lib $out/bin

            # Copy generator library files
            cp -r ${./generator}/* $out/lib/

            # Create a simple wrapper script for CLI usage
            cat > $out/bin/niri-generator << 'EOF'
            #!/usr/bin/env bash
            echo "Niri home-manager module generator"
            echo "This package contains the generator library functions."
            echo "Available at: $out/lib/"
            EOF
            chmod +x $out/bin/niri-generator
          '';

          niri-module = moduleDerivation;
          niri-docs = documentation;
          default = moduleDerivation;
        };

        # Development shell
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixfmt
            statix
            deadnix
          ];

          shellHook = ''
            echo "Niri Home-Manager Module Generator Development Environment"
            echo "Available commands:"
            echo "  nix build .#generator    - Build the generator"
            echo "  nix build .#niri-module  - Generate the niri module"
            echo "  nix build .#niri-docs    - Generate markdown documentation"
            echo "  ./run-tests.sh           - Run the test suite"
            echo ""
            echo "Generated files:"
            echo "  module/niri.nix         - Home-manager module"
            echo "  docs/MODULE_OPTIONS.md  - Comprehensive documentation"
          '';
        };

        # For easy importing
        lib = {
          niriModule = generatedModule;
        };
      });
}