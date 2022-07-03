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

  environment.systemPackages = with pkgs; [ neovim git ];

  users.users.lord-valen = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "lv";
  };

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
