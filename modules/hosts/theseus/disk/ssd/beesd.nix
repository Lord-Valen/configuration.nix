{
  flake.modules.nixos.theseus.services.beesd.filesystems.MAIN = {
    spec = "/";
    extraOptions = [
      "-G"
      "1"
      "-g"
      "5"
    ];
  };
}
