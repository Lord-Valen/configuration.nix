{
  services = {
    nginx.virtualHosts.deluge = {
      serverAliases = [
        "deluge.home"
        "*.deluge.home"
      ];
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8112";
      };
    };

    deluge = {
      enable = true;
      user = "servarr";
      group = "servarr";
      web.enable = true;
    };
  };
}
