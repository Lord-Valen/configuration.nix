{ inputs, cell }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    cell.hardwareProfiles.base
    common-pc
    common-cpu-amd-pstate
    common-gpu-amd
  ];

  services.xserver.xrandrHeads = [
    "HDMI-1"
    "DP-1"
  ];
}
