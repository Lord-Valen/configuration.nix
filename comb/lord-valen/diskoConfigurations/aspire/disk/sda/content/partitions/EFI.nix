{
  priority = 1;
  name = "EFI";
  start = "1MiB";
  end = "1GiB";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot/efi";
  };
}
