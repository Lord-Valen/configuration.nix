{ inputs, cell }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    cell.hardwareProfiles.base
    lenovo-thinkpad-t470s
    common-pc-laptop
    common-pc-laptop-ssd
  ];
}
