{ config, lib, pkgs, ... }:
with lib;
let
  setMultiple = value: list: lib.genAttrs list (x: value);
  enableMultiple = list: setMultiple { enable = true; } list;
in {
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "desktop";
    wireless.enable = true;
  };

  time.timeZone = "Canada/Eastern";

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs;
      [
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
    initialPassword = "password";
  };

  environment.systemPackages = with pkgs; [ neovim git wget kitty xclip rofi ];

  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      displayManager.sddm.enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };

  system.stateVersion = "21.11";
}
