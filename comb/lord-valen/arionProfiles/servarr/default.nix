{
  inputs,
  cell,
}: let
  inherit (cell.arionProfiles) common;
in {
  imports = [common];

  networking.firewall = {
    allowedTCPPorts = [
      9696
      8686
      8989
      7878
      8787
      8112
      6881
      8096
      8920
    ];
    allowedUDPPorts = [
      6881
      7359
      1900
    ];
  };

  virtualisation.arion.projects.servarr.settings = let
    appdir = "/docker/appdata/";
    datadir = "/data";
    env = {
      PUID = "1000";
      PGID = "1000";
      UMASK = "002";
      TZ = "Canada/Eastern";
    };
    restart = "unless-stopped";
  in {
    config.services = {
      prowlarr.service = {
        useHostStore = true;
        environment = env;
        restart = restart;
        image = "lscr.io/linuxserver/prowlarr:nightly";
        volumes = [(appdir + "prowlarr:/config")];
        ports = ["9696:9696"];
      };
      lidarr.service = {
        useHostStore = true;
        environment = env;
        restart = restart;
        image = "lscr.io/linuxserver/lidarr";
        volumes = [(appdir + "lidarr:/config") (datadir + ":/data")];
        ports = ["8686:8686"];
      };
      sonarr.service = {
        useHostStore = true;
        environment = env;
        restart = restart;
        image = "lscr.io/linuxserver/sonarr";
        volumes = [(appdir + "sonarr:/config") (datadir + ":/data")];
        ports = ["8989:8989"];
      };
      radarr.service = {
        useHostStore = true;
        environment = env;
        restart = restart;
        image = "lscr.io/linuxserver/radarr";
        volumes = [(appdir + "radarr:/config") (datadir + ":/data")];
        ports = ["7878:7878"];
      };
      readarr.service = {
        useHostStore = true;
        environment = env;
        restart = restart;
        image = "lscr.io/linuxserver/readarr:nightly";
        volumes = [(appdir + "readarr:/config") (datadir + ":/data")];
        ports = ["8787:8787"];
      };
      deluge.service = {
        useHostStore = true;
        environment = env;
        restart = restart;
        image = "lscr.io/linuxserver/deluge";
        volumes = [
          (appdir + "deluge/config:/config")
          (appdir + "deluge/downloads:/downloads")
          (datadir + "/torrents:/data/torrents")
        ];
        ports = ["8112:8112" "6881:6881" "6881:6881/udp"];
      };
      jellyfin.service = {
        useHostStore = true;
        environment = env;
        restart = restart;
        image = "lscr.io/linuxserver/jellyfin";
        volumes = [(appdir + "jellyfin:/config") (datadir + "/media:/media")];
        ports = ["8096:8096" "8920:8920" "7359:7359/udp" "1900:1900/udp"];
      };
    };
  };
}
