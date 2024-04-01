{ inputs, cell }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    cell.hardwareProfiles.base
    lenovo-thinkpad-t420
  ];

  boot.initrd.availableKernelModules = [ ]; # TODO
}
