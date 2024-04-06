{
  inputs,
  cell,
  pkgs,
}:
{
  kernelPackages = pkgs.linuxKernel.packageAliases.linux_latest;
  kernel.sysctl."kernel.sysrq" = 244;
}
