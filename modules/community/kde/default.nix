{
  flake.aspects.kde = {
    nixos = {
      xdg.portal.enable = true;

      services.libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };

      services.desktopManager.plasma6.enable = true;
      programs.kdeconnect.enable = true;

      programs.ssh.enableAskPassword = true;
    };
  };
}
