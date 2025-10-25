{
  flake.modules.nixos.cloudflare =
    { lib, ... }:
    {
      services.cloudflare-dyndns = {
        enable = true;
        proxied = true;
        apiTokenFile = lib.mkDefault "/var/lib/cloudflare-dyndns/cloudflare_token.conf";
      };
    };
}
