# The bare minimum config with disko.
# Useful for testing the size of the base module.
{ inputs, ... }:
{
  closureChecks.minimal-disko.closure =
    { ... }:
    {
      imports = [ inputs.disko.nixosModules.default ];
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
