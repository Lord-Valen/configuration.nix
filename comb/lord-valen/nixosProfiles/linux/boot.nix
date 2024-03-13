{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  kernelPackages = nixpkgs.linuxKernel.packageAliases.linux_latest;
  kernel.sysctl."kernel.sysrq" = 244;
}
