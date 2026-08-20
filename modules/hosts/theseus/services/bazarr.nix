{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.servarr.provides.theseus.nixos =
    { config, ... }:
    let
      port = 6767;
    in
    {
      services = {
        caddy.virtualHosts = {
          "bazarr.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            reverse_proxy http://localhost:${toString port}
          '';
        };
        prometheus.exporters.exportarr-bazarr.enable = config.services.prometheus.enable;
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
      };
    };
}
