{
  den.aspects.caddy.provides.theseus = {
    nixos =
      {
        config,
        pkgs,
        ...
      }:
      {
        sops.secrets.cloudflare_secret = {
          sopsFile = ../secrets/cloudflare.yaml;
          restartUnits = [ "caddy.service" ];
        };

        systemd.services.caddy.serviceConfig.LoadCredential =
          "cloudflare_token:${config.sops.secrets.cloudflare_secret.path}";

        sops.templates.caddy-cloudflare.content = ''
          CLOUDFLARE_TOKEN = ${config.sops.placeholder.cloudflare_secret}
        '';

        services.caddy = {
          enable = true;
          package = pkgs.caddy.withPlugins {
            plugins = [
              "github.com/caddy-dns/cloudflare@v0.2.4"
              "github.com/mholt/caddy-dynamicdns@v0.0.0-20260805195708-67d107a42c02"
            ];
            hash = "sha256-a7uBX2NGY73cjIcvz+KpnQeqZIPdGz8Z73V0eQGTTBM=";
          };
          environmentFile = config.sops.templates.caddy-cloudflare.path;
          globalConfig = ''
            acme_dns cloudflare {env.CLOUDFLARE_TOKEN}
            dns cloudflare {env.CLOUDFLARE_TOKEN}

            dynamic_dns {
              provider cloudflare {env.CLOUDFLARE_TOKEN}
              domains {
                laughing-man.xyz * stream
              }
            }
          '';
        };
      };
  };
}
