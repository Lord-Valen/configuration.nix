{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.servarr.provides.theseus = {
    os =
      { config, ... }:
      let
        port = config.services.qui.settings.port;
      in
      {
        services.caddy.virtualHosts = {
          "qui.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            reverse_proxy http://localhost:${toString port}
          '';
        };

        sops.secrets.qui_secret = {
          sopsFile = ./../secrets/qui.yaml;
          owner = config.services.qui.user;
        };

        services.qui.secretFile = config.sops.secrets.qui_secret.path;
        services.qbittorrent.webuiPort = 7070;
      };
  };
}
