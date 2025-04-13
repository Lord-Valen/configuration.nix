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
    userProfiles
    arionProfiles
    homeProfiles
    homeSuites
    ;
  hostName = "theseus";
in
{
  networking = {
    inherit hostName;
  };

  services.cloudflare-dyndns = {
    enable = true;
    proxied = true;
    domains = [
      "jellyfin.laughing-man.xyz"
      "sonarr.laughing-man.xyz"
      "lidarr.laughing-man.xyz"
      "readarr.laughing-man.xyz"
      "radarr.laughing-man.xyz"
      "deluge.laughing-man.xyz"
      "calibre.laughing-man.xyz"
      "prowlarr.laughing-man.xyz"
    ];
    apiTokenFile = "/data/cloudflare_token.conf";
  };

  services.nginx.virtualHosts."jellyfin.laughing-man.xyz".default = true;

  imports =
    let
      profiles = with nixosProfiles; [
        cell.bee
        hardwareProfiles."${hostName}"

        userProfiles.lord-valen
        userProfiles.nixos

        upgrade
        {
          system.autoUpgrade.rebootWindow = {
            lower = "04:00";
            upper = "06:00";
          };
        }

        gdm
        { services.xserver.displayManager.gdm.autoSuspend = false; }
        gnome
        syncthing
        flatpak
        retroarch
      ];
      suites =
        with nixosSuites;
        lib.concatLists [
          #server
          [ nixosProfiles.nginx ] # FIXME: deduplicate suite profiles
          servarr
          pc
          remote-play
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
      nixos = {
        imports = with homeSuites; base;
        home.stateVersion = "24.05";
      };
      lord-valen = {
        imports =
          let
            profiles = with homeProfiles; [ ];
            suites =
              with homeSuites;
              lib.concatLists [
                base
                cosmetic
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

  services.beesd.filesystems.MAIN = {
    spec = "/";
    extraOptions = [
      "-G"
      "1"
      "-g"
      "5"
    ];
  };

  services.syncthing = {
    user = lib.mkForce "servarr";
    group = lib.mkForce "servarr";
  };
  services.syncthing.settings.folders = {
    "Pythia Bup" = {
      id = "jtafu-4mn0y";
      path = "/data/pythia-bup";
      type = "receiveonly";
      devices = [
        "Heracles"
        "Pythia"
        "Oracle"
      ];
    };
    "Pythia Photos" = {
      id = "pixel_7_n835-photos";
      path = "/data/pythia-photos";
      type = "receiveonly";
      devices = [
        "Heracles"
        "Pythia"
        "Oracle"
      ];
    };
    "Books" = {
      id = "fheng-o2wyn";
      path = "/data/media/books";
      type = "sendreceive";
      devices = [
        "lvAspire"
        "lvHeracles"
        "Pythia"
        "Oracle"
      ];
    };
    "Music" = {
      id = "zfumc-pfy38";
      path = "/data/media/music";
      type = "sendonly";
      devices = [
        "lvAspire"
        "lvHeracles"
        "Pythia"
        "Oracle"
      ];
    };
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  system.stateVersion = "24.05";
}
