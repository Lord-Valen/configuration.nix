{
  services = {
    nginx.virtualHosts.radarr = {
      serverAliases = [ "radarr.home *.radarr.home" ];
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:7878";
      };
    };

    radarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
    };
  };
}
