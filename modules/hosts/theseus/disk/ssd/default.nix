{
  flake.modules.nixos.theseus.disko.devices.disk.ssd = {
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
