{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.servarr.provides.theseus = {
    nixos =
      { config, ... }:
      let
        port = 8112;
        apiPort = 58846;
      in
      {
        services.caddy.virtualHosts = {
          "deluge.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            reverse_proxy http://localhost:${toString port}
            reverse_proxy /api/ http://localhost:${toString apiPort}
          '';
        };

        sops.secrets.deluge_secret = {
          sopsFile = ./../secrets/deluge.yaml;
          owner = "deluge";
        };
        services.prometheus.exporters.deluge = {
          enable = config.services.prometheus.enable;
          delugePasswordFile = config.sops.secrets.deluge_secret.path;
        };
      };
  };
}
