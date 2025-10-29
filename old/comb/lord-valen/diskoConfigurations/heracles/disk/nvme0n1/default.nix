rec {
  device = "/dev/nvme0n1";
  type = "disk";
  name = "disk-nvme0n1-GAME";
  content = {
    type = "btrfs";
    device = "/dev/disk/by-label/${name}";
    extraArgs = [ "-f" ];
    subvolumes = {
      "@" = {
        mountpoint = "/home/lord-valen/Games/nvme";
        mountOptions = [
          "noatime"
          "compress=no"
        ];
      };
      ".snapshots/@" = {
        mountpoint = "/home/lord-valen/Games/nvme/.snapshots";
        mountOptions = [
          "noatime"
        ];
      };
    };
  };
}
