{
  flake.modules.nixos.xanmod =
    { pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
    };
}
