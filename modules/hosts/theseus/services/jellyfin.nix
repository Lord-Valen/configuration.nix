{
  den.aspects.servarr.provides.theseus.nixos = {
    networking.firewall.allowedUDPPorts = [ 7359 ];

    services = {
      caddy.virtualHosts = {
        "jellyfin.laughing-man.xyz".extraConfig = ''
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
