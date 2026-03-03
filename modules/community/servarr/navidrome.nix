{
  flake.modules.nixos.servarr =
    { config, lib, ... }:
    let
      port = config.services.navidrome.settings.Port or 4553;
    in
    {
      services = {
        cloudflare-dyndns.domains = [ "navidrome.laughing-man.xyz" ];
        caddy.virtualHosts."navidrome.laughing-man.xyz".extraConfig = ''
          @not_metrics not path /metrics
          reverse_proxy @not_metrics http://localhost:${toString port}
        '';
        nginx.virtualHosts."navidrome.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations = {
            "/".proxyPass = "http://localhost:${toString port}";
          };
        };

        prometheus.scrapeConfigs = [
          {
            job_name = "navidrome";
            static_configs = [
              {
                targets = [
                  "localhost:${toString port}"
                ];
              }
            ];
          }
        ];

        navidrome = {
          enable = true;
          settings = {
            BaseUrl = "https://navidrome.laughing-man.xyz";
            DefaultShareExpiration = "168h";
            EnableInsightsCollector = true;
            EnableSharing = true;
            MusicFolder = "/data/media/music";
            PrometheusEnabled = config.services.prometheus.enable;
          };
        };
      };
    };
}
