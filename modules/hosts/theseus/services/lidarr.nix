{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.servarr.provides.theseus.nixos =
    { config, ... }:
    let
      port = 8686;
    in
    {
      services = {
        caddy.virtualHosts = {
          "lidarr.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            reverse_proxy http://localhost:${toString port}
          '';
        };

        prometheus.exporters.exportarr-lidarr.enable = config.services.prometheus.enable;
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
      };
    };
}
