{
  flake.modules.hosts.theseus.disko.devices.disk.sda = {
    device = "/dev/sda";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        BOOT = import ./_BOOT.nix;
        MAIN = import ./_MAIN.nix;
      };
    };
  };
}
