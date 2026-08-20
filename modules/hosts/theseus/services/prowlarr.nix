{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.servarr.provides.theseus.nixos =
    { config, ... }:
    let
      port = 9696;
    in
    {
      services = {
        caddy.virtualHosts = {
          "prowlarr.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            reverse_proxy http://localhost:${toString port}
          '';
        };
        prometheus.exporters.exportarr-prowlarr.enable = config.services.prometheus.enable;
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
      };
    };
}
