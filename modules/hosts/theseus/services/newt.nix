{ config, den, ... }:
let
  newtOverlay = config.flake.overlays.fosrl-unstable;
in
{
  # Needed even on the same host as Pangolin: the "Local" site type doesn't
  # support private resources, only a "Newt" site does.
  # NEWT_ID/NEWT_SECRET come from the dashboard's Add Site flow, not self-generated.
  den.aspects.newt.provides.theseus = {
    nixos =
      { config, ... }:
      {
        nixpkgs.overlays = [ newtOverlay ];

        sops.secrets.newt_id = {
          sopsFile = ./../secrets/newt.yaml;
          key = "id";
        };
        sops.secrets.newt_secret = {
          sopsFile = ./../secrets/newt.yaml;
          key = "secret";
        };
        sops.templates.newt-env.content = ''
          NEWT_ID=${config.sops.placeholder.newt_id}
          NEWT_SECRET=${config.sops.placeholder.newt_secret}
        '';

        services.newt = {
          enable = true;
          environmentFile = config.sops.templates.newt-env.path;
          # Talks straight to Pangolin's internal API port, same pattern as Gerbil.
          settings.endpoint = "http://localhost:${toString config.services.pangolin.settings.server.external_port}";
        };
      };
  };
}
