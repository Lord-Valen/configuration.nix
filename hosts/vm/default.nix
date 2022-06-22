{ config, pkgs, lib, hm, ... }:
with lib;
let
  setMultiple = value: list: lib.genAttrs list (x: value);
  enableMultiple = list: setMultiple { enable = true; } list;
in {
  imports = [ ./hardware-configuration.nix ];

  modules = {
    emacs = {
      enable = true;
      doom.enable = true;
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Canada/Eastern";

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      pkgs.emacs-all-the-icons-fonts
      (nerdfonts.override {
        fonts = [ "FiraCode" "FiraMono" "Noto" "Ubuntu" ];
      })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "FiraCode" ];
        sansSerif = [ "FiraCode" ];
        monospace = [ "FiraMono" ];
        emoji = [ "Noto" ];
      };
    };
  };

  users.users.lord-valen = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
    initialPassword = "lv";
  };

  environment.systemPackages = with pkgs; [ neovim git wget xclip ];

  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      displayManager.sddm.enable = true;
      windowManager.xmonad =
        setMultiple true [ "enable" "enableContribAndExtras" ];
    };
  };

  home-manager.users.lord-valen = {
    home.packages = with pkgs; [
      # XMonad-config Dependencies
      xmobar
      xscreensaver
      rofi
      kitty
      trayer
    ];

    # XMonad config
    xdg.configFile."xmonad".source =
      builtins.fetchGit "https://github.com/Lord-Valen/xmonad-config.git";
    # xsession.windowManager.xmonad.config = ./config/xmonad/xmonad.hs;
  };

  system.stateVersion = "22.05";
}
