{ suites, profiles, ... }:

{
  imports = suites.desktop
    ++ (with profiles; [ latex games.steam tidal arion.servarr vm syncthing ]);

  time.timeZone = "Canada/Eastern";

  system.stateVersion = "22.05";

  boot = {
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

    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "radeon.si_support=0"
      "amdgpu.si_support=1"
      "radeon.cik_support=0"
      "amdgpu.cik_support=1"
    ];
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
      kernelModules = [ "amdgpu" ];
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

    "/swap" = {
      label = "MAIN";
      fsType = "btrfs";
      options = [ "subvol=/@swap" ];
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

  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
    cpu.intel.updateMicrocode = true;
  };
}
