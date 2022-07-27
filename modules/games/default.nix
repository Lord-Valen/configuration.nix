{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.games;
in {
  options.modules.games = { enable = mkEnableOption "Gaming module"; };

  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
      };
      gamemode.enable = true;
    };

    hardware = { steam-hardware.enable = true; };

    home-manager.users.${config.user}.home.packages = with pkgs; [
      protonup
      heroic
      lutris
      polymc
    ];
  };
}
