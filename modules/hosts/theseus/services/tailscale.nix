{
  den.aspects.tailscale.provides.theseus.nixos = { config, ... }: {
    sops.secrets.tskey_auth = {
      sopsFile = ../secrets/tailscale.yaml;
      restartUnits = [ "tailscaled.service" ];
    };
    services.tailscale = {
      authKeyFile = config.sops.secrets.tskey_auth.path;
    };
  };
}
