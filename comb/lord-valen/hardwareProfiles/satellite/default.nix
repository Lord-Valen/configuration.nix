{
  inputs,
  cell,
}: let
  inherit (inputs) common nixos-hardware;
in {
  imports = with nixos-hardware.nixosModules; [
    common
    common-pc-laptop-hdd
    common-cpu-amd
  ];

  inherit (common) hardware;

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
