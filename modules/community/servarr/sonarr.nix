{
  flake.modules.nixos.servarr =
    { config, lib, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "sonarr.laughing-man.xyz" ];
        caddy.virtualHosts."sonarr.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:8989
        '';
        nginx.virtualHosts."sonarr.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:8989";
        };

        prometheus.exporters.exportarr-sonarr.enable = true;
        prometheus.scrapeConfigs = [
          {
            job_name = "sonarr";
            static_configs = [
              {
                targets = [
                  "localhost:${toString config.services.prometheus.exporters.exportarr-sonarr.port}"
                ];
              }
            ];
          }
        ];

        sonarr.enable = true;
      };
    };
}
