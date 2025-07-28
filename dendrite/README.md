## Unfree packages

Which unfree packages are allowed is configured at the flake level via an option.
That is then used in the configuration of Nixpkgs.
See definition at [`unfree-packages.nix`](modules/lib/options/unfree-packages.nix).
See usage at [`vscode`](modules/community/vscode/default.nix).
The value of this option is available as a flake output:

```console
$ nix eval .#meta.nixpkgs.allowedUnfreePackages
```
