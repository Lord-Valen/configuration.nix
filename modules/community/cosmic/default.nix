{
  flake.modules.nixos.cosmic =
    { ... }:
    {
      services.desktopManager.cosmic.enable = true;
    };
}
