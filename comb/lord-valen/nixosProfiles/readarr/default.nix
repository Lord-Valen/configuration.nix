{ config, lib }:
{
  services = {
    nginx.virtualHosts."readarr.laughing-man.xyz" = {
      forceSSL = lib.mkDefault config.security.acme.acceptTerms;
      enableACME = lib.mkDefault config.security.acme.acceptTerms;
      locations."/".proxyPass = "http://localhost:8787";
    };

    readarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
    };
  };
}
