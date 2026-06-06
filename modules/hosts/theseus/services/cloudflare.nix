{ den, ... }:
{
  den.aspects.cloudflare.provides.theseus = {
    nixos =
      { config, ... }:
      {
        sops.secrets.cloudflare_secret = {
          sopsFile = ./../secrets/cloudflare.yaml;
          mode = "0444";
        };
        services.cloudflare-dyndns.apiTokenFile = config.sops.secrets.cloudflare_secret.path;
      };
  };
}
