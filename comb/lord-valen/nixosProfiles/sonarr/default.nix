{
  services = {
    nginx.virtualHosts.sonarr = {
      serverAliases = [ "sonarr.home *.sonarr.home" ];
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8989";
      };
    };
    sonarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
    };
  };
}
