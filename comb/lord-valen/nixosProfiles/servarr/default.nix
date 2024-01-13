{
  inputs,
  cell,
  config,
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;
in {
  networking.firewall = {
    allowedTCPPorts = [8080];
  };
  services = {
    calibre-server = {
      enable = true;
      auth = {
        enable = true;
        mode = "basic";
        userDb = "/var/lib/calibre-server/users.sqlite";
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
      user = "servarr";
      group = "servarr";
      openFirewall = true;
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    radarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
      openFirewall = true;
    };

    readarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
      openFirewall = true;
    };

    sonarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
      openFirewall = true;
    };
  };
}
