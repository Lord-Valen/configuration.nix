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

  imports =
    let
      profiles = with nixosProfiles; [
        cell.bee
        hardwareProfiles."${hostName}"

        userProfiles.lord-valen
        userProfiles.nixos

        gdm
        { services.xserver.displayManager.gdm.autoSuspend = false; }
        gnome
        servarr
        {
          services.nginx.virtualHosts.jellyfin.default = true;
        }
        syncthing
        flatpak
        retroarch
      ];
      suites =
        with nixosSuites;
        lib.concatLists [
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
        imports = homeSuites.base ++ [ homeProfiles.shell ];
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
            suites = with homeSuites; lib.concatLists [ lord-valen ];
          in
          lib.concatLists [
            profiles
            suites
          ];
        home.stateVersion = "24.05";
      };
    };
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
