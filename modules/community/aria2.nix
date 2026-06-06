{
  den.aspects.aria2.nixos =
    { config, ... }:
    {
      services.aria2 = {
        enable = true;
        settings = {
          enable-rpc = true;
          max-connection-per-server = 16;
          split = 16;
        };
      };
      systemd.tmpfiles.rules = [
        "e ${config.services.aria2.settings.dir} - - - 2w"
      ];
    };
}
