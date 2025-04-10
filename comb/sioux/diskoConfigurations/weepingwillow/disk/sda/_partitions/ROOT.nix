{
  name = "ROOT";
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
      "@home" = {
        mountpoint = "/home";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
      "@nix" = {
        mountpoint = "/nix";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
      "@swap" = {
        mountpoint = "/swap";
        swap.swapfile.size = "8G";
      };
    };
  };
}
