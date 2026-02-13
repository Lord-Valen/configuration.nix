{
  name = "THESEUSMAIN";
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
      ".snapshots/@" = {
        mountpoint = "/.snapshots";
        mountOptions = [
          "noatime"
          "nofail"
        ];
      };
      "@home" = {
        mountpoint = "/home";
        mountOptions = [
          "noatime"
        ];
      };
      ".snapshots/@home" = {
        mountpoint = "/home/.snapshots";
        mountOptions = [
          "noatime"
          "nofail"
        ];
      };
      "@nix" = {
        mountpoint = "/nix";
        mountOptions = [
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
