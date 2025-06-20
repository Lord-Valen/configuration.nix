{ cell, lib }:
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
        musnix
        syncthing
        geoclue
        zsa
        flatpak
        sunshine
        wireshark
        # regreet
        gdm
        # hyprland
        # cosmic
        gnome
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
          btrfs
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
              gnome
              notes
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
                full
                #hyprland
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

  services.beesd.filesystems = {
    MAIN = {
      spec = "/";
      extraOptions = [
        "-G"
        "1"
        "-g"
        "5"
      ];
    };
    games = {
      spec = "/home/lord-valen/Games";
      extraOptions = [
        "-G"
        "1"
        "-g"
        "5"
      ];
    };
  };

  services.snapper.configs =
    lib.mapAttrs
      (
        _: v:
        {
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
        }
        // v
      )
      {
        root = {
          SUBVOLUME = "/";
        };
        home = {
          SUBVOLUME = "/home";
        };
        games = {
          SUBVOLUME = "/home/lord-valen/Games";
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

  system.stateVersion = "24.05";
}
