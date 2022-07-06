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
    # For use in the activation script
    environment.systemPackages = [ pkgs.git ];
    home-manager.users.${config.user}.home.packages = with pkgs; [
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
      ## :tools lsp
      nodePackages.npm

      ## :lang common-lisp
      sbcl

      ## :lang haskell
      cabal-install
      haskellPackages.haskell-language-server
      haskellPackages.hoogle

      ## :lang nix
      nixfmt

      ## :lang org
      graphviz

      ## :lang rust
      rust-analyzer
      cargo
      rustc

      ## :lang sh
      shellcheck

      ## :app everywhere
      xorg.xwininfo
      xdotool
      xclip
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
          ${pkgs.git}/bin/git clone "${cfg.doom.configUrl}" "$XDG_CONFIG_HOME/doom"
        fi
        if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
          ${pkgs.git}/bin/git clone --depth=1 --single-branch "${cfg.doom.doomUrl}" "$XDG_CONFIG_HOME/emacs"
        fi
        ${pkgs.git}/bin/git -C $XDG_CONFIG_HOME/doom pull
      '';
    };
  };
}
