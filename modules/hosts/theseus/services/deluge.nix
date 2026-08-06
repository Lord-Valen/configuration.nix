{
  den.aspects.servarr.provides.theseus = {
    nixos =
      { config, ... }:
      {
        services.caddy.virtualHosts = {
          "deluge.laughing-man.xyz".extraConfig = ''
            @not_private not remote_ip private_ranges
            respond @not_private "Access denied" 403 {
              close
            }

            reverse_proxy http://localhost:8112
            reverse_proxy /api/ http://localhost:58846
          '';
          "deluge.ling-grouper.ts.net".extraConfig = ''
            reverse_proxy http://localhost:8112
            reverse_proxy /api/ http://localhost:58846
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
