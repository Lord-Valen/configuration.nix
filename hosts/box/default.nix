{ config, pkgs, lib, hm, ... }:

with lib;

{
  imports = [ ./hardware-configuration.nix ];

  modules = {
    emacs = {
      enable = true;
      doom.enable = true;
    };
    pipewire.enable = true;
    x11 = {
      enable = true;
      gnome.enable = true;
    };
    networking.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Canada/Eastern";

  system.stateVersion = "22.05";
}
