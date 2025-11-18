{
  description = "Automated NixOS home-manager module generator for niri wayland compositor";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Import our generator
        generator = import ./generator { inherit pkgs; };

        # Fetch niri source
        niriSrc = pkgs.fetchFromGitHub {
          owner = "soulvice";
          repo = "niri";
          rev = "0000000000000000000000000000000000000000"; # This will be updated by GitHub Actions
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # This will be updated by GitHub Actions
        };

        # Generate the home-manager module
        generatedModule = generator.generateNiriModule {
          inherit niriSrc;
        };

        # Generate documentation
        documentation =
          let
            # Parse the configuration for documentation
            configStructs = generator.parser.parseNiriConfig niriSrc;
            nixTypes = generator.typeMapper.mapConfigToNixTypes configStructs;

            # Actions library (simplified for documentation)
            actionsLib = {
              spawn = "spawn";
              spawn_shell = "spawn_shell";
              close_window = "close-window";
              fullscreen_window = "fullscreen-window";
              focus_left = "focus-left";
              focus_right = "focus-right";
              focus_up = "focus-up";
              focus_down = "focus-down";
              move_left = "move-left";
              move_right = "move-right";
              move_up = "move-up";
              move_down = "move-down";
              focus_workspace_next = "focus-workspace-next";
              focus_workspace_previous = "focus-workspace-previous";
              screenshot = "screenshot";
              quit = "quit";
            };

            docs = generator.generateDocs {
              inherit nixTypes actionsLib;
            };
          in
          pkgs.writeText "niri-module-docs.md" docs;
      in
      {
        packages = {
          inherit generator documentation;
          niri-module = generatedModule;
          niri-docs = documentation;
          default = generatedModule;
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

        # Home-manager module output
        homeManagerModules = {
          niri = generatedModule;
          default = generatedModule;
        };

        # For easy importing
        lib = {
          niriModule = generatedModule;
        };
      });
}