{ den, ... }:
{
  den.aspects.servarr.provides.theseus = {
    nixos =
      { config, ... }:
      {
        sops.secrets.deluge_secret = {
          sopsFile = ./../secrets/deluge.yaml;
          owner = "deluge";
        };
        services.prometheus.exporters.deluge = {
          enable = true;
          delugePasswordFile = config.sops.secrets.deluge_secret.path;
        };
      };
  };
}
