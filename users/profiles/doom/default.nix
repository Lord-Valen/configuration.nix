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
      # git-ontology-snippets = self.trivialBuild {
      #   pname = "git-ontology-snippets";
      #   ename = "git-ontology-snippets";
      #   version = "2.0.1";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "Lord-Valen";
      #     repo = "git-ontology-snippets.el";
      #     rev = "0d0e0d9904f0bd8eeefccbf1b49811e53f04f692";
      #     sha256 = "02q072lcf96j0mbaix6z1d1v9q88bgzc3iwdz3g7q591w7p0p04s";
      #   };
      # };
    };
  };
}
