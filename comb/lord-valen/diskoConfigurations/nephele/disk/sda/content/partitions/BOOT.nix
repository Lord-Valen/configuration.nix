{
  priority = 1;
  name = "EFI";
  size = "1G";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot/efi";
  };
}
