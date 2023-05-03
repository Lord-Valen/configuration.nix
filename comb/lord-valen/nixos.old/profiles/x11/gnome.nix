{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./common.nix];

  services.xserver.desktopManager.gnome.enable = true;
}
