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
      # FIXME: Why do I need to use nixosProfiles for arion?!
      nixosProfiles.arion.pihole
      nixosProfiles.arion.servarr
      syncthing
      gnome
      x11.xmonad
      users.lord-valen
      users.nixos
      games
    ];
    suites = with nixosSuites; pc;
  in
    lib.concatLists [profiles suites];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      lord-valen = {
        imports = let
          profiles = with homeProfiles; [
            wallpaper.x11
          ];
          suites = with homeSuites;
            lib.concatLists [
              lord-valen
              xmonad
            ];
        in
          lib.concatLists [profiles suites];
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
      "Pythia Bup" = {
        id = "jtafu-4mn0y";
        path = "/data/pythia-bup";
        devices = [
          "Heracles"
          "Pythia"
        ];
      };
      "Pythia Photos" = {
        id = "pixel_7_n835-photos";
        path = "/data/pythia-photos";
        devices = [
          "Heracles"
          "Pythia"
        ];
      };
      "Books" = {
        id = "fheng-o2wyn";
        path = "/data/media/books";
        type = "sendonly";
        devices = [
          "Heracles"
          # "Aspire"
          "Pythia"
        ];
      };
      "Music" = {
        id = "zfumc-pfy38";
        path = "/data/media/music";
        type = "sendonly";
        devices = [
          "Heracles"
          # "Aspire"
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
      options = ["subvol=/@" "noatime" "compress=zstd"];
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

    "/data" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@data" "noatime" "compress=zstd"];
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];

  system.stateVersion = "22.11";
}
