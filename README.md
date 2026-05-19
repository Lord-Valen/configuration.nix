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
