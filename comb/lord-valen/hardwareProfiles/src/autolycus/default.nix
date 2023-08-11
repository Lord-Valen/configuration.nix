{
  inputs,
  cell,
}: let
  inherit (inputs) common nixos-hardware;
in {
  imports = with nixos-hardware.nixosModules; [
    lenovo-thinkpad-t420
  ];

  inherit (common) hardware;

  boot.initrd.availableKernelModules = []; # TODO
}
