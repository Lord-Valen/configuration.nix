# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{ lib, inputs, ... }:
{
  options.text = lib.mkOption {
    default = { };
    description = "Documents assembled from mdnix blocks, rendered to markdown text.";
    type = lib.types.lazyAttrsOf (
      lib.types.oneOf [
        (lib.types.separatedString "")
        (lib.types.listOf lib.types.attrs)
        (lib.types.submodule {
          options = {
            parts = lib.mkOption {
              type = lib.types.lazyAttrsOf (lib.types.listOf lib.types.attrs);
              description = "Named lists of mdnix blocks, assembled per `order`.";
            };
            order = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              description = "Part names, in the order they're assembled.";
            };
          };
        })
      ]
    );
    apply = lib.mapAttrs (
      _name: value:
      if lib.isString value then
        value
      else
        inputs.mdnix.lib.render (
          if lib.isList value then value else lib.concatMap (name: value.parts.${name}) value.order
        )
    );
  };

  config.flake.lib.writtenAt =
    path:
    let
      mdnix = inputs.mdnix.lib;
      id = builtins.replaceStrings [ "/" "." ] [ "-" "-" ] path;
    in
    {
      inherit id;
      footnote = mdnix.fn id "Written at [`${builtins.baseNameOf path}`](${path}).";
    };
}
