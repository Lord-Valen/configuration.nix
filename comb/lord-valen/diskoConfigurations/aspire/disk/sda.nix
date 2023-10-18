{
  device = "/dev/sda";
  type = "disk";
  content = {
    type = "table";
    format = "gpt";
    partitions = [
      {
        name = "EFI";
        start = "0MiB";
        end = "1GiB";
        bootable = true;
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot/efi";
        };
      }
      {
        name = "MAIN";
        start = "1GiB";
        end = "100%";
        content = {
          type = "btrfs";
          extraArgs = ["-f"];
          subvolumes = {
            "@" = {
              mountpoint = "/";
              mountOptions = ["compress=zstd" "noatime"];
            };

            "@home" = {
              mountpoint = "/home";
              mountOptions = ["compress=zstd" "noatime"];
            };

            "@nix" = {
              mountpoint = "/nix";
              mountOptions = ["compress=zstd" "noatime"];
            };

            "@swap" = {
              mountpoint = "/swap";
              mountOptions = ["noatime"];
            };
          };
        };
      }
    ];
  };
}
