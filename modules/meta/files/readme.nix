{ config, inputs, ... }:
let
  mdnix = inputs.mdnix.lib;
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
      (mdnix.h 2 "How This README Is Generated" |> config.flake.lib.writtenAt "modules/meta/files/readme.nix")
      (mdnix.p [
        (mdnix.text ''
          Each section is contributed by whichever module it documents, via
          `text.readme.parts.<name>`, and assembled in the order listed by
          `text.readme.order`. For example, the Hosts section below comes from
        '')
        (mdnix.ln "`hosts.nix`" "modules/lib/options/hosts.nix")
        (mdnix.text ''
          , not this file -
          each module documents itself next to its own definition rather than everything
          living in one place.'')
      ])
      (mdnix.p "Regenerate after editing any `parts.*` with:")
      (mdnix.lang "bash" (mdnix.code "write-files"))
      (mdnix.p "(available in the devshell).")
    ];

  };

  perSystem =
    { ... }:
    {
      files.file."README.md".text = config.text.readme;
    };
}
