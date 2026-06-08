{
  den.aspects.aria2.nixos =
    { config, lib, ... }:
    {
      options.den.services.aria2.rpcSecretFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
      };

      config = lib.mkMerge [
        (lib.mkIf (config.den.services.aria2.rpcSecretFile != null) {
          services.aria2 = {
            enable = true;
            rpcSecretFile = config.den.services.aria2.rpcSecretFile;
            settings = {
              enable-rpc = true;
              max-connection-per-server = 16;
              split = 16;
            };
          };
          systemd.tmpfiles.rules = [
            "e ${config.services.aria2.settings.dir} - - - 2w"
          ];
        })
        (lib.mkIf (config.den.services.aria2.rpcSecretFile == null) {
          warnings = [ "den.aspects.aria2: no rpcSecretFile set, service disabled" ];
        })
      ];
    };
}
