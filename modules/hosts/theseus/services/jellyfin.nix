{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.servarr.provides.theseus.nixos =
    let
      port = 8096;
      discoveryPort = 7359;
    in
    {
      networking.firewall.allowedUDPPorts = [ discoveryPort ];

      services = {
        cloudflared.tunnels.main.ingress."jellyfin.laughing-man.xyz" = "http://localhost:8096";
        caddy.virtualHosts = {
          "jellyfin.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            @metrics path /metrics
            respond @metrics "Access denied" 403 {
              close
            }

            reverse_proxy http://localhost:${toString port} {
              flush_interval -1
            }
          '';
        };

        prometheus.scrapeConfigs = [
          {
            job_name = "jellyfin";
            static_configs = [
              {
                targets = [
                  "localhost:${toString port}"
                ];
              }
            ];
          }
        ];
      };
    };
}
