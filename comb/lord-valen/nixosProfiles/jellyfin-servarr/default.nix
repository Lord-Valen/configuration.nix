{
  services = {
    nginx.virtualHosts.jellyfin = {
      serverAliases = [ "jellyfin.home *.jellyfin.home" ];
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8096";
      };
    };
    jellyfin = {
      enable = true;
      user = "servarr";
      group = "servarr";
    };
  };
}
