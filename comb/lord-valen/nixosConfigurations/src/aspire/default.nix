{
  inputs,
  cell,
}: let
  inherit (inputs) common;
  inherit (cell) lib nixosSuites nixosProfiles homeSuites homeProfiles;
in {
  inherit (common) bee time;

  imports = let
    profiles = with nixosProfiles; [
      adb
      music
      displayManager.regreet
      hyprland
      games
      geoclue
      syncthing
    ];
    suites = with nixosSuites; laptop;
  in
    lib.concatLists [profiles suites];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.lord-valen = {
      imports = let
        profiles = with homeProfiles; [];
        suites = with homeSuites;
          lib.concatLists [
            lord-valen
            laptop
            hyprland
            music
          ];
      in
        lib.concatLists [profiles suites];
      home.stateVersion = "22.05";
    };
  };

  services.syncthing.folders = {
    "Books" = {
      id = "fheng-o2wyn";
      path = "~/books";
      devices = [
        "Heracles"
        "Theseus"
        "Pythia"
      ];
    };
    "Music" = {
      id = "zfumc-pfy38";
      path = "~/music";
      devices = [
        "Heracles"
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

    "/swap" = {
      label = "MAIN";
      fsType = "btrfs";
      options = ["subvol=/@swap" "noatime" "compress=zstd"];
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];

  system.stateVersion = "22.11";
}
