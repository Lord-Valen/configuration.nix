{
  inputs,
  cell,
  config,
  pkgs,
  lib,
}:
let
  inherit (inputs.home-manager.lib) hm;

  inherit (cell) pkgs-unstable;
in
{
  # Doom
  activation.installDoomEmacs = hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
       ${lib.getExe pkgs.git} clone $VERBOSE_ARG --depth=1 --single-branch \
           "https://github.com/doomemacs/doomemacs.git" \
           "$XDG_CONFIG_HOME/emacs"
    fi
  '';

  sessionPath = [ "$XDG_CONFIG_HOME/emacs/bin" ];

  # :tools magit
  ## forge
  file.".authinfo.gpg".source = ./_authinfo.gpg;
  packages =
    with pkgs;
    lib.concatLists [
      [
        # My Dependencies
        (nerdfonts.override {
          fonts = [
            "Iosevka"
            "NerdFontsSymbolsOnly"
          ];
        })
        (iosevka-bin.override { variant = "Aile"; })
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
        # typst-ts-mode
        pkgs-unstable.typst
        pkgs-unstable.typstfmt
        ## lsp
        pkgs-unstable.typst-lsp
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
        glslang
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
        ## format
        csharpier
        ## lsp
        omnisharp-roslyn
      ]
      [
        # :lang data
        ## format
        libxml2
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
        # :lang java
        google-java-format

        ## lsp
        jdt-language-server
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
        vscode-langservers-extracted
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
        # :lang lua
        lua
        ## lsp
        lua-language-server
        ## format
        stylua
      ]
      [
        # :lang markdown
        marksman
        pandoc
        nodePackages.prettier
        python311Packages.grip
      ]
      [
        # :lang nix
        ## lsp
        nixd
        nixfmt-rfc-style
      ]
      (lib.flatten [
        # :lang ocaml
        ocaml
        opam
        dune_3
        (with ocamlPackages; [
          utop
          ocp-indent
          merlin
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
        # :lang web
        html-tidy
        stylelint
        nodePackages.js-beautify
      ]
      [
        # :lang yaml
        ## lsp
        nodePackages.yaml-language-server
      ]
      [
        # :term vterm
        libvterm
        cmake
        gnumake
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
        #:tools make
        gnumake
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
