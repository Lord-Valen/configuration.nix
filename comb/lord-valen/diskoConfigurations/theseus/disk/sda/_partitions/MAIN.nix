rec {
  name = "MAIN";
  label = name;
  device = "/dev/disk/by-label/${label}";
  size = "100%";
  content = {
    type = "btrfs";
    extraArgs = [ "-f" ];
    subvolumes = {
      "@" = {
        mountpoint = "/";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
      "@docker" = {
        mountpoint = "/docker";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
      "@data" = {
        mountpoint = "/data";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
      "@swap" = {
        mountpoint = "/swap";
        swap.swapfile.size = "8GiB";
      };
    };
  };
}
