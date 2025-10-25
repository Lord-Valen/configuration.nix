{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "calibre.laughing-man.xyz" ];
        nginx.virtualHosts."calibre.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:8080";
        };

        calibre-servarr = {
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
