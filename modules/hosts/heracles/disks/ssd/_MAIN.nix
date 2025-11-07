{
  name = "MAIN";
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

      ".snapshots/@home" = {
        mountpoint = "/home/.snapshots";
        mountOptions = [
          "compress=zstd"
          "noatime"
          "nofail"
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
        mountOptions = [ "nofail" ];
        swap = {
          swapfile.size = "16G";
        };
      };
    };
  };
}
