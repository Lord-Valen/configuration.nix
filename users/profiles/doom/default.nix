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
    emacs-all-the-icons-fonts

    # Doom Module Dependencies
    ## :tools lsp
    unzip
    python3Full
    nodejs
    nodePackages.npm

    ## :lang cc
    ghc
    glslang

    ## :lang common-lisp
    sbcl

    ## :lang haskell
    ghc
    cabal-install
    haskellPackages.haskell-language-server
    haskellPackages.hoogle

    ## :lang nix
    nixfmt
    rnix-lsp

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
