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

  services.greetd = {
    enable = true;
    settings.default_session.command = lib.mkForce "${pkgs.cage}/bin/cage -s -m last -- ${pkgs.greetd.regreet}/bin/regreet";
  };
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
}
