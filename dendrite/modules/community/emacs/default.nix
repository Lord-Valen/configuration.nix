#TODO: logseq://graph/paneideon?block-id=68004fe4-5c97-421b-8c36-f635850013ff
{
  flake.modules.home-manager.emacs =
    { pkgs, ... }:
    {
      xdg.configFile.emacs = {
        enable = true;
        source = ./_src;
        recursive = true;
      };
      fonts.fontconfig.enable = true;

      programs.emacs = {
        enable = true;
        extraPackages =
          epkgs: with epkgs; [
            melpaStablePackages.no-littering
            meow
            doom-modeline
            vertico
            marginalia
            corfu
            embark
            consult
            embark-consult
            orderless
            which-key
            rainbow-delimiters
            lispy
            nix-ts-mode
            helpful
            apheleia
            eglot
            gdscript-mode
            typescript-mode
            #nongnuPackages.typst-ts-mode

            melpaStablePackages.magit
            (treesit-grammars.with-grammars (g: [
              g.tree-sitter-nix
              g.tree-sitter-typescript
              g.tree-sitter-typst
              g.tree-sitter-json
            ]))

            command-log-mode
          ];
      };

      services.emacs = {
        enable = true;
        defaultEditor = true;
        socketActivation.enable = true;
        client.enable = true;
      };

      home.packages = with pkgs; [
        nixfmt-rfc-style
      ];
    };
}
