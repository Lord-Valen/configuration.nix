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

    system.userActivationScripts.xmonad = ''
      if [ ! -d "$HOME/.xmonad" ]; then
        ${pkgs.git}/bin/git clone "${cfg.configUrl}" "$HOME/.xmonad"
      fi
      ${pkgs.git}/bin/git -C $HOME/.xmonad pull
    '';
  };
}
