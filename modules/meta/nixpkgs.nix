# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (pkg.pname or (builtins.parseDrvName pkg.name).name) [
            "ssui-unwrapped"
            "steamcmd"
            "steam-unwrapped"
          ];
      };
    };
}
