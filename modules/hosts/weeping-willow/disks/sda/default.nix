{
  flake.modules.hosts.weeping-willow.disko.devices.disk.sda =
    { lib, ... }:
    {
      device = "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          BOOT = lib.importTOML ./_BOOT.toml;
          EFI = lib.importTOML ./_EFI.toml;
          MAIN = lib.importTOML ./_MAIN.toml;
        };
      };
    };
}
