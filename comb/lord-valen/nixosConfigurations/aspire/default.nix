{
  inputs,
  cell,
}: let
  inherit (inputs) common nixpkgs;
  inherit (cell) hardwareProfiles nixosProfiles nixosSuites homeProfiles homeSuites;
  inherit (nixpkgs) lib;
  hostName = "aspire";
in {
  inherit (common) bee time;
  networking = {inherit hostName;};

  imports = let
    profiles = with nixosProfiles; [
      hardwareProfiles."${hostName}"

      adb
      regreet
      hyprland
      geoclue
      syncthing
      kubo

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
    lib.concatLists [profiles suites];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.lord-valen = {
      imports = let
        profiles = with homeProfiles; [];
        suites = with homeSuites;
          lib.concatLists [
            lord-valen
            laptop
            hyprland
            music
          ];
      in
        lib.concatLists [profiles suites];
      home.stateVersion = "23.05";
    };
  };

  services.syncthing.settings.folders = {
    "Books" = {
      id = "fheng-o2wyn";
      path = "~/books";
      devices = [
        "Heracles"
        "Theseus"
        "Pythia"
      ];
    };
    "Music" = {
      id = "zfumc-pfy38";
      path = "~/music";
      devices = [
        "Heracles"
        "Theseus"
        "Pythia"
      ];
    };
  };

  system.stateVersion = "23.05";
}
