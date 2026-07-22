<!-- This file is generated. Do not edit directly. -->
<!-- Source: modules/meta/files/readme.nix. Regenerate with write-files (available in devshell). -->

## How This README Is Generated[^modules-meta-files-readme-nix]

Each section is contributed by whichever module it documents, via
`text.readme.parts.<name>`, and assembled in the order listed by
`text.readme.order`. For example, the Hosts section below comes from
[`hosts.nix`](modules/lib/options/hosts.nix), not this file -
each module documents itself next to its own definition rather than everything
living in one place.

Regenerate after editing any `parts.*` with:

```bash
write-files
```

(available in the devshell).

## Input Management[^modules-meta-inputs-nix]

Inputs are pinned with [nixtamal](https://nixtamal.toast.al) and resolved with [with-inputs](https://github.com/denful/with-inputs).
There is no `flake.lock`; pins live in
[`lock.json`](nix/tamal/lock.json).

### Entry points

| File | Purpose |
| --- | --- |
| `default.nix` | Primary entry point; returns full flake outputs |
| `system.nix` | Convenience entry point; selects the NixOS config for the current hostname (impure - reads `/etc/hostname`) |
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

## Hosts[^modules-lib-options-hosts-nix]

The set of NixOS hosts is defined via an option which accepts deferred modules.
Differentiating the hosts as a subset of the NixOS modules allows us to map over the hosts
without string matching.

See usage at [`autolycus`](modules/hosts/autolycus/default.nix).

## Closure Checks[^modules-lib-options-closureChecks-nix]

Closure size checks are defined via the `closureChecks` option.
Each entry logs the human-readable closure size; an optional `budget` field causes the check to fail if the size exceeds it.

See checks at [`closureChecks/`](modules/closureChecks/).

[^modules-meta-files-readme-nix]: Written at [`readme.nix`](modules/meta/files/readme.nix).

[^modules-meta-inputs-nix]: Written at [`inputs.nix`](modules/meta/inputs.nix).

[^modules-lib-options-hosts-nix]: Written at [`hosts.nix`](modules/lib/options/hosts.nix).

[^modules-lib-options-closureChecks-nix]: Written at [`closureChecks.nix`](modules/lib/options/closureChecks.nix).