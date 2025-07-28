{
  priority = 1;
  name = "EFI";
  start = "1M";
  end = "1G";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot/efi";
  };
}
