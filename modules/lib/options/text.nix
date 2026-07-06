# SPDX-FileCopyrightText: 2024 Shahar "Dawn" Or
#
# SPDX-License-Identifier: MIT

{ lib, ... }:
{
  options.text = lib.mkOption {
    default = { };
    type = lib.types.lazyAttrsOf (
      lib.types.oneOf [
        (lib.types.separatedString "")
        (lib.types.submodule {
          options = {
            parts = lib.mkOption {
              type = lib.types.lazyAttrsOf lib.types.str;
            };
            order = lib.mkOption {
              type = lib.types.listOf lib.types.str;
            };
          };
        })
      ]
    );
    apply = lib.mapAttrs (
      _name: text:
      if lib.isAttrs text then
        lib.pipe text.order [
          (map (lib.flip lib.getAttr text.parts))
          # SPDX-SnippetBegin
          # SPDX-SnippetCopyrightText: 2026 Lord-Valen
          # SPDX-License-Identifier: MIT
          (lib.concatStringsSep "\n\n")
          # SPDX-SnippetEnd
        ]
      else
        text
    );
  };
}
