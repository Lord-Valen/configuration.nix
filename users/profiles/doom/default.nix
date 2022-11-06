{ config, lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Doom Dependencies
    git
    (ripgrep.override { withPCRE2 = true; })
    gnutls

    # Doom Optional Dependencies
    fd
    imagemagick
    zstd

    # Doom Module Dependencies
    ## :app
    ### everywhere
    xclip
    xdotool
    xorg.xprop
    xorg.xwininfo

    ## :checkers
    ### grammar
    languagetool

    ### spell
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    ## :tools
    ### lsp
    unzip
    python3Full
    nodejs
    nodePackages.npm
    nodePackages.prettier

    ## :lang
    ### common-lisp
    sbcl

    ### haskell
    ghc
    cabal-install
    ormolu
    haskellPackages.haskell-language-server
    haskellPackages.hoogle

    ### latex
    texlive.combined.scheme-full

    ### markdown
    mdl
    pandoc

    ### nix
    nixfmt
    nil
    # rnix-lsp

    ### org
    graphviz

    ### rust
    rustc
    cargo
    rustfmt
    rust-analyzer

    ### sh
    shfmt
    shellcheck

    ## :term
    ### eshell
    bash

    ## :tools
    ### direnv
    direnv

    ## :ui
    ### doom-dashboard
    emacs-all-the-icons-fonts
  ];

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };
}
