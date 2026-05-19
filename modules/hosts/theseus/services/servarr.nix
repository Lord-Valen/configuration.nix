{ den, ... }:
{
  den.aspects.theseus = {
    includes = with den.aspects; [ servarr ];
    nixos =
      { lib, ... }:
      {
        systemd.services =
          let
            services = [
              "navidrome"
              "jellyfin"
              "sonarr"
              "radarr"
              "lidarr"
              "readarr"
              "bazarr"
              "deluged"
              "calibre-server"
            ];
          in
          lib.foldl (
            attrs: name:
            attrs
            // {
              ${name} = {
                after = [ "data.mount" ];
                bindsTo = [ "data.mount" ];
              };
            }
          ) { } services;
      };
  };
}
