# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{ config, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.ssui = pkgs.callPackage ./_package.nix { };
      packages.ssui-unwrapped = pkgs.callPackage ./_unwrapped.nix { };
    };
  flake.overlays.ssui = final: prev: {
    ssui = prev.callPackage ./_package.nix { };
    ssui-unwrapped = prev.callPackage ./_unwrapped.nix { };
  };
}
