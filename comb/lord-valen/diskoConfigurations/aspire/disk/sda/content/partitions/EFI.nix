rec {
  priority = 1;
  name = "EFI";
  label = name;
  start = "1MiB";
  end = "1GiB";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot/efi";
  };
}
