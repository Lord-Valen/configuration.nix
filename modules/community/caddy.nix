{
  flake.aspects.caddy.nixos =
    { config, lib, ... }:
    {
      services = {
        prometheus.scrapeConfigs = [
          {
            job_name = "caddy";
            static_configs = [
              {
                targets = [
                  "localhost:2019"
                ];
              }
            ];
          }
        ];
        caddy = {
          enable = true;
          email = "lord_valen@proton.me";
          globalConfig = lib.optionalString config.prometheus.enable "monitor";
        };
      };
    };
}
