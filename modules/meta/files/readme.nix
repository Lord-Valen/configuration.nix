{ config, inputs, ... }:
let
  mdnix = inputs.mdnix.lib;
  at = config.flake.lib.writtenAt "modules/meta/files/readme.nix";
in
{
  text.readme = {
    order = [
      "header"
      "how-this-works"
      "inputs-management"
      "hosts"
      "closure-checks"
    ];

    parts.header = [
      (mdnix.p ''
        <!-- This file is generated. Do not edit directly. -->
        <!-- Source: modules/meta/files/readme.nix. Regenerate with write-files (available in devshell). -->
      '')
    ];

    parts.how-this-works = [
      (mdnix.refs [ at.id ] (mdnix.h 2 "How This README Is Generated"))
      (mdnix.p [
        (mdnix.text ''
          Each section is contributed by whichever module it documents, via
          `text.readme.parts.<name>`, and assembled in the order listed by
          `text.readme.order`. For example, the Hosts section below comes from
        '')
        (mdnix.ln "`modules/lib/options/hosts.nix`" "modules/lib/options/hosts.nix")
        (mdnix.text ''
          , not this file -
          each module documents itself next to its own definition rather than everything
          living in one place.'')
      ])
      (mdnix.p "Regenerate after editing any `parts.*` with:")
      (mdnix.lang "bash" (mdnix.code "write-files"))
      (mdnix.p "(available in the devshell).")
      at.footnote
    ];

    parts.inputs-management = [
      (mdnix.h 2 "Input Management")
      (mdnix.p [
        (mdnix.text "Inputs are pinned with ")
        (mdnix.ln "nixtamal" "https://nixtamal.toast.al")
        (mdnix.text " and resolved with ")
        (mdnix.ln "with-inputs" "https://github.com/denful/with-inputs")
        (mdnix.text ''
          .
          There is no `flake.lock`; pins live in
        '')
        (mdnix.ln "`nix/tamal/lock.json`" "nix/tamal/lock.json")
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
    ];
  };

  perSystem =
    { ... }:
    {
      files.file."README.md".text = config.text.readme;
    };
}
