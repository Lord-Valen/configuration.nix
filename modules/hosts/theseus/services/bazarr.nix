{
  den.aspects.servarr.provides.theseus.nixos = { config, ... }: {
    services = {
      caddy.virtualHosts = {
        "bazarr.laughing-man.xyz".extraConfig = ''
          @not_private not remote_ip private_ranges
          respond @not_private "Access denied" 403 {
            close
          }

          reverse_proxy http://localhost:6767
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
