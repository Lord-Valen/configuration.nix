{ inputs, cell }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    cell.hardwareProfiles.base
    common-pc
    common-cpu-intel-sandy-bridge
    # common-gpu-intel # FIXME: The option `hardware.intelgpu.loadInInitrd in hardwareProfiles/nephele is already declared`
  ];
}
