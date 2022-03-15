{ config, lib, pkgs, ... }:
with lib;
let
  # doom-emacs = pkgs.callPackage (builtins.fetchTarball
  #   "https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz") {
  #     doomPrivateDir = ./config/doom;
  #   };
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  emacs-overlay = builtins.fetchTarball
    "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  setMultiple = value: list: lib.genAttrs list (x: value);
  enableMultiple = list: setMultiple { enable = true; } list;
in {
  imports = [ ./hardware-configuration.nix (import "${home-manager}/nixos") ];

  nixpkgs.overlays = [ (import "${emacs-overlay}") ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "desktop";
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
    initialPassword = "password";
  };

  environment.systemPackages = with pkgs; [ neovim git wget kitty xclip rofi ];

  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      displayManager.sddm.enable = true;
    };
  };

  home-manager.users.lord-valen = {
    home.packages = with pkgs; [
      # Doom Dependencies
      git
      (ripgrep.override { withPCRE2 = true; })
      gnutls

      # Doom Optional Dependencies
      fd
      imagemagick
      (mkIf (config.programs.gnupg.agent.enable) pinentry_emacs)
      zstd

      # Doom Module Dependencies
      ## :lang nix
      nixfmt
    ];

    # XMonad config
    xdg.configFile."xmonad/xpm".source = ./config/xmonad/xpm;
    xsession.windowManager.xmonad = {
      config = ./config/xmonad/xmonad.hs;
    } // setMultiple true [ "enable" "enableContribAndExtras" ];

    # Doom config
    xdg.configFile."doom".source = ./config/doom;
    xdg.configFile."emacs".source =
      builtins.fetchGit "https://github.com/hlissner/doom-emacs.git";
    services.emacs = {
      enable = true;
      defaultEditor = true;
      package = pkgs.emacsGcc;
    };
  };

  system.stateVersion = "21.11";
}
