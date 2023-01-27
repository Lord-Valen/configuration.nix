{
  suites,
  profiles,
  ...
}: {
  imports =
    suites.desktop
    ++ (with profiles; [
      audio.music
      games.heroic
      games.lutris
      games.steam
      vm
      syncthing
    ]);

  time.timeZone = "Canada/Eastern";

  system.stateVersion = "22.05";

  services.syncthing.folders = {
    "Pythia Photos" = {
      id = "pixel_7_n835-photos";
      path = "/home/lord-valen/Photos";
      devices = ["Pythia"];
    };
  };

  services.xserver.xrandrHeads = [
    "HDMI-A-0"
    "DisplayPort-0"
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    kernelModules = ["kvm_amd"];
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
      kernelModules = ["amdgpu"];
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
      options = ["subvol=/@"];
    };

    "/home" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@home"];
    };

    "/docker" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@docker"];
    };

    "/swap" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@swap"];
    };

    "/home/lord-valen/games" = {
      label = "GAME";
      fsType = "btrfs";
      options = ["subvol=/@"];
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];

  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
    cpu.amd.updateMicrocode = true;
  };
}
