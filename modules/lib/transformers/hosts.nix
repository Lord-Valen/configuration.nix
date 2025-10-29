{
  inputs,
  lib,
  config,
  ...
}:
let
  modules = config.flake.modules;
  hosts = modules.hosts or { };
  toNixos =
    hostName: module:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        (module // { _class = "nixos"; })
        modules.nixos.base
        { networking = { inherit hostName; }; }
      ];
    };
  toCheck = hostName: module: {
    ${module.config.nixpkgs.hostPlatform.system}.${hostName} = module.config.system.build.toplevel;
  };
in
{
  flake.nixosConfigurations = hosts |> lib.mapAttrs toNixos;
  flake.checks = config.flake.nixosConfigurations |> lib.mapAttrsToList toCheck |> lib.mkMerge;
}
