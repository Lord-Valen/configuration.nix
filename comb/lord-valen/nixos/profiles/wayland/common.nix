{
  pkgs,
  lib,
  ...
}: {
  programs = {
    regreet = {
      enable = true;
      settings.background = {
        path = ../../../home/profiles/wallpaper/wallpaper.d/ouroboros_by_chunlo_dcltl6k.jpg;
        fit = "Fill";
      };
    };
    gnupg.agent.pinentryFlavor = "gtk2";
  };
  services = {
    greetd.enable = true;
    xserver.displayManager.lightdm.enable = lib.mkForce false;
  };
}
