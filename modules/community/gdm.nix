{
  flake.modules.nixos.gdm = {
    services.displayManager.enable = true;
    services.displayManager.gdm.enable = true;
  };
}
