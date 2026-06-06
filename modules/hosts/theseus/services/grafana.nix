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
      };
  };
}
