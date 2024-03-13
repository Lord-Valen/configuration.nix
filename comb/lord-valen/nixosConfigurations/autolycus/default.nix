{ inputs, cell }:
let
  inherit (inputs) common nixpkgs;
  inherit (cell)
    hardwareProfiles
    nixosProfiles
    nixosSuites
    homeProfiles
    homeSuites
    ;
  inherit (nixpkgs) lib;
  hostName = "autolycus";
in
{
  inherit (common) bee time;
  networking = {
    inherit hostName;
  };

  imports =
    let
      profiles = with nixosProfiles; [
        hardwareProfiles."${hostName}"

        pipewire
        music
        hyprland
      ];
      suites = with nixosSuites; laptop;
    in
    lib.concatLists [
      profiles
      suites
    ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      root = {
        imports = [ homeProfiles.shell ];
        home.stateVersion = "23.11";
      };
      lord-valen = {
        imports =
          let
            profiles = with homeProfiles; [ { services.random-background.enable = true; } ];
            suites =
              with homeSuites;
              lib.concatLists [
                lord-valen
                laptop
                xmonad
                music
              ];
          in
          lib.concatLists [
            profiles
            suites
          ];
        home.stateVersion = "23.05";
      };
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
      options = [
        "subvol=/@"
        "noatime"
        "compress=zstd"
      ];
    };

    "/home" = {
      encrypted.label = "MAIN";
      device = "/dev/mapper/MAIN";
      fsType = "btrfs";
      options = [
        "subdol=/@home"
        "noatime"
        "compress=zstd"
      ];
    };

    "/swap" = {
      encrypted.label = "MAIN";
      device = "/dev/mapper/MAIN";
      fsType = "btrfs";
      options = [
        "subvol=/@swap"
        "noatime"
        "compress=zstd"
      ];
    };
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  system.stateVersion = "23.05";
}
