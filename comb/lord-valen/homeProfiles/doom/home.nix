{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  # :tools magit
  ## forge
  file.".authinfo.gpg".source = ./_authinfo.gpg;
  packages = with nixpkgs;
    cell.lib.concatLists [
      [
        # Other stuff
        fira-code
        nushell
      ]
      [
        # Doom Dependencies
        git
        (ripgrep.override {withPCRE2 = true;})
        gnutls
      ]
      [
        # Doom Optional Dependencies
        fd
        imagemagick
        zstd
      ]
      [
        # :app everywhere
        xclip
        xdotool
        xorg.xprop
        xorg.xwininfo
      ]
      [
        # :checkers grammar
        languagetool
      ]
      [
        # :checkers spell
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
      ]
      [
        # :lang cc
        clang
        clang-tools
      ]
      [
        # :lang common-lisp
        sbcl
      ]
      [
        # :lang haskell
        ghc
        cabal-install
        ormolu
        haskellPackages.hoogle

        ## lsp
        haskell-language-server
      ]
      [
        # :lang javascript
        nodejs
        nodePackages.npm
        nodePackages.prettier

        ## lsp
        nodePackages.typescript-language-server
      ]
      [
        # :lang json
        nodePackages.prettier
        ## lsp
        nodePackages.vscode-langservers-extracted
      ]
      [
        # :lang kotlin
        kotlin
        ktlint
        ## lsp
        kotlin-language-server
      ]
      [
        # :lang latex
        texlive.combined.scheme-full
      ]
      [
        # :lang markdown
        marksman
        pandoc
        nodePackages.prettier
      ]
      [
        # :lang nix
        ## lsp
        nil
      ]
      [
        # :lang org
        graphviz
        ## latex
        texlive.combined.scheme-full
        ## roam
        sqlite
      ]
      [
        # :lang rust
        rustc
        cargo
        rustfmt
        ## lsp
        rust-analyzer
      ]
      [
        # :lang toml
        taplo
      ]
      [
        # :lang sh
        shfmt
        shellcheck
        ## lsp
        nodePackages.bash-language-server
      ]
      [
        # :lang yaml
        ## lsp
        nodePackages.yaml-language-server
      ]
      [
        # :term vterm
        libvterm
      ]
      [
        # :tools direnv
        direnv
      ]
      [
        # :tools editorconfig
        editorconfig-core-c
      ]
      [
        # :tools lsp
        unzip
        python3Full
        cargo
        nodejs
        nodePackages.npm
      ]
      [
        # :tools lookup
        ripgrep
        sqlite
        wordnet
      ]
      [
        # :ui doom-dashboard
        emacs-all-the-icons-fonts
      ]
    ];
}
