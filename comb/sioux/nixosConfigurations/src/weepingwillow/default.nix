{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs common;
  inherit (inputs.cells.lord-valen) nixosSuites nixosProfiles homeSuites homeProfiles;

  inherit (cell) lib;
in {
  inherit (common) bee time;

  imports = let
    profiles = with nixosProfiles; [
      displayManager.lightdm
      gnome
      {
        programs.kdeconnect.enable = true;
        users.users.sioux = {
          initialHashedPassword = "$y$j9T$1ttrJXMNjeH62Or9EOGfG/$pdm3JxpOroaC5BaqDN/79xKEvlUXW5fjBMGKPTFqeyA";
          isNormalUser = true;
          createHome = true;
          extraGroups = ["networkmanager" "wheel"];
        };
      }
    ];
    suites = with nixosSuites; lib.concatLists [pc];
  in
    lib.concatLists [profiles suites];

  home-manager = {
    useUserPackages = true;
    users.sioux = {
      imports = let
        profiles = with homeProfiles; [
          {
            home.packages = with nixpkgs; [
              bottles
              ungoogled-chromium
            ];
          }
        ];
        suites = with homeSuites; lib.concatLists [];
      in
        lib.concatLists [profiles suites];

      home.stateVersion = "23.05";
    };
  };

  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];

  system.stateVersion = "23.05";
}
