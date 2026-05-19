{
  den.aspects.xanmod.nixos =
    { pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
    };
}
