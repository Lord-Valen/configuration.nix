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
    services = {
      picom = {
        enable = true;
        inactiveOpacity = 0.8;
        menuOpacity = 0.8;
        opacityRules = [ "100:class_g = 'zoom'" ];
        fade = true;
        vSync = true;
        settings = {
          frame-opacity = 0.6;
          blur = {
            method = "kawase";
            strength = 3;
            background = false;
            background-frame = false;
            background-fixed = false;
            kern = "3x3box";
          };
        };
      };

      xserver = {
        displayManager.lightdm.enable = true;
        windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
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

    system.userActivationScripts.xmonad = ''
      if [ ! -d "$HOME/.xmonad" ]; then
        ${pkgs.git}/bin/git clone "${cfg.configUrl}" "$HOME/.xmonad"
      fi
      ${pkgs.git}/bin/git -C $HOME/.xmonad pull
    '';
  };
}
