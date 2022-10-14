{ suites, profiles, ... }:

{
  imports = suites.laptop;

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
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
      };
    };

    initrd = {
      luks.devices = {
        "MAIN" = {
          device = "/dev/disk/by-label/MAIN";
        };
      };
    };
  };

  fileSystems = {
    "/boot/efi" = {
      label = "BOOT";
      fsType = "vfat";
    };

    "/" = {
      encrypted.label = "MAIN";
      fsType = "btrfs";
      options = [ "subvol=/@" ];
    };

    "/home" = {
      encrypted.label = "MAIN";
      fsType = "btrfs";
      options = [ "subdol=/@home" ];
    };

    "/swap" = {
      label = "MAIN";
      fsType = "btrfs";
      options = [ "subvol=/@swap" ];
    };
  };

  swapDevices = [{ device = "/swap/swapfile"; }];
}
