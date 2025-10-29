{
  name = "THESEUSDATA";
  size = "100%";
  content = {
    type = "btrfs";
    extraArgs = [ "-f" ];
    subvolumes = {
      "@data" = {
        mountpoint = "/data";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
      ".snapshots/@data" = {
        mountpoint = "/data/.snapshots";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
    };
  };
}
