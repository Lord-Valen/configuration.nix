{ den, ... }:
{
  den.aspects.aria2.provides.autolycus = {
    nixos =
      { config, ... }:
      {
        sops.secrets.aria2_rpc_secret = {
          sopsFile = ./../secrets/aria2.yaml;
          owner = "aria2";
        };
        den.services.aria2.rpcSecretFile = config.sops.secrets.aria2_rpc_secret.path;
        den.services.aria2.downloadAccessUsers = [ "lord-valen" ];
      };
  };
}
