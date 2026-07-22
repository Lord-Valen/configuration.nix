# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{
  lib,
  config,
  inputs,
  ...
}:
let
  mdnix = inputs.mdnix.lib;
in
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
    in
    {
      flake.nixosConfigurations = hosts |> lib.mapAttrs toNixos;
      text.readme.parts.hosts = [
        (mdnix.h 2 "Hosts" |> config.flake.lib.writtenAt "modules/lib/options/hosts.nix")
        (mdnix.p ''
          The set of NixOS hosts is defined via an option which accepts deferred modules.
          Differentiating the hosts as a subset of the NixOS modules allows us to map over the hosts
          without string matching.
        '')
        (mdnix.p [
          (mdnix.text "See usage at ")
          (mdnix.ln "`autolycus`" "modules/hosts/autolycus/default.nix")
          (mdnix.text ".")
        ])
      ];
    };
}
