{
  den.aspects.servarr.nixos =
    { config, ... }:
    {
      services.navidrome = {
        enable = true;
        settings = {
          BaseUrl = "https://navidrome.laughing-man.xyz";
          DefaultShareExpiration = "168h";
          EnableInsightsCollector = true;
          EnableSharing = true;
          MusicFolder = "/data/media/music";
          PrometheusEnabled = config.services.prometheus.enable;
          Scanner = {
            Schedule = "0 0 * * *";
            PurgeMissing = "full";
          };
        };
      };
    };
}
