{
  inputs,
  cell,
}: let
  inherit (inputs) common nixos-hardware;
in {
  imports = with nixos-hardware.nixosModules; [
    common-pc
    common-cpu-intel-sandy-bridge
    common-gpu-amd-southern-islands
  ];

  inherit (common) hardware;
}
