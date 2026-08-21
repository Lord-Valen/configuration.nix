{ config, ... }:
let
  inherit (config.flake.lib) caddy;
in
{
  den.aspects.stationeers.provides.theseus = {
    nixos =
      {
        config,
        ...
      }:
      let
        cfg = config.services.ssui;
        port = 8443;
        updatePort = 27015;
        gamePort = 27016;
      in
      {
        networking.firewall.allowedUDPPorts = [
          updatePort
          gamePort
        ];
        services.caddy.virtualHosts = {
          "ssui.laughing-man.xyz".extraConfig = caddy.mkTrusted ''
            reverse_proxy https://localhost:${toString port} {
              transport http {
                tls_insecure_skip_verify
              }
            }
          '';
        };
      };
  };
}
