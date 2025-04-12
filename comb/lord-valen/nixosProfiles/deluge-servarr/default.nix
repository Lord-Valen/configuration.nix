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
      user = "servarr";
      group = "servarr";
      web.enable = true;
    };
  };
}
