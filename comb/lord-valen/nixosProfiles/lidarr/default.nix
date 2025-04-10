{
  services = {
    nginx.virtualHosts.lidarr = {
      serverAliases = [ "lidarr.home *.lidarr.home" ];
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8686";
      };
    };

    lidarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
    };
  };
}
