{ config, ... }:
{
  text.readme = {
    order = [
      "header"
      "how-this-works"
      "inputs-management"
      "hosts"
      "closure-checks"
    ];

    parts.header = ''
      <!-- This file is generated. Do not edit directly. -->
      <!-- Source: modules/meta/files/readme.nix. Regenerate with write-files (available in devshell). -->
    '';

    parts.how-this-works = {
      source = "modules/meta/files/readme.nix";
      text = ''
        ## How This README Is Generated

        Each section is contributed by whichever module it documents, via
        `text.readme.parts.<name>`, and assembled in the order listed by
        `text.readme.order`. For example, the Hosts section below comes from
        [`modules/lib/options/hosts.nix`](modules/lib/options/hosts.nix), not this file -
        each module documents itself next to its own definition rather than everything
        living in one place.

        Regenerate after editing any `parts.*` with:

        ```bash
        write-files
        ```

        (available in the devshell).
      '';
    };

    parts.inputs-management = ''
      ## Input Management

      Inputs are pinned with [nixtamal](https://nixtamal.toast.al) and resolved with
      [with-inputs](https://github.com/denful/with-inputs).
      There is no `flake.lock`; pins live in [`nix/tamal/lock.json`](nix/tamal/lock.json).

      ### Entry points

      | File | Purpose |
      |------|---------|
      | `default.nix` | Primary entry point; returns full flake outputs |
      | `system.nix` | Convenience entry point; selects the NixOS config for the current hostname (impure — reads `/etc/hostname`) |
      | `flake.nix` | Thin shim so flake-aware tools still work |

      ### Switching

      ```bash
      nh os switch -f ./system.nix
      ```

      ### Updating inputs

      ```bash
      nixtamal refresh             # refresh all non-frozen inputs
      nixtamal refresh <name>      # refresh one input
      nixtamal check-soundness     # verify all fetches resolve
      ```
    '';
  };

  perSystem =
    { ... }:
    {
      files.file."README.md".text = config.text.readme;
    };
}
