{ config, pkgs, lib, hm, ... }:
with lib;
let
  # doom-emacs = pkgs.callPackage (builtins.fetchTarball
  #   "https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz") {
  #     doomPrivateDir = ./config/doom;
  #   };

  setMultiple = value: list: lib.genAttrs list (x: value);
  enableMultiple = list: setMultiple { enable = true; } list;
in {
  imports = [ ./hardware-configuration.nix ];

  # nix = {
  #   package = pkgs.nixFlakes; # or versioned attributes like nix_2_7
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #   '';
  # };

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
    initialPassword = "password";
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

      ## :lang haskell
      haskellPackages.haskell-language-server
      haskellPackages.hoogle

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
    xsession.windowManager.xmonad.config = ./config/xmonad/xmonad.hs;

    # Doom config
    xdg.configFile."doom".source = builtins.fetchGit
      "https://github.com/Lord-Valen/doom-emacs-config.git"; # ./config/doom;
    xdg.configFile."emacs".source =
      builtins.fetchGit "https://github.com/hlissner/doom-emacs.git";

    programs.emacs = {
      enable = true;
      package = pkgs.emacsNativeComp;
    };

    services.emacs = {
      enable = true;
      defaultEditor = true;
      package = pkgs.emacsNativeComp;
    };
  };

  system.stateVersion = "22.05";
}
