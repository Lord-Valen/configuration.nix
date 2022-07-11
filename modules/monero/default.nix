{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.monero;
in {
  options.modules.monero = {
    enable = mkEnableOption "Monero modules";
    service = {
      enable = mkEnableOption "Monero service";
      mining.enable = mkEnableOption "Monero mining";
    };
    gui = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = {
    services = mkIf cfg.service.enable {
      monero.enable = true;
      monero.mining.enable = mkIf cfg.service.mining.enable true;
    };

    home-manager.users.${config.user}.home.packages =
      mkIf cfg.gui [ pkgs.monero-gui ];
  };
}
