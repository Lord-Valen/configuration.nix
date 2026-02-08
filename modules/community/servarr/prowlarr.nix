{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "prowlarr.laughing-man.xyz" ];
        caddy.virtualHosts."prowlarr.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:9696
        '';
        nginx.virtualHosts."prowlarr.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:9696";
        };

        prowlarr.enable = true;
      };
    };
}
