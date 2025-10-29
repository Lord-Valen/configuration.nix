{
  flake.modules.hosts.theseus.services.beesd.filesystems.DATA = {
    spec = "/data";
    extraOptions = [
      "-G"
      "1"
      "-g"
      "5"
    ];
  };
}
