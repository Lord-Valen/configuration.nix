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
    homeProfiles
    homeSuites
    ;
  hostName = "nephele";
in
{
  networking = {
    inherit hostName;
  };

  system.autoUpgrade = {
    allowReboot = true;
    rebootWindow = {
      lower = "02:00";
      upper = "04:00";
    };
  };

  imports =
    let
      profiles = with nixosProfiles; [
        cell.bee
        hardwareProfiles."${hostName}"

        userProfiles.lord-valen

        upgrade
        grocy
        # home-assistant
      ];
      suites = with nixosSuites; lib.concatLists [ server ];
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
        home.stateVersion = "24.05";
      };
      lord-valen = {
        imports =
          let
            profiles = with homeProfiles; [
              shell
              gpg
              git
              helix
              less
            ];
            suites = with homeSuites; lib.concatLists [ ];
          in
          lib.concatLists [
            profiles
            suites
          ];
        home.stateVersion = "24.05";
      };
    };
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  system.stateVersion = "24.05";
}
