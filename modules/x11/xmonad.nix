{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.x11.xmonad;
in {
  options.modules.x11.xmonad = {
    enable = mkEnableOption "XMonad module";
    configUrl = mkOption {
      type = types.str;
      default = "https://github.com/Lord-Valen/xmonad-config.git";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      displayManager.lightdm.enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };

    environment.systemPackages = with pkgs; [
      git
      xmobar
      xscreensaver
      rofi
      kitty
      trayer
    ];

    environment.sessionVariables = {
      XMONAD_CONFIG_DIR = "$XDG_CONFIG_HOME/xmonad";
      XMONAD_DATA_DIR = "$XDG_DATA_HOME/xmonad";
      XMONAD_CACHE_DIR = "$XDG_CACHE_HOME/xmonad";
    };

    system.userActivationScripts.xmonad = ''
      if [ -d "$HOME/.xmonad ]; then
        rm -rf "$HOME/.xmonad"
      fi
      if [ ! -d "$XDG_CONFIG_HOME/xmonad" ]; then
        ${pkgs.git}/bin/git clone "${cfg.configUrl}" "$XDG_CONFIG_HOME/xmonad"
      fi
      ${pkgs.git}/bin/git -C $XDG_CONFIG_HOME/xmonad pull
    '';
  };
}
