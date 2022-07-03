{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  modules = {
    emacs = {
      enable = true;
      doom.enable = true;
    };
  };

  time.timeZone = "Canada/Eastern";
  i18n.defaultLocale = "en_CA.utf8";

  environment.systemPackages = with pkgs; [ neovim git ];

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # For pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      libinput.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;
    openssh.enable = true;
  };

  home-manager.users.lord-valen = {
    home.packages = with pkgs; [ brave discord vscode ghc ];
  };

  system.stateVersion = "22.05";
}
