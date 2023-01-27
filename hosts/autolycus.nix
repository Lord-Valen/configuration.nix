{
  suites,
  profiles,
  ...
}: {
  imports =
    suites.laptop
    ++ (with profiles; [
      audio.music
    ]);

  time.timeZone = "Canada/Eastern";

  system.stateVersion = "22.11";

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd.luks.devices."MAIN".device = "/dev/disk/by-uuid/TODO";
  };

  fileSystems = {
    "/boot/efi" = {
      label = "BOOT";
      fsType = "vfat";
    };

    "/" = {
      encrypted.label = "MAIN";
      device = "/dev/mapper/MAIN";
      fsType = "btrfs";
      options = ["subvol=/@"];
    };

    "/home" = {
      encrypted.label = "MAIN";
      device = "/dev/mapper/MAIN";
      fsType = "btrfs";
      options = ["subdol=/@home"];
    };

    "/swap" = {
      encrypted.label = "MAIN";
      device = "/dev/mapper/MAIN";
      fsType = "btrfs";
      options = ["subvol=/@swap"];
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];
}
