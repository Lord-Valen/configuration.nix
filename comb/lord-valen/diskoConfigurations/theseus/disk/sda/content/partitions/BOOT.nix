rec {
  priority = 1;
  name = "BOOT";
  label = name;
  device = "/dev/disk/by-label/${label}";
  start = "1MiB";
  end = "1GiB";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot/efi";
  };
}
