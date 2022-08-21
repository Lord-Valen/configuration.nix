{ config, lib, pkgs, ... }:

{
  imports = [ ./common.nix ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
