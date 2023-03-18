{
  inputs,
  cell,
}: let
  inherit (cell) nixosSuites nixosProfiles homeSuites hardwareProfiles;

  bee = {
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs;
    home = inputs.home-manager;
  };
  time.timeZone = "Canada/Eastern";
in {
  autolycus = {...}: {
    inherit bee time;

    imports = with nixosSuites;
    with nixosProfiles;
    with hardwareProfiles;
      [
        autolycus

        audio.music
      ]
      ++ laptop;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.lord-valen = {
        imports = with homeSuites;
          lord-valen
          ++ xmonad
          ++ music;
        home.stateVersion = "22.11";
      };
    };

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

    system.stateVersion = "22.11";
  };

  heracles = {...}: {
    networking.hostName = "heracles";

    inherit bee time;

    imports = with nixosSuites;
    with nixosProfiles;
    with hardwareProfiles;
      [
        heracles

        audio.music
        games.heroic
        games.lutris
        games.steam
        vm
        syncthing
        monero.common
      ]
      ++ desktop;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.lord-valen = {
        imports = with homeSuites;
          lord-valen
          ++ xmonad
          ++ music;
        home.stateVersion = "22.05";
      };
    };

    services.syncthing.folders = {
      "Pythia Photos" = {
        id = "pixel_7_n835-photos";
        path = "/home/lord-valen/Photos";
        devices = ["Pythia"];
      };
    };

    boot.loader = {
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

    system.stateVersion = "22.05";
  };

  satellite = {...}: {
    networking.hostName = "satellite";

    inherit bee time;

    imports = with nixosSuites;
    with nixosProfiles;
    with hardwareProfiles;
      [
        bee.home.nixosModules.home-manager
        satellite
      ]
      ++ laptop;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.lord-valen = {
        imports = with homeSuites; lord-valen ++ xmonad;
        home.stateVersion = "22.05";
      };
    };

    boot = {
      loader.grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
        enableCryptodisk = true;
      };

      initrd = {
        secrets."/crypto_keyfile.bin" = null;
        luks.devices = {
          "luks-97a51f6e-16a9-488f-a23f-affd64965a85" = {
            device = "/dev/disk/by-uuid/97a51f6e-16a9-488f-a23f-affd64965a85";
            keyFile = "/crypto_keyfile.bin";
          };
          # Enable swap on luks
          "luks-66cbab88-e395-45bd-bb1e-78fb065c623a" = {
            device = "/dev/disk/by-uuid/66cbab88-e395-45bd-bb1e-78fb065c623a";
            keyFile = "/crypto_keyfile.bin";
          };
        };
      };
    };

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/56bab247-0cd4-489f-8f6a-2336b3940182";
      fsType = "ext4";
    };

    swapDevices = [{device = "/dev/disk/by-uuid/5b455084-e717-4ded-88c2-9714031ccad0";}];

    system.stateVersion = "22.05";
  };

  theseus = {...}: {
    networking.hostName = "theseus";

    inherit bee time;

    imports = with nixosSuites;
    with nixosProfiles;
    with hardwareProfiles;
      [
        inputs.arion.nixosModules.arion
        bee.home.nixosModules.home-manager
        theseus

        arion.pihole
        arion.servarr
        syncthing
        x11.gnome
        x11.xmonad
        users.lord-valen
        users.nixos
      ]
      ++ pc;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users = {
        lord-valen = {
          imports = with homeSuites; lord-valen ++ xmonad;
          home.stateVersion = "22.11";
        };
        nixos = {
          imports = with homeSuites; nixos;
          home.stateVersion = "22.11";
        };
      };
    };

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

    boot.loader = {
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

    system.stateVersion = "22.11";
  };
}
