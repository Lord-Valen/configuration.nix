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

    ## :lang
    ### common-lisp
    sbcl

    ### haskell
    ghc
    cabal-install
    haskellPackages.haskell-language-server
    haskellPackages.hoogle

    ### latex
    texlive.combined.scheme-full

    ### markdown
    mdl
    pandoc

    ### nix
    nixfmt
    rnix-lsp

    ### org
    graphviz
    sqlite

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
    emacsPackagesOverlay = self: super: {
      git-ontology-snippets = self.trivialBuild {
        pname = "git-ontology-snippets";
        ename = "git-ontology-snippets";
        version = "1.0.2";
        src = pkgs.fetchFromGitHub {
          owner = "Lord-Valen";
          repo = "git-ontology-snippets.el";
          rev = "fc0529";
          sha256 = "15y3y76xqw7qhd68vcdccyd7cv44pp9bblpi0z0m6rnhm6z14xgl";
        };
      };
    };
  };
}
