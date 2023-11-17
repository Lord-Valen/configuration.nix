{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;
in {
  services = {
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

    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    lidarr = {
      enable = true;
      user = "servarr";
      group = "servarr";
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
