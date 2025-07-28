{
  flake.modules.nixos.liquorix =
    { pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_lqx;
    };
}
