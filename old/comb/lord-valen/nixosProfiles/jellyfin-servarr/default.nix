{ config, lib }:
{
  services = {
    nginx.virtualHosts."jellyfin.laughing-man.xyz" = {
      forceSSL = lib.mkDefault config.security.acme.acceptTerms;
      enableACME = lib.mkDefault config.security.acme.acceptTerms;
      locations = {
        "/".proxyPass = "http://localhost:8096";
        "/socket".proxyPass = "http://localhost:8096";
      };
    };

    jellyfin.enable = true;
  };
}
