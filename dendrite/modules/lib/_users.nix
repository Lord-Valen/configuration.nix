{
  lib,
  config,
  ...
}:
let
  users = config.flake.modules.users or { };
in
{
  flake.users =
    users
    |> lib.mapAttrs' (
      name: module: {
        name = name;
        value = lib.nixosSystem {
          modules = [
            module
            { networking = { inherit name; }; }
          ];
        };
      }
    );

  flake.checks =
    config.flake.nixosConfigurations
    |> lib.mapAttrsToList (
      name: nixos: {
        ${nixos.config.nixpkgs.hostPlatform.system} = {
          "${name}" = nixos.config.system.build.toplevel;
        };
      }
    )
    |> lib.mkMerge;
}
