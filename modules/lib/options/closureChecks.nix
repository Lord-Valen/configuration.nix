# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{
  config,
  lib,
  inputs,
  ...
}:
{
  options.closureChecks = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          budget = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            default = null;
            description = "Maximum acceptable closure size in bytes. Null means log only.";
            example = 2000000000;
          };
          closure = lib.mkOption {
            type = lib.types.anything;
            description = "NixOS configuration to check.";
          };
        };
      }
    );
    default = { };
    description = "NixOS configurations to monitor for closure size.";
  };

  config =
    let
      inherit (config) closureChecks;

      toClosureCheck =
        hostName: check:
        let
          nixosClosure = inputs.nixpkgs.lib.nixosSystem {
            modules = [
              check.closure
              {
                networking = { inherit hostName; };
                nixpkgs.config = {
                  allowBroken = true;
                  allowInsecurePredicate = _: true;
                  allowUnfree = true;
                };
              }
            ];
          };

          pkgs = nixosClosure.pkgs;
          nixosConfig = nixosClosure.config;
          system = nixosConfig.nixpkgs.hostPlatform.system;
          toplevel = nixosConfig.system.build.toplevel;
          closureInfo = pkgs.closureInfo { rootPaths = [ toplevel ]; };

          budgetCheck =
            if check.budget != null then
              ''
                if [ "$actualBytes" -gt "${builtins.toString check.budget}" ]; then
                  budgetHuman=$(numfmt --to=iec-i --suffix=B ${builtins.toString check.budget})
                  echo "❌ OVER BUDGET: $actualHuman > $budgetHuman"
                  exit 1
                fi
                echo "✓ Within budget"
              ''
            else
              "";

          checkDrv = pkgs.runCommand "closure-size-${hostName}" { buildInputs = with pkgs; [ coreutils ]; } ''
            actualBytes=$(cat ${closureInfo}/total-nar-size)
            actualHuman=$(numfmt --to=iec-i --suffix=B $actualBytes)
            echo "=== ${hostName} closure size: $actualHuman ($actualBytes bytes) ==="
            ${budgetCheck}
            echo "$actualHuman" > $out
          '';
        in
        {
          ${system}."closure-size-${hostName}" = checkDrv;
        };
    in
    {
      flake.checks = closureChecks |> lib.mapAttrsToList toClosureCheck |> lib.mkMerge;

      text.readme.parts.closure-checks = ''
        ## Closure Checks

        Closure size checks are defined via the `closureChecks` option.
        Each entry logs the human-readable closure size; an optional `budget` field causes the check to fail if the size exceeds it.

        See definition at [`closureChecks.nix`](modules/lib/options/closureChecks.nix).
        See checks at [`closureChecks/`](modules/closureChecks/).
      '';
    };
}
