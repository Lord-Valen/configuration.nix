{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "prowlarr.laughing-man.xyz" ];
        caddy.virtualHosts."prowlarr.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:9696
        '';
        nginx.virtualHosts."prowlarr.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:9696";
        };

        prometheus.exporters.exportarr-prowlarr.enable = true;
        prometheus.scrapeConfigs = [
          {
            job_name = "prowlarr";
            static_configs = [
              {
                targets = [
                  "localhost:${lib.toString config.services.prometheus.exporters.exportarr-prowlarr.port}"
                ];
              }
            ];
          }
        ];

        prowlarr.enable = true;
      };
    };
}
