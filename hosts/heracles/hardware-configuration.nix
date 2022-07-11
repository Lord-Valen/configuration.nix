{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "ehci_pci"
        "ahci"
        "xhci_pci"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "sr_mod"
      ];
      kernelModules = [ ];
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
  };

  fileSystems = {
    "/boot/efi" = {
      label = "BOOT";
      fsType = "vfat";
    };

    "/" = {
      label = "MAIN";
      fsType = "btrfs";
      options = [ "subvol=/@" ];
    };

    "/swap" = {
      label = "MAIN";
      fsType = "btrfs";
      options = [ "subvol=/@swap" ];
    };

    "/home" = {
      label = "MAIN";
      fsType = "btrfs";
      options = [ "subvol=/@home" ];
    };

    "/docker" = {
      label = "MAIN";
      fsType = "btrfs";
      options = [ "subvol=/@docker" ];
    };

    "/data" = {
      label = "DATA";
      fsType = "btrfs";
      options = [ "subvol=/@" ];
    };

    "/home/lord-valen/games" = {
      label = "GAME";
      fsType = "btrfs";
      options = [ "subvol=/@" ];
    };
  };

  swapDevices = [{ device = "/swap/swapfile"; }];
  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
