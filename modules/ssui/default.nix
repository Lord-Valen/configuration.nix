# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{ ... }:
{
  flake.overlays.ssui = _final: prev: {
    ssui = prev.callPackage ./_package.nix { };
    ssui-unwrapped = prev.callPackage ./_unwrapped.nix { };
  };
}
