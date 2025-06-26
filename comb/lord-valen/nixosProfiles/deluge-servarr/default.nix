{ config, lib }:
{
  services = {
    nginx.virtualHosts."deluge.laughing-man.xyz" = {
      forceSSL = lib.mkDefault config.security.acme.acceptTerms;
      enableACME = lib.mkDefault config.security.acme.acceptTerms;
      locations."/".proxyPass = "http://localhost:8112";
    };

    deluge = {
      enable = true;
      group = "servarr";
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
}
