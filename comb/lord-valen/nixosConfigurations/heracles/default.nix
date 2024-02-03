{
  inputs,
  cell,
}: let
  inherit (inputs) common nixpkgs;
  inherit (cell) hardwareProfiles nixosProfiles nixosSuites homeProfiles homeSuites;
  inherit (nixpkgs) lib;
  hostName = "heracles";
in {
  inherit (common) bee time;
  networking = {inherit hostName;};

  specialisation = {
    mine.configuration = {
      imports = with nixosProfiles; [
        monero-mine
        {services.p2pool.mini = true;}
      ];
    };
  };

  imports = let
    profiles = with nixosProfiles; [
      hardwareProfiles."${hostName}"

      adb
      music
      games
      syncthing
      regreet
      hyprland
      geoclue
      zsa
      # Get an SSD
      # monero

      {
        services.ratbagd.enable = true;
      }
    ];
    suites = with nixosSuites; desktop;
  in
    lib.concatLists [profiles suites];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      root = {
        imports = [homeProfiles.shell];
        home.stateVersion = "23.11";
      };
      lord-valen = {
        imports = let
          profiles = with homeProfiles; [
            syncthing
            {
              wayland.windowManager.hyprland.settings.monitor = lib.mkForce [
                "HDMI-A-1, preferred, 0x0, 1"
                "DP-1, preferred, 1920x0, 1"
                ", preferred, auto, 1"
              ];
            }
          ];
          suites = with homeSuites;
            lib.concatLists [
              lord-valen
              hyprland
              music
            ];
        in
          lib.concatLists [profiles suites];
        home.stateVersion = "23.05";
      };
    };
  };

  services.syncthing.settings.folders = {
    "Pythia Bup" = {
      id = "jtafu-4mn0y";
      path = "~/pythia-bup";
      type = "receiveonly";
      devices = [
        "Theseus"
        "Pythia"
      ];
    };
    "Pythia Photos" = {
      id = "pixel_7_n835-photos";
      path = "~/pythia-photos";
      type = "receiveonly";
      devices = [
        "Theseus"
        "Pythia"
      ];
    };
  };

  # TODO: disko
  fileSystems = {
    "/boot/efi" = {
      label = "BOOT";
      fsType = "vfat";
    };

    "/" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@" "noatime" "compress=zstd"];
    };

    "/home" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@home" "noatime" "compress=zstd"];
    };

    "/docker" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@docker" "noatime" "compress=zstd"];
    };

    "/swap" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@swap" "noatime" "compress=zstd"];
    };

    "/home/lord-valen/games" = {
      label = "GAME";
      fsType = "btrfs";
      options = ["subvol=/@" "noatime" "compress=zstd"];
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];

  system.stateVersion = "23.05";
}
