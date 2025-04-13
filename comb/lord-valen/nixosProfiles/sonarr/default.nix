{ config, lib }:
{
  services = {
    nginx.virtualHosts."sonarr.laughing-man.xyz" = {
      forceSSL = lib.mkDefault config.security.acme.acceptTerms;
      enableACME = lib.mkDefault config.security.acme.acceptTerms;
      locations."/".proxyPass = "http://localhost:8989";
    };

    sonarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
    };
  };
}
