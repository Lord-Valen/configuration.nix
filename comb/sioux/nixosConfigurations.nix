{
  inputs,
  cell,
}: let
  inherit (inputs.cells.lord-valen) nixosSuites nixosProfiles homeSuites homeProfiles;
  inherit (inputs) nixpkgs;

  bee = {
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs;
    home = inputs.home-manager;
  };
  time.timeZone = "Canada/Eastern";
in
  cell.lib.mkNixosConfigurations cell {
    weepingwillow = {
      inherit bee time;

      imports = with nixosSuites;
      with nixosProfiles;
        [
          lightdm
          gnome
          {
            users.users.sioux = {
              initialHashedPassword = "$y$j9T$1ttrJXMNjeH62Or9EOGfG/$pdm3JxpOroaC5BaqDN/79xKEvlUXW5fjBMGKPTFqeyA";
              isNormalUser = true;
              createHome = true;
              extraGroups = ["networkmanager" "wheel"];
            };
          }
        ]
        ++ laptop;

      home-manager = {
        useUserPackages = true;
        users.sioux = {
          imports = with homeSuites;
          with homeProfiles; [
            {
              home.packages = with nixpkgs; [
                bottles
                ungoogled-chromium
              ];
            }
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

      swapDevices = [{device = "/swap/swapfile";}];

      system.stateVersion = "23.05";
    };
  }
