{
  inputs,
  cell,
  pkgs,
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
  hostName = "aspire";
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

        adb
        regreet
        hyprland
        geoclue
        syncthing
        kubo
        zsa
        music
        gnome

        { programs.nm-applet.enable = true; }
        {
          services.udev.extraRules = ''
            KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
            # THQ uDraw Game Tablet for PS3
            SUBSYSTEM=="hidraw", ATTRS{idVendor}=="20d6", ATTRS{idProduct}=="cb17", MODE="0666"
            SUBSYSTEM=="usb", ATTRS{idVendor}=="20d6", ATTRS{idProduct}=="cb17", MODE="0666"
          '';
        }
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
        home.stateVersion = "23.05";
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

  system.stateVersion = "23.05";
}
