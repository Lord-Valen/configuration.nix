{
  den.aspects.servarr.provides.theseus.nixos = { config, ... }: {
    services = {
      caddy.virtualHosts = {
        "readarr.laughing-man.xyz".extraConfig = ''
          @not_private not remote_ip private_ranges
          respond @not_private "Access denied" 403 {
            close
          }

          reverse_proxy http://localhost:8787
        '';
        "readarr.ling-grouper.ts.net".extraConfig = ''
          reverse_proxy http://localhost:8787
        '';
      };

      prometheus.exporters.exportarr-readarr.enable = config.services.prometheus.enable;
      prometheus.scrapeConfigs = [
        {
          job_name = "readarr";
          static_configs = [
            {
              targets = [
                "localhost:${toString config.services.prometheus.exporters.exportarr-readarr.port}"
              ];
            }
          ];
        }
      ];
    };
  };
}
