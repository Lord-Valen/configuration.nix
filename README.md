## Unfree packages

Which unfree packages are allowed is configured at the flake level via an option.
That is then used in the configuration of Nixpkgs.
See definition at [`unfree-packages.nix`](modules/lib/options/unfree-packages.nix).
See usage at [`vscode`](modules/community/vscode/+unfree.nix).
The value of this option is available as a flake output:

```console
$ nix eval .#meta.nixpkgs.allowedUnfreePackages
```
## Hosts

The set of NixOS hosts is defined via an option which accepts deferred modules.
Differentiating the hosts as a subset of the NixOS modules allows us to map over the hosts
both when generating NixOS configurations and when defining checks for the flake.

See definition at [`hosts.nix`](modules/lib/options/hosts.nix).
See usage at [`autolycus`](modules/hosts/autolycus/default.nix).
