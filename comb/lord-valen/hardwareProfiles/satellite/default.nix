{ inputs, cell }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    cell.hardwareProfiles.base

    common-pc-laptop
    common-pc-laptop-hdd
    common-cpu-amd
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "ohci_pci"
    "ehci_pci"
    "usb_storage"
    "ums_realtek"
    "sd_mod"
    "sr_mod"
  ];
}
