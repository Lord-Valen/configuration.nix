{
  inputs,
  cell,
}: {
  # magit +forge
  file.".authinfo.gpg".source = ./_authinfo.gpg;
  packages = with inputs.nixpkgs; [
    # Fonts
    fira-code

    # Doom Dependencies
    git
    (ripgrep.override {withPCRE2 = true;})
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
    ### cc
    clang
    clang-tools

    ### common-lisp
    sbcl

    ### haskell
    ghc
    cabal-install
    ormolu
    haskellPackages.haskell-language-server
    haskellPackages.hoogle

    ### javascript
    nodePackages.prettier

    ### latex
    texlive.combined.scheme-medium

    ### markdown
    mdl
    pandoc

    ### nix
    nixfmt
    nil

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
    nodePackages.bash-language-server

    ## :tools
    ### direnv
    direnv

    ### lookup
    sqlite
    wordnet

    ## :ui
    ### doom-dashboard
    emacs-all-the-icons-fonts
  ];
}
