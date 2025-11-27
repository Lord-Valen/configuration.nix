{
  flake.modules.nixos.cloudflare =
    { lib, ... }:
    {
      services.cloudflare-dyndns = {
        enable = true;
        proxied = true;
        apiTokenFile = lib.mkDefault "/etc/cloudflare_token.txt";
      };
    };
}
