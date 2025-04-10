{
  services = {
    nginx.virtualHosts.calibre = {
      serverAliases = [ "calibre.home *.calibre.home" ];
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8080";
      };
    };

    calibre-server = {
      enable = true;
      user = "servarr";
      group = "servarr";
      libraries = [ "/data/media/books" ];
      auth = {
        enable = true;
        mode = "basic";
        userDb = "/data/calibre-users.sqlite";
      };
    };
  };
}
