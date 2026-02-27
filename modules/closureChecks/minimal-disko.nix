# The bare minimum config with disko.
# Useful for testing the size of the base module.
{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  closureChecks.minimal-disko = {
    bytes = 1925511400;
    human = "1.8GiB";
    closure = modules.nixos.minimal-disko;
  };

  flake.aspects.minimal-disko.nixos =
    { lib, ... }:
    {
      imports = with modules.nixos; [ disko ];
      disko.devices.disk.sda = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            EFI = {
              priority = 1;
              name = "EFI";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            ROOT = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.limine.enable = true;
      nixpkgs.hostPlatform = "x86_64-linux";
      system.stateVersion = "25.11";
    };
}
