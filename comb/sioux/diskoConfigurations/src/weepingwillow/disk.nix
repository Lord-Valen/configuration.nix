{
  inputs,
  cell,
}: {
  sda = {
    device = "/dev/sda";
    type = "disk";
    content = {
      type = "table";
      format = "msdos";
      partitions = [
        {
          name = "MAIN";
          start = "1MB";
          end = "100%";
          bootable = true;
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
  };
}
