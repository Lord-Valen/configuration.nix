{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "jellyfin.laughing-man.xyz" ];
        nginx.virtualHosts."jellyfin.laughing-man.xyz" = {
          default = lib.mkDefault true;
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations = {
            "/".proxyPass = "http://localhost:8096";
            "/socket".proxyPass = "http://localhost:8096";
          };
        };

        jellyfin.enable = true;
      };
    };
}
