{ config, lib, pkgs, ... }:

{
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [ brave xmobar rofi kitty trayer ];

  fonts.fonts = with pkgs; [ fira-code font-awesome ];

  services = {
    xserver = {
      displayManager.lightdm.enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.d/xmonad.hs;
      };
    };
  };
}
