{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.docker;
in {
  options.modules.docker = { enable = mkEnableOption "Docker module"; };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
    };

    environment.systemPackages = with pkgs; [ docker-compose ];

    home-manager.users.${config.user}.xdg.configFile."docker".source =
      ../../dotfiles/.config/docker;
  };
}
