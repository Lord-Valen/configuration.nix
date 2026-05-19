{
  den.aspects.theseus.nixos.disko.devices.disk.hdds = {
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
