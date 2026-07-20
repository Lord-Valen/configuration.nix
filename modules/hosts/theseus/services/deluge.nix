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

        # TODO: Caddy's config routed /api/ separately to the raw daemon port
        # (58846) from the main UI (8112) - this private-resource schema has no
        # path-based multi-target routing. A single resource pointing at 8112
        # may leave /api/ broken. Verify once deployed.
        services.newt.blueprint.private-resources.deluge = {
          name = "Deluge";
          mode = "http";
          destination = "localhost";
          destination-port = 8112;
          full-domain = "deluge.laughing-man.xyz";
          scheme = "http";
          ssl = false;
          enabled = true;
        };
      };
  };
}
