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

## Hosts

The set of NixOS hosts is defined via an option which accepts deferred modules.
Differentiating the hosts as a subset of the NixOS modules allows us to map over the hosts
without string matching.

See usage at [`autolycus`](modules/hosts/autolycus/default.nix).

## Closure Checks

Closure size checks are defined via the `closureChecks` option.
Each entry logs the human-readable closure size; an optional `budget` field causes the check to fail if the size exceeds it.

See checks at [`closureChecks/`](modules/closureChecks/).