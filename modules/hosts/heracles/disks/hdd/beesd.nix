{
  flake.modules.hosts.heracles.services.beesd.filesystems.games = {
    spec = "/home/lord-valen/Games";
    extraOptions = [
      "-G"
      "1"
      "-g"
      "5"
    ];
  };
}
