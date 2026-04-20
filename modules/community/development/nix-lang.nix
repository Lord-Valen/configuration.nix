{ den, ... }:
{
  den.aspects.nix-lang = {
    includes = with den.aspects; [ development ];
    elcoco = {
      source = ./nix.el;
      extraPackages = epkgs: with epkgs; [
        nix-ts-mode
        (treesit-grammars.with-grammars (g: [ g.tree-sitter-nix ]))
      ];
    };
    provides.lord-valen.includes = [ den.aspects.nix-lang ];
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.nixfmt ];
    };
  };
}
