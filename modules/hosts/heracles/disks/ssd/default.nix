{
  flake.modules.hosts.heracles.disko.devices.disk.sda = {
    device = "/dev/sda";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        EFI = import ./_BOOT.nix;
        MAIN = import ./_MAIN.nix;
      };
    };
  };
}
