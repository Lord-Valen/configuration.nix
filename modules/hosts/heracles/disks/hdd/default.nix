{
  flake.modules.nixos.heracles.disko.devices.disk.sdb = rec {
    device = "/dev/sdb";
    type = "disk";
    name = "disk-sdb-GAME";
    content = {
      type = "btrfs";
      device = "/dev/disk/by-label/${name}";
      extraArgs = [ "-f" ];
      subvolumes = {
        "@" = {
          mountpoint = "/home/lord-valen/Games/hdd";
          mountOptions = [
            "compress=zstd:5"
            "noatime"
            "nofail"
          ];
        };
        ".snapshots/@" = {
          mountpoint = "/home/lord-valen/Games/hdd/.snapshots";
          mountOptions = [
            "noatime"
            "nofail"
          ];
        };
      };
    };
  };
}
