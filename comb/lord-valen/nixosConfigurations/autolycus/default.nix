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
        adb
        regreet
        gnome
        hyprland
        geoclue
        syncthing
        kubo
        zsa
        music
        flatpak

        heroic
        steam

        { programs.nm-applet.enable = true; }
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
            profiles = with homeProfiles; [ syncthing ];
            suites =
              with homeSuites;
              lib.concatLists [
                lord-valen
                laptop
                hyprland
                music
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

  services.syncthing.settings.folders = {
    "Pythia Bup" = {
      id = "jtafu-4mn0y";
      path = "~/pythia-bup";
      type = "receiveonly";
      devices = [
        "Heracles"
        "Theseus"
        "Aspire"
        "Pythia"
        "Oracle"
      ];
    };
    "Pythia Photos" = {
      id = "pixel_7_n835-photos";
      path = "~/pythia-photos";
      type = "receiveonly";
      devices = [
        "Theseus"
        "Aspire"
        "Oracle"
      ];
    };
  };

  system.stateVersion = "24.11";
}
