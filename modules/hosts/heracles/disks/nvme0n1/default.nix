{
  flake.modules.host.heracles.disko.devices.disk.nvme0n1 = {
    device = "/dev/nvme0n1";
    type = "disk";
    name = "disk-nvme0n1-GAME";
    content = {
      type = "btrfs";
      extraArgs = [ "-f" ];
      subvolumes = {
        "@" = {
          mountpoint = "/home/lord-valen/Games/nvme";
          mountOptions = [
            "noatime"
            "compress=no"
            "nofail"
          ];
        };
        ".snapshots/@" = {
          mountpoint = "/home/lord-valen/Games/nvme/.snapshots";
          mountOptions = [
            "noatime"
            "nofail"
          ];
        };
      };
    };
  };
}
