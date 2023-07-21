{
  inputs,
  cell,
}: let
  inherit (inputs) common;
  inherit (cell) lib nixosProfiles nixosSuites homeProfiles homeSuites;
in {
  inherit (common) bee time;

  imports = with nixosProfiles;
  with nixosSuites;
    [x11.xmonad]
    ++ laptop;

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
            xmonad
          ];
      in
        lib.concatLists [profiles suites];
      home.stateVersion = "22.05";
    };
  };

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
      enableCryptodisk = true;
    };

    initrd = {
      secrets."/crypto_keyfile.bin" = null;
      luks.devices = {
        "luks-97a51f6e-16a9-488f-a23f-affd64965a85" = {
          device = "/dev/disk/by-uuid/97a51f6e-16a9-488f-a23f-affd64965a85";
          keyFile = "/crypto_keyfile.bin";
        };
        # Enable swap on luks
        "luks-66cbab88-e395-45bd-bb1e-78fb065c623a" = {
          device = "/dev/disk/by-uuid/66cbab88-e395-45bd-bb1e-78fb065c623a";
          keyFile = "/crypto_keyfile.bin";
        };
      };
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/56bab247-0cd4-489f-8f6a-2336b3940182";
    fsType = "ext4";
  };

  swapDevices = [{device = "/dev/disk/by-uuid/5b455084-e717-4ded-88c2-9714031ccad0";}];

  system.stateVersion = "22.05";
}
