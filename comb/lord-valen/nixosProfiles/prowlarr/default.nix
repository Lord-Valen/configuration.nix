{
  services = {
    nginx.virtualHosts.prowlarr = {
      serverAliases = [ "prowlarr.home *.prowlarr.home" ];
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:9696";
      };
    };

    prowlarr = {
      enable = true;
    };
  };
}
