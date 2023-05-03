{pkgs, ...}: {
  imports = [./common.nix];

  environment.systemPackages = [
    pkgs.xmobar
    pkgs.rofi
    pkgs.kitty
    pkgs.trayer
    pkgs.flameshot
  ];

  fonts.fonts = [pkgs.fira-code pkgs.font-awesome];

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad.d/xmonad.hs;
  };
}