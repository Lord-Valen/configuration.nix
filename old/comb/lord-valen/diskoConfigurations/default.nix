{ inputs, cell }:
let # compat wrapper for haumea.lib.load
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.std.inputs) haumea;
  load =
    {
      inputs,
      cell,
      src,
    }:
    # modules/profiles are always functions
    args:
    let
      i = args // {
        inherit cell inputs;
      };
      defaultWith = import (haumea + /src/loaders/__defaultWith.nix) { inherit lib; };
      loader = defaultWith (scopedImport i) i;
    in
    if lib.pathIsDirectory src then
      haumea.lib.load {
        inherit src;
        loader = haumea.lib.loaders.scoped;
        transformer = with haumea.lib.transformers; [
          liftDefault
          (hoistLists "_imports" "imports")
        ];
        inputs = i;
      }
    # Mimic haumea for a regular file
    else
      loader src;

  findLoad =
    {
      inputs,
      cell,
      block,
    }:
    with builtins;
    lib.mapAttrs' (
      n: _:
      lib.nameValuePair (lib.removeSuffix ".nix" n) (load {
        inherit inputs cell;
        src = block + /${n};
      })
    ) (removeAttrs (readDir block) [ "default.nix" ]);
in
findLoad {
  inherit inputs cell;
  block = ./.;
}
