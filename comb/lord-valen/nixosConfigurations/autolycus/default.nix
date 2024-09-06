{
  inputs,
  cell,
  lib,
}:
let
  inherit (cell)
    hardwareProfiles
    nixosProfiles
    nixosSuites
    homeProfiles
    homeSuites
    ;
  hostName = "autolycus";
in
{
  networking = {
    inherit hostName;
  };

  imports =
    let
      profiles = with nixosProfiles; [
        cell.bee
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
    backupFileExtension = "hm.bkup";
    users = {
      root = {
        imports = [ homeProfiles.shell ];
        home.stateVersion = "24.05";
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
        home.stateVersion = "24.05";
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

  system.stateVersion = "24.05";
}
