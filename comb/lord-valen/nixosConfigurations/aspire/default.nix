{
  inputs,
  cell,
}: let
  inherit (inputs) common nixpkgs;
  inherit (cell) hardwareProfiles nixosProfiles nixosSuites homeProfiles homeSuites;
  inherit (nixpkgs) lib;
  hostName = "aspire";
in {
  inherit (common) bee time;
  networking = {inherit hostName;};

  imports = let
    profiles = with nixosProfiles; [
      hardwareProfiles."${hostName}"

      adb
      music
      regreet
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
      home.stateVersion = "23.05";
    };
  };

  services.syncthing.settings.folders = {
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

  system.stateVersion = "23.05";
}
