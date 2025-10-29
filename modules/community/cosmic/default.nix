{
  flake.modules.nixos.cosmic =
    { pkgs, ... }:
    {
      services.desktopManager.cosmic.enable = true;
    };
}
