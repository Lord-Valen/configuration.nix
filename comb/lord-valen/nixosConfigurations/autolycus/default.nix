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
        gdm
        gnome
        geoclue
        syncthing
        music
        flatpak
        tablet
        heroic
        steam
        adb
      ];
      suites =
        with nixosSuites;
        lib.concatLists [
          btrfs
          laptop
        ];
    in
    lib.concatLists [
      [
        cell.bee
        hardwareProfiles."${hostName}"
      ]
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
            profiles = with homeProfiles; [
              notes
              syncthing
              gnome
            ];
            suites =
              with homeSuites;
              lib.concatLists [
                laptop
                full
              ];
          in
          lib.concatLists [
            profiles
            suites
          ];
        home.stateVersion = "24.11";
      };
    };
  };

  services.beesd.filesystems.MAIN = {
    spec = "/";
    extraOptions = [
      "-G"
      "1"
      "-g"
      "5"
    ];
  };

  services.snapper.configs = {
    home = {
      SUBVOLUME = "/home";
      QGROUP = "1/5400";
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      EMPTY_PRE_POST_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY = "5-10";
      TIMELINE_LIMIT_DAILY = "2-5";
      TIMELINE_LIMIT_WEEKLY = "1-4";
      TIMELINE_LIMIT_MONTHLY = "0-2";
      TIMELINE_LIMIT_QUARTERLY = "0-1";
      TIMELINE_LIMIT_YEARLY = "0-1";
    };
  };

  services.syncthing.settings.folders = {
    "Pythia Bup" = {
      id = "jtafu-4mn0y";
      path = "~/pythia-bup";
      type = "receiveonly";
      devices = [
        "Heracles"
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

  system.stateVersion = "24.11";
}
