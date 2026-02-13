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
          "compress=zstd:5"
          "noatime"
          "nofail"
        ];
      };
      ".snapshots/@data" = {
        mountpoint = "/data/.snapshots";
        mountOptions = [
          "noatime"
          "nofail"
        ];
      };
    };
  };
}
