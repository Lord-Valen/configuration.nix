{ den, ... }:
{
  den.aspects.typst = {
    includes = with den.aspects; [ development ];
    elcoco = {
      source = ./writing/typst.el;
      extraPackages = epkgs: with epkgs; [
        typst-ts-mode
        (treesit-grammars.with-grammars (g: [ g.tree-sitter-typst ]))
      ];
    };
  };

  den.aspects.writing = {
    includes = with den.aspects; [ typst ];
    nixos = { pkgs, ... }: {
      fonts.packages = with pkgs; [
        (iosevka-bin.override { variant = "Aile"; })
        (iosevka-bin.override { variant = "Etoile"; })
        liberation_ttf
      ];
      environment.systemPackages = with pkgs; [
        zotero
        biber
        libreoffice-fresh
        typst
      ];
    };
  };

  den.aspects.fonts.nixos = {
    fonts.fontDir.enable = true;
  };
}
