{
  den.aspects.servarr.nixos =
    { config, lib, ... }:
    {
      services = {
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
                  "localhost:${toString config.services.prometheus.exporters.exportarr-prowlarr.port}"
                ];
              }
            ];
          }
        ];

        prowlarr.enable = true;
      };
    };
}
