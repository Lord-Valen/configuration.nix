{lib, ...}: {
  programs = {
    regreet = {
      enable = true;
      settings.background = {
        path = ./wallpaper.jpg;
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
