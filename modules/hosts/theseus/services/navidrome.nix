{
  den.aspects.servarr.provides.theseus.nixos =
    { config, ... }:
    let
      port = config.services.navidrome.settings.Port or 4553;
    in
    {
      services = {
        cloudflared.tunnels.main.ingress."navidrome.laughing-man.xyz" = "http://localhost:${toString port}";
        caddy.virtualHosts."navidrome.laughing-man.xyz".extraConfig = ''
          @not_private not remote_ip private_ranges
          respond @not_private "Access denied" 403 {
            close
          }

          @metrics path /metrics
          respond @metrics "Access denied" 403 {
            close
          }

          reverse_proxy http://localhost:${toString port}
        '';
        prometheus.scrapeConfigs = [
          {
            job_name = "navidrome";
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
