{
  inputs,
  cell,
}: let
  inherit (inputs) common;
  inherit (cell) lib nixosProfiles nixosSuites homeProfiles homeSuites;
in {
  inherit (common) bee time;

  imports = let
    profiles = with nixosProfiles; [
      adb
      music
      games
      vm
      syncthing
      displayManager.regreet
      hyprland
      geoclue

      # monero.mine
      # {services.p2pool.mini = true;}
    ];
    suites = with nixosSuites; desktop;
  in
    lib.concatLists [profiles suites];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.lord-valen = {
      imports = let
        profiles = with homeProfiles; [
          {
            xdg.configFile."hypr/monitor.conf".text = cell.lib.mkForce ''
              monitor = HDMI-A-1, preferred, 0x0, 1
              monitor = DP-1, preferred, 1920x0, 1
              monitor = , preferred, auto, 1
            '';
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

  services.syncthing.folders = {
    "Pythia Bup" = {
      id = "jtafu-4mn0y";
      path = "~/pythia-bup";
      devices = [
        "Theseus"
        "Pythia"
      ];
    };
    "Pythia Photos" = {
      id = "pixel_7_n835-photos";
      path = "~/pythia-photos";
      devices = [
        "Theseus"
        "Pythia"
      ];
    };
    "Books" = {
      id = "fhend-o2wyn";
      path = "~/books";
      devices = [
        # "Aspire"
        "Theseus"
        "Pythia"
      ];
    };
    "Music" = {
      id = "zfumc-pfy38";
      path = "~/music";
      devices = [
        # "Aspire"
        "Theseus"
        "Pythia"
      ];
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
