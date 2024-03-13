{
  inputs,
  cell,
  config,
  pkgs,
  lib,
}:
{
  # :tools magit
  ## forge
  file.".authinfo.gpg".source = ./_authinfo.gpg;
  packages =
    with pkgs;
    lib.concatLists [
      [
        # My Dependencies
        (nerdfonts.override { fonts = [ "Iosevka" ]; })
        (iosevka-bin.override { variant = "aile"; })
        noto-fonts-emoji
        config.programs.nushell.package
      ]
      [
        # Doom Dependencies
        git
        (ripgrep.override { withPCRE2 = true; })
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
        ## extra
        gf
      ]
      [
        # :lang common-lisp
        sbcl
      ]
      [
        # :lang coq
        coq
      ]
      [
        # :lang csharp
        mono
        ## lsp
        omnisharp-roslyn
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
        bun

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
        nixd
        alejandra
      ]
      (lib.flatten [
        # :lang ocaml
        ocaml
        opam
        dune_3
        (with ocamlPackages; [
          utop
          ocp-indent
          #merlin # -lsp
        ])
        ## format
        ocamlformat
        ## lsp
        ocamlPackages.ocaml-lsp
      ])
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
        ## format
        rustfmt
        ## lsp
        rust-analyzer
        ## extra
        gf
        cargo-nextest
        cargo-edit
        cargo-watch
        cargo-audit
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
      [
        # :ui emoji
        emojione
      ]
    ];
}
