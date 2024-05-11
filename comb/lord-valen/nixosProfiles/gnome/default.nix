{
  xdg.portal.enable = true;

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
  };
}
