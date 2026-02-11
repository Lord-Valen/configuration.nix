{
  flake.modules.nixos.servarr =
    { config, lib, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "bazarr.laughing-man.xyz" ];
        caddy.virtualHosts."bazarr.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:6767
        '';
        nginx.virtualHosts."bazarr.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:6767";
        };

        prometheus.exporters.exportarr-bazarr.enable = true;
        prometheus.scrapeConfigs = [
          {
            job_name = "bazarr";
            static_configs = [
              {
                targets = [
                  "localhost:${toString config.services.prometheus.exporters.exportarr-bazarr.port}"
                ];
              }
            ];
          }
        ];

        bazarr.enable = true;
      };
    };
}
