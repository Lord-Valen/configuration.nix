{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  boot.kernelPackages = nixpkgs.linuxKernel.packageAliases.linux_latest;
}
