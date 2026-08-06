{
  den.aspects.servarr.provides.theseus.nixos = { config, ... }: {
    services = {
      caddy.virtualHosts = {
        "lidarr.laughing-man.xyz".extraConfig = ''
          @not_private not remote_ip private_ranges
          respond @not_private "Access denied" 403 {
            close
          }

          reverse_proxy http://localhost:8686
        '';
        "lidarr.ling-grouper.ts.net".extraConfig = ''
          reverse_proxy http://localhost:8686
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
