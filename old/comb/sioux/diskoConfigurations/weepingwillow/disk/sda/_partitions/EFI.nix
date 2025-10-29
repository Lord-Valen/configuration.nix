{
  name = "EFI";
  size = "1G";
  type = "EF00";
  priority = 2;
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot";
    mountOptions = [ "umask=0077" ];
  };
}
