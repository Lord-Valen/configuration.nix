{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "radarr.laughing-man.xyz" ];
        caddy.virtualHosts."radarr.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:7878
        '';
        nginx.virtualHosts."radarr.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:7878";
        };

        prometheus.exporters.exportarr-radarr.enable = true;
        prometheus.scrapeConfigs = [
          {
            job_name = "radarr";
            static_configs = [
              {
                targets = [
                  "localhost:${toString config.services.prometheus.exporters.exportarr-radarr.port}"
                ];
              }
            ];
          }
        ];

        radarr.enable = true;
      };
    };
}
