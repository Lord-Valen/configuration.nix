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
  hostName = "heracles";
in
{
  networking = {
    inherit hostName;
  };

  specialisation = {
    mine.configuration = {
      imports = with nixosProfiles; [
        monero-mine
        { services.p2pool.mini = true; }
      ];
    };
  };

  imports =
    let
      profiles = with nixosProfiles; [
        cell.bee
        hardwareProfiles."${hostName}"

        adb
        music
        syncthing
        regreet
        hyprland
        geoclue
        zsa
        flatpak
        sunshine
        # TODO: Get an SSD
        # monero

        {
          services.ratbagd.enable = true;
          environment.systemPackages = with pkgs; [ piper ];
        }
      ];
      suites =
        with nixosSuites;
        lib.concatLists [
          desktop
          games
        ];
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
            profiles = with homeProfiles; [
              syncthing
              {
                wayland.windowManager.hyprland.settings.monitor = lib.mkForce [
                  "HDMI-A-1, preferred, 0x0, 1"
                  "DP-1, preferred, 1920x0, 1"
                  ", preferred, auto, 1"
                ];
              }
            ];
            suites =
              with homeSuites;
              lib.concatLists [
                lord-valen
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

  swapDevices = [ { device = "/swap/swapfile"; } ];

  system.stateVersion = "23.05";
}
