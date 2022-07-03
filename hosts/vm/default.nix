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
      xmonad.enable = true;
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Canada/Eastern";

  system.stateVersion = "22.05";
}
