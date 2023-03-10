{
  inputs,
  cell,
}: let
  inherit (cell) nixosSuites nixosProfiles hardwareProfiles;
in {
  heracles = {pkgs, ...}: {
    bee = {
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs;
    };

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

    time.timeZone = "Canada/Eastern";

    system.stateVersion = "22.05";

    services.syncthing.folders = {
      "Pythia Photos" = {
        id = "pixel_7_n835-photos";
        path = "/home/lord-valen/Photos";
        devices = ["Pythia"];
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
  };
}
