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

  # :tools magit +forge
  file.".authinfo.gpg".source = ./_authinfo.gpg;
  packages =
    let
      profiles = with pkgs; {
        doom = [
          git
          (ripgrep.override { withPCRE2 = true; })
          gnutls
        ];
        doom-optional = [
          fd
          imagemagick
          zstd
        ];
        mine = [
          (nerdfonts.override {
            fonts = [
              "Iosevka"
              "NerdFontsSymbolsOnly"
            ];
          })
          (iosevka-bin.override { variant = "Aile"; })
          noto-fonts-emoji
          config.programs.nushell.package
        ];
        typst-ts-mode = [
          pkgs-unstable.typst
          pkgs-unstable.tinymist
        ];
        typst-ts-mode-lsp = [ pkgs-unstable.tinymist ];
        doom-checkers-grammar = [ languagetool ];
        doom-checkers-spell = [
          (aspellWithDicts (
            dicts: with dicts; [
              en
              en-computers
              en-science
              fr
            ]
          ))
        ];
        doom-lang-cc = [
          clang
          clang-tools
          glslang
        ];
        doom-lang-cc-extra = [ gf ];
        doom-lang-common-lisp = [ sbcl ];
        doom-lang-coq = [ coq ];
        doom-lang-csharp = [
          mono
          (
            with pkgs.dotnetCorePackages;
            lib.singleton (combinePackages [
              sdk_8_0
              sdk_9_0
            ])
          )
        ];
        doom-lang-csharp-format = [ csharpier ];
        doom-lang-csharp-lsp = [ omnisharp-roslyn ];
        doom-lang-data-format = [ libxml2 ];
        doom-lang-haskell = [
          ghc
          cabal-install
          ormolu
          haskellPackages.hoogle
        ];
        doom-lang-haskell-lsp = [ haskell-language-server ];
        doom-lang-java = [ google-java-format ];
        doom-lang-java-lsp = [ jdt-language-server ];
        doom-lang-javascript = [
          nodejs
          nodePackages.npm
          nodePackages.prettier
          bun
        ];
        doom-lang-javascript-lsp = [ nodePackages.typescript-language-server ];
        doom-lang-json = [ nodePackages.prettier ];
        doom-lang-json-lsp = [ vscode-langservers-extracted ];
        doom-lang-kotlin = [
          kotlin
          ktlint
        ];
        doom-lang-kotlin-lsp = [ kotlin-language-server ];
        doom-lang-latex = [ texlive.combined.scheme-full ];
        doom-lang-lua = [ lua ];
        doom-lang-lua-lsp = [ lua-language-server ];
        doom-lang-lua-format = [ stylua ];
        doom-lang-markdown = [
          marksman
          pandoc
          nodePackages.prettier
          python311Packages.grip
        ];
        doom-lang-nix-lsp = [
          nixd
          nixfmt-rfc-style
        ];
        doom-lang-ocaml = [
          ocaml
          opam
          dune_3
          (with ocamlPackages; [
            utop
            ocp-indent
            merlin
          ])
        ];
        doom-lang-ocaml-format = [ ocamlformat ];
        doom-lang-ocaml-lsp = [ ocamlPackages.ocaml-lsp ];
        doom-lang-org = [ graphviz ];
        doom-lang-org-latex = [ texlive.combined.scheme-full ];
        doom-lang-org-roam = [ sqlite ];
        doom-lang-rust = [
          rustc
          cargo
        ];
        doom-lang-format = [ rustfmt ];
        doom-lang-rust-lsp = [ rust-analyzer ];
        doom-lang-rust-extra = [
          gf
          cargo-nextest
          cargo-edit
          cargo-watch
          cargo-audit
        ];
        doom-lang-toml = [ taplo ];
        doom-lang-sh = [
          shfmt
          shellcheck
        ];
        doom-lang-sh-lsp = [ nodePackages.bash-language-server ];
        doom-lang-web = [
          html-tidy
          stylelint
          nodePackages.js-beautify
        ];
        doom-lang-yaml-lsp = [ nodePackages.yaml-language-server ];
        doom-term-vterm = [
          libvterm
          cmake
          gnumake
        ];
        doom-tools-direnv = [ direnv ];
        doom-tools-editorconfig = [ editorconfig-core-c ];
        doom-tools-lsp = [
          unzip
          python3Full
          cargo
          nodejs
          nodePackages.npm
        ];
        doom-tools-lookup = [
          ripgrep
          sqlite
          wordnet
        ];
        doom-tools-make = [ gnumake ];
        doom-ui-doom-dashboard = [ emacs-all-the-icons-fonts ];
        doom-ui-emoji = [ emojione ];
      };
    in
    lib.flatten (
      lib.mapAttrsToList (_: value: value) (
        lib.removeAttrs profiles [
          "doom-lang-kotlin"
          "doom-lang-kotlin-lsp"
          "doom-lang-ocaml"
          "doom-lang-ocaml-lsp"
          "doom-lang-ocaml-format"
          "doom-lang-haskell"
          "doom-lang-haskell-lsp"
          "doom-lang-java"
          "doom-lang-java-lsp"
        ]
      )
    );
}
