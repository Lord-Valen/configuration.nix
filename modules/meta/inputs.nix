# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{ config, inputs, ... }:
let
  mdnix = inputs.mdnix.lib;
  at = config.flake.lib.writtenAt "modules/meta/inputs.nix";
in
{
  text.readme.parts.inputs-management = [
    (mdnix.refs [ at.id ] (mdnix.h 2 "Input Management"))
    (mdnix.p [
      (mdnix.text "Inputs are pinned with ")
      (mdnix.ln "nixtamal" "https://nixtamal.toast.al")
      (mdnix.text " and resolved with ")
      (mdnix.ln "with-inputs" "https://github.com/denful/with-inputs")
      (mdnix.text ''
        .
        There is no `flake.lock`; pins live in
      '')
      (mdnix.ln "`lock.json`" "nix/tamal/lock.json")
      (mdnix.text ".")
    ])

    (mdnix.h 3 "Entry points")
    (mdnix.table [ "File" "Purpose" ] [
      [ "`default.nix`" "Primary entry point; returns full flake outputs" ]
      [
        "`system.nix`"
        "Convenience entry point; selects the NixOS config for the current hostname (impure - reads `/etc/hostname`)"
      ]
      [ "`flake.nix`" "Thin shim so flake-aware tools still work" ]
    ])

    (mdnix.h 3 "Switching")
    (mdnix.lang "bash" (mdnix.code "nh os switch -f ./system.nix"))

    (mdnix.h 3 "Updating inputs")
    (mdnix.lang "bash" (
      mdnix.code ''
        nixtamal refresh             # refresh all non-frozen inputs
        nixtamal refresh <name>      # refresh one input
        nixtamal check-soundness     # verify all fetches resolve
      ''
    ))
    at.footnote
  ];
}
