{
  flake.modules.hosts.theseus.services.beesd.MAIN = {
    spec = "/";
    extraOptions = [
      "-G"
      "1"
      "-g"
      "5"
    ];
  };
}
