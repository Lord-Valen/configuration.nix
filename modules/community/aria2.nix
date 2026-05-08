{
  flake.aspects.aria2.nixos =
    { config, pkgs, ... }:
    {
      services.aria2 = {
        enable = true;
        rpcSecretFile = pkgs.writeText "aria2-rpc-secret" "$$secret$$";
        settings = {
          enable-rpc = true;
          max-connection-per-server = 16;
          split = 16;
        };
      };
      systemd.tmpfiles.rules = [
        "e ${config.services.aria2.settings.dir} - - - 2w"
      ];
    };
}
