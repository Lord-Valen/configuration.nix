rec {
  priority = 1;
  name = "EFI";
  label = name;
  priority = 1;
  size = "1G";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot/efi";
  };
}
