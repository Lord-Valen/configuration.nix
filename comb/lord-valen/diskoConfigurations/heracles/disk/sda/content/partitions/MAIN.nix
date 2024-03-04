rec {
  name = "MAIN";
  label = name;
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
          "noatime"
          "compress=zstd"
        ];
      };

      "@docker" = {
        mountpoint = "/docker";
        mountOptions = [
          "noatime"
          "compress=zstd"
        ];
      };

      "@swap" = {
        mountpoint = "/swap";
        mountOptions = [
          "noatime"
          "compress=zstd"
        ];
      };
    };
  };
}
