{
  inputs,
  cell,
  lib,
  pkgs,
}:
{
  kernelPackages = lib.mkOverride 999 pkgs.linuxPackages_lqx;
}
