<!-- This file is generated. Do not edit directly. -->
<!-- Source: modules/meta/files/readme.nix. Regenerate with write-files (available in devshell). -->

## Input Management

Inputs are pinned with [nixtamal](https://nixtamal.toast.al) and resolved with
[with-inputs](https://github.com/denful/with-inputs).
There is no `flake.lock`; pins live in [`nix/tamal/lock.json`](nix/tamal/lock.json).

### Entry points

| File | Purpose |
|------|---------|
| `default.nix` | Primary entry point; returns full flake outputs |
| `configuration.nix` | Convenience entry point; selects the NixOS config for the current hostname |
| `flake.nix` | Thin shim so flake-aware tools (cachix, etc.) still work |

### Switching

```bash
nh os switch -f ./configuration.nix
```

### Updating inputs

```bash
nixtamal refresh             # refresh all non-frozen inputs
nixtamal refresh <name>      # refresh one input
nixtamal check-soundness     # verify all fetches resolve
```

## Hosts

The set of NixOS hosts is defined via an option which accepts deferred modules.
Differentiating the hosts as a subset of the NixOS modules allows us to map over the hosts
without string matching.

See definition at [`hosts.nix`](modules/lib/options/hosts.nix).
See usage at [`autolycus`](modules/hosts/autolycus/default.nix).
## Closure Checks

Closure size checks are defined via the `closureChecks` option.
Each entry logs the human-readable closure size; an optional `budget` field causes the check to fail if the size exceeds it.

See definition at [`closureChecks.nix`](modules/lib/options/closureChecks.nix).
See checks at [`closureChecks/`](modules/closureChecks/).
