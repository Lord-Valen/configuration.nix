{
  inputs,
  cell,
}: let
  inherit (inputs) nixos-hardware disko;
  defaults = {
    hardware.opengl.driSupport32Bit = true;
    hardware.enableRedistributableFirmware = true;
  };
in {
  weepingwillow = {
    imports = with nixos-hardware.nixosModules; [
      defaults
      common-pc-laptop-hdd
      common-cpu-amd
      disko.nixosModules.disko
      {disko.devices = cell.diskoConfigurations.weepingwillow;}
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

    fileSystems = {
      "/" = {
        label = "MAIN";
        fsType = "btrfs";
        options = ["subvol=/@"];
      };

      "/home" = {
        label = "MAIN";
        fsType = "btrfs";
        options = ["subvol=/@home"];
      };

      "/swap" = {
        label = "MAIN";
        fsType = "btrfs";
        options = ["subvol=/@swap"];
      };
    };
  };
}
