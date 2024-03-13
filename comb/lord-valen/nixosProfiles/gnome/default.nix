{ inputs, cell }:
{
  services.xserver.desktopManager.gnome.enable = true;

  xdg.portal.enable = true;

  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
}
