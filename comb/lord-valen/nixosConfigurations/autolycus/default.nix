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
      ];
      suites = with nixosSuites; laptop;
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
