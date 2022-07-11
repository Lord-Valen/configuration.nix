{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.x11.gnome;
in {
  options.modules.x11.gnome = { enable = mkEnableOption "GNOME module"; };

  config = mkIf cfg.enable {
    # services.xserver = {
    #   displayManager.gdm.enable = true;
    #   desktopManager.gnome.enable = true;
    # };
  };
}
