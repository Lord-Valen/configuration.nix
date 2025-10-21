{ config, lib }:
{
  services = {
    nginx.virtualHosts."prowlarr.laughing-man.xyz" = {
      forceSSL = lib.mkDefault config.security.acme.acceptTerms;
      enableACME = lib.mkDefault config.security.acme.acceptTerms;
      locations."/".proxyPass = "http://localhost:9696";
    };

    prowlarr.enable = true;
  };
}
