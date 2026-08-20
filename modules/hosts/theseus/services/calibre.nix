{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.servarr.provides.theseus.nixos =
    let
      port = 8080;
    in
    {
      services.caddy.virtualHosts = {
        "calibre.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
          reverse_proxy http://localhost:${toString port}
        '';
      };
    };
}
