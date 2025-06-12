{
  device = "/dev/sdb";
  type = "disk";
  content = {
    type = "gpt";
    partitions.GAME = rec {
      name = "GAME";
      label = name;
      device = "/dev/disk/by-label/${label}";
      size = "100%";
      content = {
        type = "btrfs";
        extraArgs = [ "-f" ];
        subvolumes = {
          "@" = {
            mountpoint = "/home/lord-valen/Games";
            mountOptions = [
              "noatime"
              "compress=zstd"
            ];
          };
          ".snapshots/@" = {
            mountpoint = "/home/lord-valen/Games/.snapshots";
            mountOptions = [
              "noatime"
              "compress=zstd"
            ];
          };
        };
      };
    };
  };
}
