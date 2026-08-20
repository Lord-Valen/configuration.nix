{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.servarr.provides.theseus.nixos =
    { config, ... }:
    let
      port = 7878;
    in
    {
      services = {
        caddy.virtualHosts = {
          "radarr.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            reverse_proxy http://localhost:${toString port}
          '';
        };
        prometheus.exporters.exportarr-radarr.enable = config.services.prometheus.enable;
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
      };
    };
}
