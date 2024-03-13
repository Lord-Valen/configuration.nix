{
  inputs,
  cell,
  config,
  lib,
}:
let
  inherit (cell) pkgs-unstable;
in
{
  networking.firewall = {
    allowedTCPPorts = [ 8080 ];
  };
  services = {
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

    deluge = {
      enable = true;
      user = "servarr";
      group = "servarr";
      web = {
        enable = true;
        openFirewall = true;
      };
    };

    jellyfin = {
      enable = true;
      user = "servarr";
      group = "servarr";
      openFirewall = true;
    };

    lidarr = {
      enable = true;
      package = pkgs-unstable.lidarr;
      user = "servarr";
      group = "servarr";
      openFirewall = true;
    };

    prowlarr = {
      enable = true;
      package = pkgs-unstable.prowlarr;
      openFirewall = true;
    };

    radarr = {
      enable = true;
      package = pkgs-unstable.radarr;
      user = "servarr";
      group = "servarr";
      openFirewall = true;
    };

    readarr = {
      enable = true;
      package = pkgs-unstable.readarr;
      user = "servarr";
      group = "servarr";
      openFirewall = true;
    };

    sonarr = {
      enable = true;
      package = pkgs-unstable.sonarr;
      user = "servarr";
      group = "servarr";
      openFirewall = true;
    };
  };
}
