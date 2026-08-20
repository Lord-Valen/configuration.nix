{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.servarr.provides.theseus.nixos =
    { config, ... }:
    let
      port = 8989;
    in
    {
      services = {
        caddy.virtualHosts = {
          "sonarr.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            reverse_proxy http://localhost:${toString port}
          '';
        };

        prometheus.exporters.exportarr-sonarr.enable = config.services.prometheus.enable;
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
      };
    };
}
