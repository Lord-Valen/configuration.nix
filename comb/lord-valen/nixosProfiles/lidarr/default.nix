{ config, lib }:
{
  services = {
    nginx.virtualHosts."lidarr.laughing-man.xyz" = {
      forceSSL = lib.mkDefault config.security.acme.acceptTerms;
      enableACME = lib.mkDefault config.security.acme.acceptTerms;
      locations."/".proxyPass = "http://localhost:8686";
    };

    lidarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
    };
  };
}
