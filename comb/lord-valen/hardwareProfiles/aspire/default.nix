{
  inputs,
  cell,
}: let
  inherit (inputs) common nixos-hardware;
  inherit (common) hardware;
in {
  imports = with nixos-hardware.nixosModules; [
    common-pc-laptop-hdd
    common-cpu-amd
    common-gpu-amd
  ];

  services.blueman.enable = true;
  hardware =
    hardware
    // {
      bluetooth = {
        enable = true;
        powerOnBoot = false;
      };
    };

  boot = {
    kernelModules = ["kvm-amd"];
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "ehci_pci"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
  };
}
