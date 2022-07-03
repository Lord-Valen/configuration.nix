{ config, pkgs, lib, hm, ... }:

with lib;

# let
#   setMultiple = value: list: lib.genAttrs list (x: value);
#   enableMultiple = list: setMultiple { enable = true; } list;
# in
{
  imports = [ ./hardware-configuration.nix ];

  modules = {
    emacs = {
      enable = true;
      doom.enable = true;
    };
    pipewire.enable = true;
    x11 = {
      enable = true;
      gnome.enable = true;
    };
  };

  time.timeZone = "Canada/Eastern";
  i18n.defaultLocale = "en_CA.UTF-8";

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
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
