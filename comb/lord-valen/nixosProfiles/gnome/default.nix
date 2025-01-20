{
  xdg.portal.enable = true;

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  services.xserver.desktopManager.gnome.enable = true;
}
