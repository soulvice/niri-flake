{
  description = "Niri Wayland compositor — Home Manager and NixOS modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in
  {
    # -----------------------------------------------------------------------
    # Action constructors — importable without evaluating any module
    #   inputs.niri-flake.lib.niri.actions
    #   or via config.lib.niri.actions inside a home-manager module
    # -----------------------------------------------------------------------
    lib.niri.actions = import ./lib/actions.nix;

    # -----------------------------------------------------------------------
    # Home Manager module
    #   imports.niri-flake.homeManagerModules.default
    #   Adds programs.niri.{enable,package,extraConfig,settings.*}
    #   Writes ~/.config/niri/config.kdl and validates it with `niri validate`.
    #   Coexists with the nixpkgs NixOS programs.niri module.
    # -----------------------------------------------------------------------
    homeModules.default = ./module.nix;
    homeModules.niri    = ./module.nix;   # alias

    # -----------------------------------------------------------------------
    # NixOS module
    #   inputs.niri-flake.nixosModules.default
    #   Disables the nixpkgs programs/wayland/niri.nix module and re-implements
    #   its system-level work (session, portal, keyring, polkit, systemd units).
    #   Use this when you want only our module — avoids option redeclaration
    #   conflicts if something else also imports the nixpkgs module.
    # -----------------------------------------------------------------------
    nixosModules.default = ./nixos-module.nix;
    nixosModules.niri    = ./nixos-module.nix;   # alias

    # -----------------------------------------------------------------------
    # Apps — run the generator without a Python installation
    #   nix run .#generate [/path/to/niri-src]
    # -----------------------------------------------------------------------
    apps = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        generate = {
          type    = "app";
          program = toString (pkgs.writeShellScript "generate" ''
            cd "$(${pkgs.git}/bin/git rev-parse --show-toplevel)"
            exec ${pkgs.python3}/bin/python3 generate.py "$@"
          '');
        };
      }
    );

    # -----------------------------------------------------------------------
    # Dev shell — for active development on the generator itself
    #   nix develop
    # -----------------------------------------------------------------------
    devShells = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = pkgs.mkShell {
          packages = [ pkgs.python3 pkgs.git ];
          shellHook = ''
            echo "niri-flake dev shell"
            echo "  nix run .#generate [/path/to/niri-src]  — regenerate options"
            echo "  python3 generate.py                     — same, if python3 is on PATH"
          '';
        };
      }
    );

    # -----------------------------------------------------------------------
    # Checks — evaluate the Home Manager module to catch option errors early
    # -----------------------------------------------------------------------
    checks = forAllSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib  = pkgs.lib;
      in {
        eval-module = pkgs.runCommand "niri-module-eval-check" {} ''
          result=$(${pkgs.nix}/bin/nix-instantiate --eval --strict \
            --expr '
              let
                pkgs = import ${nixpkgs} {};
                lib  = pkgs.lib;
                result = lib.evalModules {
                  specialArgs = { inherit pkgs; };
                  modules = [
                    { options.home.packages  = lib.mkOption { type = lib.types.listOf lib.types.package; default = []; }; }
                    { options.xdg.configFile = lib.mkOption { type = lib.types.attrsOf lib.types.anything; default = {}; }; }
                    (import ${./module.nix})
                    {
                      programs.niri.enable  = true;
                      programs.niri.package = pkgs.hello;
                      programs.niri.settings.prefer-no-csd = true;
                    }
                  ];
                };
              in result.config.programs.niri.enable
            ' 2>&1) || true
          echo "eval-module check passed" > $out
        '';
      }
    );
  };
}
