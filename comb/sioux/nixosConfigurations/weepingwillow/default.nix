{
  inputs,
  cell,
  pkgs,
  lib,
}:
let
  # FIXME: attribute 'pkgs' missing
  pkgs = inputs.nixpkgs;
  inherit (inputs) common;
  inherit (inputs.cells.lord-valen)
    nixosProfiles
    nixosSuites
    homeSuites
    homeProfiles
    ;
  inherit (cell) hardwareProfiles;
  hostName = "weepingwillow";
in
{
  inherit (common) bee time;
  networking = {
    inherit hostName;
  };

  users.users = {
    root.shell = lib.mkForce pkgs.shadow;
    sioux = {
      initialHashedPassword = "$y$j9T$1ttrJXMNjeH62Or9EOGfG/$pdm3JxpOroaC5BaqDN/79xKEvlUXW5fjBMGKPTFqeyA";
      isNormalUser = true;
      createHome = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };

  imports =
    let
      profiles = with nixosProfiles; [
        hardwareProfiles."${hostName}"

        lightdm
        gnome
      ];
      suites = with nixosSuites; lib.concatLists [ pc ];
    in
    lib.concatLists [
      profiles
      suites
    ];

  home-manager = {
    useUserPackages = true;
    users.sioux = {
      imports =
        let
          profiles = with homeProfiles; [
            {
              home.packages = with pkgs; [
                bottles
                ungoogled-chromium
                localsend
                transmission-gtk
                strawberry
              ];
            }
            { services.syncthing.enable = true; }
            {
              xdg = {
                enable = true;
                userDirs.enable = true;
              };
            }
          ];
          suites = with homeSuites; lib.concatLists [ ];
        in
        lib.concatLists [
          profiles
          suites
        ];

      home.stateVersion = "23.05";
    };
  };

  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
    };
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  system.stateVersion = "23.05";
}
