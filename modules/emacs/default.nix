{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.emacs;
in {
  options.modules.emacs = {
    enable = mkEnableOption "Emacs module";
    doom = rec {
      enable = mkEnableOption "Doom Emacs autoinstall";
      forgeUrl = "https://github.com";
      doomUrl = mkOption {
        type = types.str;
        default = "${forgeUrl}/hlissner/doom-emacs.git";
      };
      configUrl = mkOption {
        type = types.str;
        default = "${forgeUrl}/Lord-Valen/doom-emacs-config.git";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.packages = with pkgs; [ git ];
    home-manager.users.lord-valen.home.packages = with pkgs; [
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
    ];

    services.emacs = {
      enable = true;
      defaultEditor = true;
      package = pkgs.emacsNativeComp;
    };

    system.userActivationScripts = mkIf cfg.doom.enable {
      doomEmacs = ''
        if [ -d "$HOME/.emacs.d ]; then
          rm -rf "$HOME/.emacs.d"
        fi
        if [ -d "$HOME/.doom.d ]; then
          rm -rf "$HOME/.doom.d"
        fi
        if [ ! -d "$XDG_CONFIG_HOME/doom" ]; then
          ${pkgs.git}/bin/git clone "https://github.com/Lord-Valen/doom-emacs-config.git" "$XDG_CONFIG_HOME/doom"
        fi
        if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
          ${pkgs.git}/bin/git clone --depth=1 --single-branch "https://github.com/hlissner/doom-emacs.git" "$XDG_CONFIG_HOME/emacs"
        fi
      '';
    };
  };
}
