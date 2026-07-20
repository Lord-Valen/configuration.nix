{ den, ... }:
{
  # Scaffolded, not yet wired into theseus's aspect list.
  # Only needed if Pangolin moves off theseus (e.g. onto a VPS) and theseus becomes a remote site tunneling in.
  # While Pangolin runs on theseus itself, this aspect stays unused.
  #
  # `NEWT_ID` and `NEWT_SECRET` are issued by Pangolin's dashboard when creating a client, not self-generated.
  # Populate once that client exists.
  den.aspects.newt.provides.theseus = {
    nixos =
      { config, ... }:
      {
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
          settings.endpoint = "https://pangolin.laughing-man.xyz";
        };
      };
  };
}
