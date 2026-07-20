{ den, ... }:
{
  den.aspects.pangolin.provides.theseus = {
    nixos =
      { config, ... }:
      {
        sops.secrets.pangolin_server_secret = {
          sopsFile = ./../secrets/pangolin.yaml;
          key = "server_secret";
        };
        sops.templates.pangolin-env.content = ''
          SERVER_SECRET=${config.sops.placeholder.pangolin_server_secret}
        '';

        services.pangolin = {
          enable = true;
          openFirewall = true;
          baseDomain = "laughing-man.xyz";
          letsEncryptEmail = "lord_valen@proton.me";
          environmentFile = config.sops.templates.pangolin-env.path;
        };
      };
  };
}
