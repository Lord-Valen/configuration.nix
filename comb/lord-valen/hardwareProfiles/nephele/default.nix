{ inputs, cell }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    cell.hardwareProfiles.base
    common-pc
    common-cpu-intel
    common-gpu-intel-sandy-bridge
  ];
}
