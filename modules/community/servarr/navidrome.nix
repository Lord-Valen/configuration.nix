{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "navidrome.laughing-man.xyz" ];
        caddy.virtualHosts."navidrome.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:4533
        '';
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
            BaseUrl = "https://navidrome.laughing-man.xyz";
            DefaultShareExpiration = "168h";
            EnableInsightsCollector = true;
            EnableSharing = true;
            MusicFolder = "/data/media/music";
          };
        };
      };
    };
}
