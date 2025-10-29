{
  priority = 1;
  name = "BOOT";
  start = "1MiB";
  end = "1G";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot";
  };
}
