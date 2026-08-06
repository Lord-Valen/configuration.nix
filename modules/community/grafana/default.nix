{
  den.aspects.grafana.nixos = {
    services.grafana = {
      enable = true;
      settings.server = {
        enable_gzip = true;
        enforce_domain = true;
        domain = "grafana.laughing-man.xyz";
      };
    };
  };
}
