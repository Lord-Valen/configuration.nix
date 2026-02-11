{
  flake.aspects.prometheus.nixos =
    { config, ... }:
    {
      services.prometheus = {
        enable = true;
        exporters.node.enable = true;
        exporters.node.enabledCollectors = [
          "systemd"
        ];
        scrapeConfigs = [
          {
            job_name = "node";
            static_configs = [
              {
                targets = [
                  "localhost:${toString config.services.prometheus.exporters.node.port}"
                ];
              }
            ];
          }
        ];
      };
    };
}
