{
  flake.modules.nixos.servarr =
    { config, lib, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "lidarr.laughing-man.xyz" ];
        caddy.virtualHosts."lidarr.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:8686
        '';
        nginx.virtualHosts."lidarr.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:8686";
        };

        prometheus.exporters.exportarr-lidarr.enable = true;
        prometheus.scrapeConfigs = [
          {
            job_name = "lidarr";
            static_configs = [
              {
                targets = [
                  "localhost:${toString config.services.prometheus.exporters.exportarr-lidarr.port}"
                ];
              }
            ];
          }
        ];

        lidarr.enable = true;
      };
    };
}
