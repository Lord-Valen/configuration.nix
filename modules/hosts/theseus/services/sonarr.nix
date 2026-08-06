{
  den.aspects.servarr.provides.theseus.nixos = { config, ... }: {
    services = {
      caddy.virtualHosts = {
        "sonarr.laughing-man.xyz".extraConfig = ''
          @not_private not remote_ip private_ranges
          respond @not_private "Access denied" 403 {
            close
          }

          reverse_proxy http://localhost:8989
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
