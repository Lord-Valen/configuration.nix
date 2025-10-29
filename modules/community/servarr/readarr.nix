{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "readarr.laughing-man.xyz" ];
        nginx.virtualHosts."readarr.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:8787";
        };

        readarr.enable = true;
      };
    };
}
