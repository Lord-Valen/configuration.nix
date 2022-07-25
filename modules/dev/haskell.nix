{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.dev.haskell;
in {
  options.modules.dev.haskell = {
    enable = mkEnableOption "haskell.nix module";
  };

  config = mkIf cfg.enable {
    nix.settings = {
      trusted-public-keys =
        [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
      substituters = [ "https://cache.iog.io" ];
    };
  };
}
