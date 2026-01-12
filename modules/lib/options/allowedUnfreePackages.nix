# SPDX-FileCopyrightText: 2024 Shahar "Dawn" Or
#
# SPDX-License-Identifier: MIT

{ lib, config, ... }:
{
  options.nixpkgs.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = {
    text.readme.parts.allowedUnfreePackages = ''
      ## Unfree packages

      Which unfree packages are allowed is configured at the flake level via an option.
      That is then used in the configuration of Nixpkgs.
      See definition at [`unfree-packages.nix`](modules/lib/options/unfree-packages.nix).
      See usage at [`vscode`](modules/community/vscode/+unfree.nix).
      The value of this option is available as a flake output:

      ```console
      $ nix eval .#meta.nixpkgs.allowedUnfreePackages
      ```
    '';

    flake = {
      modules =
        let
          predicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;
        in
        {
          nixos.base.nixpkgs.config.allowUnfreePredicate = predicate;

          homeManager.base = args: {
            nixpkgs.config = lib.mkIf (!(args.hasGlobalPkgs or false)) {
              allowUnfreePredicate = predicate;
            };
          };
        };

      meta.nixpkgs.allowedUnfreePackages = config.nixpkgs.allowedUnfreePackages;
    };
  };
}
