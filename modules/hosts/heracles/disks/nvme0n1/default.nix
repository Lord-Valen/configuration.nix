{
  flake.modules.nixos.heracles.disko.devices.disk.nvme0n1 = {
    device = "/dev/nvme0n1";
    type = "disk";
    name = "disk-nvme0n1-GAME";
    content = {
      type = "btrfs";
      extraArgs = [ "-f" ];
      subvolumes = {
        "@" = {
          mountpoint = "/home/lord-valen/Games/nvme";
          mountOptions = [
            "compress=zstd:-1"
            "noatime"
            "nofail"
          ];
        };
        ".snapshots/@" = {
          mountpoint = "/home/lord-valen/Games/nvme/.snapshots";
          mountOptions = [
            "noatime"
            "nofail"
          ];
        };
      };
    };
  };
}
