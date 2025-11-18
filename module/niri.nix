{ lib, config, pkgs, ... }:

{
  options = {
    programs.niri = {
      enable = lib.mkEnableOption "niri wayland compositor";
      package = lib.mkPackageOption pkgs "niri" {};
      settings = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {};
        description = "Niri configuration settings";
      };
    };
  };

  config = lib.mkIf config.programs.niri.enable {
    home.packages = [ config.programs.niri.package ];

    # Create basic config file for testing
    xdg.configFile."niri/config.kdl".text = "// Auto-generated niri configuration\\n";
  };
}
