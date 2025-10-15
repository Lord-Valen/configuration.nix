{
  flake.modules.hosts.heracles.disko.devices.disk.sdb = rec {
    device = "/dev/sdb";
    type = "disk";
    name = "disk-sdb-GAME";
    content = {
      type = "btrfs";
      device = "/dev/disk/by-label/${name}";
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
}
