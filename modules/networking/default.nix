{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.networking;
in {
  options.modules.networking = {
    enable = mkEnableOption "Networking module";
    IPv6 = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    networking = {
      enableIPv6 = mkIf cfg.IPv6 true;
      wireless.iwd.enable = true;
      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };
    };
    programs.nm-applet.enable = true;
  };
}
