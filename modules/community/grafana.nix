{
  flake.aspects.grafana.nixos =
    { config, lib, ... }:
    {
      services =
        let
          addr = toString config.services.grafana.settings.server.http_addr;
          port = toString config.services.grafana.settings.server.http_port;
        in
        {
          cloudflare-dyndns.domains = [ "grafana.laughing-man.xyz" ];
          caddy.virtualHosts."grafana.laughing-man.xyz".extraConfig = ''
            reverse_proxy http://${addr}:${port}
          '';
          nginx.virtualHosts."grafana.laughing-man.xyz" = {
            forceSSL = lib.mkDefault config.security.acme.acceptTerms;
            enableACME = lib.mkDefault config.security.acme.acceptTerms;
            locations."/" = {
              proxyPass = "http://${addr}:${port}";
              proxyWebsockets = true;
            };
          };

          grafana = {
            enable = true;
            settings.server = {
              enable_gzip = true;
              enforce_domain = true;
              domain = "grafana.laughing-man.xyz";
            };
          };
        };
    };
}
