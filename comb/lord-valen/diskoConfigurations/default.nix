{
  inputs,
  cell,
}: let
  inherit (cell) lib;
  inherit (lib) haumea;

  load = src:
    haumea.lib.load {
      inherit src;
      loader = haumea.lib.loaders.scoped;
      transformer = haumea.lib.transformers.liftDefault;
    };

  hosts = lib.loadAll load ./src;
in
  hosts
