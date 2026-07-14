{ config, ... }:
{
  text.readme = {
    order = [
      "header"
      "inputs-management"
      "hosts"
      "closure-checks"
    ];

    parts.header = ''
      <!-- This file is generated. Do not edit directly. -->
      <!-- Source: modules/meta/files/readme.nix. Regenerate with write-files (available in devshell). -->
    '';

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

      See definition at [`readme.nix`](modules/meta/files/readme.nix).
    '';
  };

  perSystem =
    { ... }:
    {
      files.file."README.md".text = config.text.readme;
    };
}
