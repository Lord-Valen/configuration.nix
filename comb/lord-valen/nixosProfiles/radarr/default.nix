{ config, lib }:
{
  services = {
    nginx.virtualHosts."radarr.laughing-man.xyz" = {
      forceSSL = lib.mkDefault config.security.acme.acceptTerms;
      enableACME = lib.mkDefault config.security.acme.acceptTerms;
      locations."/".proxyPass = "http://localhost:7878";
    };

    radarr.enable = true;
  };
}
