{
  inputs,
  cell,
  lib,
}:
let
  inherit (inputs) common;
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
  inherit (common) bee time;
  networking = {
    inherit hostName;
  };

  imports =
    let
      profiles = with nixosProfiles; [
        hardwareProfiles."${hostName}"

        userProfiles.lord-valen
        userProfiles.nixos

        arionProfiles.pihole

        gnome
        games
        servarr
        syncthing
      ];
      suites = with nixosSuites; pc;
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
      nixos = {
        imports = with homeSuites; nixos;
        home.stateVersion = "23.05";
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
        home.stateVersion = "23.05";
      };
    };
  };

  services.flatpak.enable = true;

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
      ];
    };
    "Pythia Photos" = {
      id = "pixel_7_n835-photos";
      path = "/data/pythia-photos";
      type = "receiveonly";
      devices = [
        "Heracles"
        "Pythia"
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
      ];
    };
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  system.stateVersion = "23.05";
}
