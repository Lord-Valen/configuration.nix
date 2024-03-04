{
  device = "/dev/sdb";
  type = "disk";
  content = {
    type = "gpt";
    partitions.GAME = {
      name = "GAME";
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
