{ inputs, cell }:
let
  inherit (inputs) common nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    common-pc
    common-cpu-amd-pstate
    common-gpu-amd
  ];

  inherit (common) hardware;

  services.xserver.xrandrHeads = [
    "HDMI-1"
    "DP-1"
  ];
}
