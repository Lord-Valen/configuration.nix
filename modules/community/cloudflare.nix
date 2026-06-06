{
  den.aspects.cloudflare.nixos =
    { lib, ... }:
    {
      services.cloudflare-dyndns = {
        enable = true;
        proxied = true;
        apiTokenFile = lib.mkDefault null;
      };
    };
}
