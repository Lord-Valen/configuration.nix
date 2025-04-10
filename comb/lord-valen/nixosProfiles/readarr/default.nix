{
  services = {
    nginx.virtualHosts.readarr = {
      serverAliases = [ "readarr.home *.readarr.home" ];
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8787";
      };
    };

    readarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
    };
  };
}
