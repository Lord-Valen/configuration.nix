{
  inputs,
  cell,
  lib,
  pkgs,
}:
{
  kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  kernel.sysctl."kernel.sysrq" = 244;
}
