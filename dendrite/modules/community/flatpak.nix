{
  flake.modules.nixos.flatpak = {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };
}
