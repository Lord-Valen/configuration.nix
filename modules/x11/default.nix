{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.x11;
in {
  imports = [ ./gnome.nix ./xmonad.nix ];

  options.modules.x11 = {
    enable = mkEnableOption "xserver";
    layout = mkOption {
      type = types.str;
      default = "us";
    };
    xkbVariant = mkOption {
      type = types.str;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      layout = cfg.layout;
      xkbVariant = cfg.xkbVariant;
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
    };
  };
}
