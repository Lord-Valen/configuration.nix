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
    # SPDX-SnippetBegin
    # SPDX-SnippetCopyrightText: 2026 Lord-Valen
    # SPDX-License-Identifier: MIT
    apply = lib.mapAttrs (
      _name: text:
      if lib.isAttrs text then
        text.order
        |> map (lib.flip lib.getAttr text.parts)
        |> map lib.trim
        |> lib.concatStringsSep "\n\n"
      else
        text
    );
    # SPDX-SnippetEnd
  };
}
