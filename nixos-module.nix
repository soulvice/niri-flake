# NixOS module: provides system-level niri setup (session, portal, keyring, etc.)
# and disables the upstream nixpkgs programs/wayland/niri.nix to avoid option conflicts.
{ config, lib, pkgs, ... }:

let
  cfg = config.programs.niri;
in
{
  disabledModules = [ "programs/wayland/niri.nix" ];

  options.programs.niri = {
    enable = lib.mkEnableOption "Niri, a scrollable-tiling Wayland compositor";

    package = lib.mkPackageOption pkgs "niri" { };

    useNautilus = lib.mkEnableOption "Nautilus as file-chooser for xdg-desktop-portal-gnome" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      environment.systemPackages = [ cfg.package ];

      services.dbus.packages = lib.mkIf cfg.useNautilus [ pkgs.nautilus ];

      services = {
        displayManager.sessionPackages = [ cfg.package ];
        displayManager.defaultSession = lib.mkDefault "niri";
        gnome.gnome-keyring.enable = lib.mkDefault true;
      };

      systemd.packages = [ cfg.package ];

      systemd.user.services.niri = {
        restartIfChanged = false;
        enableDefaultPath = false;
      };

      xdg.portal = {
        enable = lib.mkDefault true;
        config.niri = {
          default = [ "gnome" "gtk" ];
          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.FileChooser" = lib.mkIf (!cfg.useNautilus) "gtk";
          "org.freedesktop.impl.portal.Notification" = "gtk";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        };
        extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      };
    }

    # Base Wayland session requirements (mirrors wayland-session.nix from nixpkgs)
    {
      security.polkit.enable = true;
      security.pam.services.swaylock = { };
      programs.dconf.enable = lib.mkDefault true;
      services.graphical-desktop.enable = true;
      services.xserver.desktopManager.runXdgAutostartIfNone = lib.mkDefault true;
    }
  ]);
}
