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
          bytes = lib.mkOption {
            type = lib.types.int;
            description = "Expected closure size in bytes.";
          };
          human = lib.mkOption {
            type = lib.types.str;
            description = "Human-readable closure size (for reference).";
            example = "1.2GiB";
          };
          closure = lib.mkOption {
            type = lib.types.deferredModule;
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
      inherit (config.flake) modules;

      toClosureCheck =
        hostName: check:
        let
          toNixos =
            module:
            inputs.nixpkgs.lib.nixosSystem {
              modules = [
                module
                modules.nixos.base
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

          nixosClosure = toNixos check.closure;
          pkgs = nixosClosure.pkgs;
          nixosConfig = nixosClosure.config;
          system = nixosConfig.nixpkgs.hostPlatform.system;
          toplevel = nixosConfig.system.build.toplevel;
          closureInfo = pkgs.closureInfo { rootPaths = [ toplevel ]; };

          checkDrv =
            pkgs.runCommand "closure-size-${hostName}.nix"
              {
                buildInputs = with pkgs; [ coreutils ];
              }
              ''
                actualBytes=$(cat ${closureInfo}/total-nar-size)
                actualHuman=$(numfmt --to=iec-i --suffix=B $actualBytes)
                expectedBytes=${builtins.toString check.bytes}
                expectedHuman="${check.human}"

                # Output Nix attrset for easy copying
                cat > $out <<EOF
                {
                  bytes = $actualBytes;
                  human = "$actualHuman";
                }
                EOF

                echo "=== ${hostName} Closure Size ==="
                echo "Actual:   $actualBytes bytes ($actualHuman)"
                echo "Expected: $expectedBytes bytes ($expectedHuman)"

                if [ "$actualBytes" != "$expectedBytes" ]; then
                  echo ""
                  echo "❌ MISMATCH!"
                  echo ""
                  echo "If this change is intentional, update closureChecks.${hostName}:"
                  echo "  bytes = $actualBytes;"
                  echo "  human = \"$actualHuman\";"
                  exit 1
                fi

                echo "✓ Match!"
              '';
        in
        {
          ${system}."closure-size-${hostName}" = checkDrv;
        };
    in
    {
      flake.checks = closureChecks |> lib.mapAttrsToList toClosureCheck |> lib.mkMerge;
      text.readme.parts.closure-checks = ''
        ## Closure Size Checks

        Closure sizes for specific configurations are monitored via snapshot tests.
        These are defined using the `closureChecks` option and automatically generate flake checks.

        The checks use `pkgs.closureInfo` to avoid IFD (import-from-derivation).

        See definition at [`closureChecks.nix`](modules/lib/options/closureChecks.nix).
      '';
    };
}
