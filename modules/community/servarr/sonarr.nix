{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "sonarr.laughing-man.xyz" ];
        caddy.virtualHosts."sonarr.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:8989
        '';
        nginx.virtualHosts."sonarr.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:8989";
        };

        sonarr.enable = true;
      };
    };
}
