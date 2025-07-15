{
  flake.modules.nixos.gdbm = {
    services.displayManager.enable = true;
    services.xserver.displayManager.gdm.enable = true;
  };
}
