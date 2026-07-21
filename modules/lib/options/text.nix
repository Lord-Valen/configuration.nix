# SPDX-FileCopyrightText: 2024 Shahar "Dawn" Or
#
# SPDX-License-Identifier: MIT

{ lib, ... }:
let
  # SPDX-SnippetBegin
  # SPDX-SnippetCopyrightText: 2026 Lord-Valen
  # SPDX-License-Identifier: MIT
  partType = lib.types.submodule {
    options = {
      text = lib.mkOption {
        type = lib.types.str;
        description = "The part's own markdown content.";
      };
      source = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          Optional path this part is written at. When set, a footnote
          marker is appended to the part and its definition collected
          into a footnotes block at the end of the document.
        '';
      };
    };
  };
  # SPDX-SnippetEnd
in
{
  options.text = lib.mkOption {
    default = { };
    type = lib.types.lazyAttrsOf (
      lib.types.oneOf [
        (lib.types.separatedString "")
        (lib.types.submodule {
          options = {
            parts = lib.mkOption {
              type = lib.types.lazyAttrsOf (lib.types.oneOf [ lib.types.str partType ]);
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
      if !lib.isAttrs text then
        text
      else
        let
          normalize = part: if lib.isAttrs part then part else { text = part; source = null; };
          slugify = builtins.replaceStrings [ "/" "." ] [ "-" "-" ];
          ordered = map (name: normalize text.parts.${name}) text.order;
          footnote = p: "[^${slugify p.source}]: Written at [`${builtins.baseNameOf p.source}`](${p.source}).";
          body = map (
            p: lib.trim p.text + lib.optionalString (p.source != null) " [^${slugify p.source}]"
          ) ordered;
          footnotes = lib.unique (map footnote (lib.filter (p: p.source != null) ordered));
        in
        lib.concatStringsSep "\n\n" (
          body ++ lib.optional (footnotes != [ ]) (lib.concatStringsSep "\n" footnotes)
        )
    );
    # SPDX-SnippetEnd
  };
}
