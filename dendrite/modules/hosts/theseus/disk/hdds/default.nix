{
  flake.modules.hosts.theseus.disko.devices.disk.sdb = {
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
