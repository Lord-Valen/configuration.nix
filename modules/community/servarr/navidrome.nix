{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "navidrome.laughing-man.xyz" ];
        nginx.virtualHosts."navidrome.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations = {
            "/".proxyPass = "http://localhost:4533";
          };
        };

        navidrome = {
          enable = true;
          settings = {
            MusicFolder = "/data/media/music";
            EnableSharing = true;
            DefaultShareExpiration = "168h";
          };
        };
      };
    };
}
