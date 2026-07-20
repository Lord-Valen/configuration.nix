{ den, ... }:
{
  den.aspects.grafana.provides.theseus = {
    nixos =
      { config, ... }:
      {
        sops.secrets.grafana_secret_key = {
          sopsFile = ./../secrets/grafana.yaml;
          owner = "grafana";
        };
        services.grafana.settings.security.secret_key = "$__file{${config.sops.secrets.grafana_secret_key.path}}";

        services.newt.blueprint.private-resources.grafana = {
          name = "Grafana";
          mode = "http";
          destination = "localhost";
          destination-port = 3000;
          full-domain = "grafana.laughing-man.xyz";
          scheme = "http";
          ssl = false;
          enabled = true;
        };
      };
  };
}
