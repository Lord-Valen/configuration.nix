{
  inputs,
  cell,
}: let
  inherit (cell) nixosSuites nixosProfiles homeSuites homeProfiles;

  bee = {
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs;
    home = inputs.home-manager;
  };
  time.timeZone = "Canada/Eastern";
in
  cell.lib.mkNixosConfigurations cell {
    aspire = {
      inherit bee time;

      imports = with nixosSuites;
      with nixosProfiles;
        [
          pipewire
          music
          regreet
          hyprland
          games
          geoclue
        ]
        ++ laptop;

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users.lord-valen = {
          imports = with homeSuites;
            lord-valen
            ++ laptop
            ++ hyprland
            ++ music;
          home.stateVersion = "22.05";
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

        "/swap" = {
          label = "MAIN";
          fsType = "btrfs";
          options = ["subvol=/@swap"];
        };
      };

      swapDevices = [{device = "/swap/swapfile";}];

      system.stateVersion = "22.11";
    };

    autolycus = {
      inherit bee time;

      imports = with nixosSuites;
      with nixosProfiles;
        [
          pipewire
          music
          x11.xmonad
        ]
        ++ laptop;

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users.lord-valen = {
          imports = with homeSuites;
            lord-valen
            ++ laptop
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

    heracles = {
      inherit bee time;

      imports = with nixosSuites;
      with nixosProfiles;
        [
          pipewire
          music
          games
          vm
          syncthing
          # monero.common
          regreet
          hyprland
          geoclue

          # cell.nixosModules.p2pool
          # monero.mine
          # {
          #   services.p2pool.mini = true;
          # }
        ]
        ++ desktop;

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users.lord-valen = {
          imports = with homeSuites;
            lord-valen
            ++ hyprland
            ++ music
            ++ [
              {
                xdg.configFile."hypr/monitor.conf".text = cell.lib.mkForce ''
                  monitor = HDMI-A-1, preferred, 0x0, 1
                  monitor = DP-1, preferred, 1920x0, 1
                  monitor = , preferred, auto, 1
                '';
              }
            ];
          home.stateVersion = "23.05";
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

      system.stateVersion = "23.05";
    };

    satellite = {
      inherit bee time;

      imports = with nixosProfiles;
      with nixosSuites;
        [x11.xmonad]
        ++ laptop;

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users.lord-valen = {
          imports = with homeSuites;
            lord-valen
            ++ laptop
            ++ xmonad;
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

    theseus = {
      inherit bee time;

      imports = with nixosSuites;
      with nixosProfiles;
        [
          inputs.arion.nixosModules.arion

          arion.pihole
          arion.servarr
          syncthing
          x11.gnome
          x11.xmonad
          users.lord-valen
          users.nixos
          games
        ]
        ++ pc;

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users = {
          lord-valen = {
            imports = with homeProfiles;
            with homeSuites;
              [
                wallpaper.x11
              ]
              ++ lord-valen
              ++ xmonad;
            home.stateVersion = "22.11";
          };
          nixos = {
            imports = with homeSuites; nixos;
            home.stateVersion = "22.11";
          };
        };
      };

      services.flatpak.enable = true;

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
