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

    kernelModules = ["kvm-intel"];
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
