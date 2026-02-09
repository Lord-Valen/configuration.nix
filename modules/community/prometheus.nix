{
  flake.aspects.prometheus.nixos =
    { config, lib, ... }:
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
                  "localhost:${lib.toString config.services.prometheus.exporters.node.port}"
                ];
              }
            ];
          }
        ];
      };
    };
}
