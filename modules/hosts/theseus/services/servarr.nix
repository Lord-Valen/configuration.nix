{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.aspects.theseus.nixos =
    { lib, ... }:
    {
      imports = with modules.nixos; [ servarr ];
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
}
