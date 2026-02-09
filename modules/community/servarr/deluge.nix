{
  flake.modules.nixos.servarr =
    { lib, config, ... }:
    {
      services = {
        cloudflare-dyndns.domains = [ "deluge.laughing-man.xyz" ];
        caddy.virtualHosts."deluge.laughing-man.xyz".extraConfig = ''
          reverse_proxy http://localhost:8112
          reverse_proxy /api/ http://localhost:58846
        '';
        nginx.virtualHosts."deluge.laughing-man.xyz" = {
          forceSSL = lib.mkDefault config.security.acme.acceptTerms;
          enableACME = lib.mkDefault config.security.acme.acceptTerms;
          locations."/".proxyPass = "http://localhost:8112";
          locations."/api".proxyPass = "http://localhost:58846";
        };

        # TODO: Need secret management
        #prometheus.exporters.deluge.enable = true;

        deluge = {
          enable = true;
          web.enable = true;
        };
      };

      networking.firewall = {
        allowedTCPPortRanges = [
          {
            from = 6881;
            to = 6889;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 6881;
            to = 6889;
          }
        ];
      };
    };
}
