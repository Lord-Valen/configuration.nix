{ cell }:
let
  inherit (cell) pkgs-unstable;
in
{
  imports = [ cell.nixosProfiles.nginx ];
  services = {
    nginx.virtualHosts = {
      "deluge.home *.deluge.home" = {
        locations."/" = {
          proxyPass = "http://localhost:8112";
        };
      };
      "jellyfin.home *.jellyfin.home" = {
        locations."/" = {
          proxyPass = "http://localhost:8096";
        };
      };
      "prowlarr.home *.prowlarr.home" = {
        locations."/" = {
          proxyPass = "http://localhost:9696";
        };
      };
      "sonarr.home *.sonarr.home" = {
        locations."/" = {
          proxyPass = "http://localhost:8989";
        };
      };
      "radarr.home *.radarr.home" = {
        locations."/" = {
          proxyPass = "http://localhost:7878";
        };
      };
      "lidarr.home *.lidarr.home" = {
        locations."/" = {
          proxyPass = "http://localhost:8686";
        };
      };
      "readarr.home *.readarr.home" = {
        locations."/" = {
          proxyPass = "http://localhost:8787";
        };
      };
      "calibre.home *.calibre.home" = {
        locations."/" = {
          proxyPass = "http://localhost:8080";
        };
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

    deluge = {
      enable = true;
      user = "servarr";
      group = "servarr";
      web.enable = true;
    };

    jellyfin = {
      enable = true;
      user = "servarr";
      group = "servarr";
    };

    lidarr = {
      enable = true;
      package = pkgs-unstable.lidarr;
      user = "servarr";
      group = "servarr";
    };

    prowlarr = {
      enable = true;
      package = pkgs-unstable.prowlarr;
    };

    radarr = {
      enable = true;
      package = pkgs-unstable.radarr;
      user = "servarr";
      group = "servarr";
    };

    readarr = {
      enable = true;
      package = pkgs-unstable.readarr;
      user = "servarr";
      group = "servarr";
    };

    sonarr = {
      enable = true;
      package = pkgs-unstable.sonarr;
      user = "servarr";
      group = "servarr";
    };
  };
}
