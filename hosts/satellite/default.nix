{ config, pkgs, lib, hm, ... }:

with lib;

let
  setMultiple = value: list: lib.genAttrs list (x: value);
  enableMultiple = list: setMultiple { enable = true; } list;
in {
  imports = [ ./hardware-configuration.nix ];

  modules = setMultiple true [ emacs emacs.doom pipewire ];

  time.timeZone = "Canada/Eastern";
  i18n.defaultLocale = "en_CA.UTF-8";

  environment.systemPackages = with pkgs; [ neovim git ];

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      libinput.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    printing.enable = true;
    openssh.enable = true;
  };

  home-manager.users.lord-valen.home.packages = with pkgs; [
    brave
    discord
    vscode
    ghc
  ];

  system.stateVersion = "22.05";
}
