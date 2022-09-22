{ config, lib, pkgs, ... }:

{
  imports = [ ./common.nix ];

  environment.systemPackages = [
    pkgs.brave
    pkgs.xmobar
    pkgs.rofi
    pkgs.kitty
    pkgs.trayer
    pkgs.flameshot
  ];

  fonts.fonts = [ pkgs.fira-code pkgs.font-awesome ];

  services = {
    xserver = {
      displayManager.lightdm.enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        enableConfiguredRecompile = true;
        config = ./xmonad.d/xmonad.hs;
      };
    };
  };
}
