{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "jellyfin.laughing-man.xyz" ];
        caddy.virtualHosts."jellyfin.laughing-man.xyz".extraConfig = ''
          @not_metrics not path /metrics
          reverse_proxy @not_metrics http://localhost:8096
        '';
        nginx.virtualHosts."jellyfin.laughing-man.xyz" = {
          default = lib.mkDefault true;
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations = {
            "/".proxyPass = "http://localhost:8096";
            "/socket".proxyPass = "http://localhost:8096";
          };
        };

        prometheus.scrapeConfigs = [
          {
            job_name = "jellyfin";
            static_configs = [
              {
                targets = [
                  "localhost:8096"
                ];
              }
            ];
          }
        ];

        jellyfin.enable = true;
      };
    };
}
