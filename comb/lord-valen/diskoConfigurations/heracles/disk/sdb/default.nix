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
        subvolumes."@" = {
          mountpoint = "/home/lord-valen/games";
          mountOptions = [
            "noatime"
            "compress=zstd"
          ];
        };
      };
    };
  };
}
