{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "calibre.laughing-man.xyz" ];
        caddy.virtualHosts."calibre.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:8080
        '';
        nginx.virtualHosts."calibre.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:8080";
        };

        calibre-server = {
          inherit (config.services.readarr) user group;
          enable = true;
          libraries = [ "/data/media/books" ];
          auth = {
            enable = true;
            mode = "basic";
            userDb = "/data/calibre-users.sqlite";
          };
        };
      };
    };
}
