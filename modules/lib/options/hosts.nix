# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{
  lib,
  config,
  inputs,
  ...
}:
{
  options.hosts = lib.mkOption {
    type = lib.types.attrsOf (lib.types.deferredModule);
    default = { };
    description = "NixOS hosts.";
  };

  config =
    let
      inherit (config) hosts;
      inherit (config.flake) modules;
      toNixos =
        hostName: module:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            module
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
      text.readme.parts.hosts = ''
        ## Hosts

        The set of NixOS hosts is defined via an option which accepts deferred modules.
        Differentiating the hosts as a subset of the NixOS modules allows us to map over the hosts
        both when generating NixOS configurations and when defining checks for the flake.

        See definition at [`hosts.nix`](modules/lib/options/hosts.nix).
        See usage at [`autolycus`](modules/hosts/autolycus/default.nix).
      '';
    };
}
