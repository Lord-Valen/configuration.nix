{
  den.aspects.servarr.provides.theseus.nixos = { config, ... }: {
    services = {
      caddy.virtualHosts = {
        "radarr.laughing-man.xyz".extraConfig = ''
          @not_private not remote_ip private_ranges
          respond @not_private "Access denied" 403 {
            close
          }

          reverse_proxy http://localhost:7878
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
