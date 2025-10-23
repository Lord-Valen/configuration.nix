{
  flake.modules.hosts.theseus.services.beesd.DATA = {
    spec = "/data";
    extraOptions = [
      "-G"
      "1"
      "-g"
      "5"
    ];
  };
}
