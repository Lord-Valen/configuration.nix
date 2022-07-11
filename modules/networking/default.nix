{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.networking;
in {
  options.modules.networking = { enable = mkEnableOption "Networking module"; };

  config = mkIf cfg.enable {
    networking.wireless.iwd.enable = true;
    networking.networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    programs.nm-applet.enable = true;
  };
}
