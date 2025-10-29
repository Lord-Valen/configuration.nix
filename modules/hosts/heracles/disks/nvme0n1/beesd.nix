{
  flake.modules.hosts.heracles.services.beesd.filesystems.games_nvme = {
    spec = "/home/lord-valen/Games/nvme";
    extraOptions = [
      "-G"
      "1"
      "-g"
      "5"
    ];
  };
}
