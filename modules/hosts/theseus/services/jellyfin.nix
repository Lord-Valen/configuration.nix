{
  den.aspects.servarr.provides.theseus.nixos = {
    networking.firewall.allowedUDPPorts = [ 7359 ];

    services = {
      cloudflared.tunnels.main.ingress."jellyfin.laughing-man.xyz" = "http://localhost:8096";
      caddy.virtualHosts = {
        "jellyfin.laughing-man.xyz".extraConfig = ''
          @not_private not remote_ip private_ranges
          respond @not_private "Access denied" 403 {
            close
          }

          @metrics path /metrics
          respond @metrics "Access denied" 403 {
            close
          }

            reverse_proxy http://localhost:8096 {
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
                "localhost:8096"
              ];
            }
          ];
        }
      ];
    };
  };
}
