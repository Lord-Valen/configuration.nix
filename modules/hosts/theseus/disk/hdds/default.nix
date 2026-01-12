{
  flake.modules.host.theseus.disko.devices.disk.hdds = {
    device = "/dev/sdb";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        DATA = import ./_DATA.nix;
      };
    };
  };
}
