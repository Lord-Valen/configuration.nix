{
  priority = 1;
  name = "BOOT";
  start = "1M";
  end = "1G";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot";
  };
}
