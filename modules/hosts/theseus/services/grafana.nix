{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.grafana.provides.theseus = {
    nixos =
      { config, ... }:
      let
        addr = toString config.services.grafana.settings.server.http_addr;
        port = toString config.services.grafana.settings.server.http_port;
      in
      {
        services.caddy.virtualHosts = {
          "grafana.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            reverse_proxy http://${addr}:${port}
          '';
        };

        sops.secrets.grafana_secret_key = {
          sopsFile = ./../secrets/grafana.yaml;
          owner = "grafana";
        };
        services.grafana.settings.security.secret_key =
          "$__file{${config.sops.secrets.grafana_secret_key.path}}";
      };
  };
}
