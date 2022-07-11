{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.tidal;
in {
  options.modules.tidal = { enable = mkEnableOption "TidalCycles module"; };

  config = mkIf cfg.enable {
    home-manager.users.${config.user}.home.packages = with pkgs; [
      supercollider
      haskellPackages.tidal
    ];
  };
}
