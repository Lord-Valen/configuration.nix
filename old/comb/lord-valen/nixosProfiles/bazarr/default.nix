{ config, lib }:
{
  services = {
    nginx.virtualHosts."bazarr.laughing-man.xyz" = {
      forceSSL = lib.mkDefault config.security.acme.acceptTerms;
      enableACME = lib.mkDefault config.security.acme.acceptTerms;
      locations."/".proxyPass = "http://localhost:6767";
    };

    bazarr.enable = true;
  };
}
