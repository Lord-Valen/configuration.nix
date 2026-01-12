{
  flake.modules.host.weeping-willow.disko.devices.disk.sda =
    { lib, ... }:
    {
      device = "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          EFI = lib.importTOML ./_EFI.toml;
          MAIN = lib.importTOML ./_MAIN.toml;
        };
      };
    };
}
