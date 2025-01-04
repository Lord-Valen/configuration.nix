{ inputs, cell }:
let
  inherit (inputs) nixos-hardware disko;
in
{
  hardware = {
    graphics.enable32Bit = true;
    enableRedistributableFirmware = true;
  };

  imports = with nixos-hardware.nixosModules; [
    common-pc-laptop
    common-pc-laptop-hdd
    common-cpu-amd
    disko.nixosModules.disko
    { disko.devices = cell.diskoConfigurations.weepingwillow; }
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
      options = [ "subvol=/@" ];
    };

    "/home" = {
      label = "MAIN";
      fsType = "btrfs";
      options = [ "subvol=/@home" ];
    };

    "/swap" = {
      label = "MAIN";
      fsType = "btrfs";
      options = [ "subvol=/@swap" ];
    };
  };
}
