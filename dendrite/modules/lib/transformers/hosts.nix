{
  lib,
  config,
  ...
}:
let
  hosts = config.flake.modules.hosts or { };
  toNixos = hostName: module: {
    name = hostName;
    value = lib.nixosSystem {
      modules = [
        module
        { networking = { inherit hostName; }; }
      ];
    };
  };
  toCheck = hostName: module: {
    ${module.config.nixpkgs.hostPlatform.system} = {
      "${hostName}" = module.config.system.build.toplevel;
    };
  };
in
{
  flake.nixosConfigurations = hosts |> lib.mapAttrs' toNixos;
  flake.checks = config.flake.nixosConfigurations |> lib.mapAttrsToList toCheck |> lib.mkMerge;
}
