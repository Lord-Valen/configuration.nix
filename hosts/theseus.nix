{
  suites,
  profiles,
  ...
}: {
  imports =
    suites.server
    ++ (with profiles; [
      arion.pihole
      arion.servarr
      syncthing
    ]);

  time.timeZone = "Canada/Eastern";

  system.stateVersion = "22.11";

  services.syncthing = {
    folders = {
      "Oracle Photos" = {
        id = "sm-g950_7ywz-photos";
        path = "/data/oracle-photos";
        devices = ["Oracle"];
      };
      "Pythia Photos" = {
        id = "pixel_7_n835-photos";
        path = "/data/pythia-photos";
        devices = ["Pythia"];
      };
      "books" = {
        id = "fheng-o2wyn";
        path = "/data/media/books";
        type = "sendonly";
        devices = [
          "Oracle"
          "Pythia"
        ];
      };
      "music" = {
        id = "zfumc-pfy38";
        path = "/data/media/music";
        type = "sendonly";
        devices = [
          "Oracle"
          "Pythia"
        ];
      };
    };
  };

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

    kernelModules = ["kvm-intel"];
    kernelParams = [];
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
      kernelModules = [];
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

    "/data" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@data"];
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];

  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
    cpu.intel.updateMicrocode = true;
  };
}
