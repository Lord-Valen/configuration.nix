{
  inputs,
  cell,
}: let
  inherit (cell.lib) haumea;
  # load = src: haumea.lib.load {
  #   inherit src;
  #   loader = haumea.lib.loaders.verbatim;
  #   transformer = haumea.lib.transformers.liftDefault;
  # };
in {
  services.p2pool = import ./src/services/p2pool;
}
