{
  flake.modules.nixos.gdm = {
    services.displayManager.enable = true;
    services.xserver.displayManager.gdm.enable = true;
  };
}
