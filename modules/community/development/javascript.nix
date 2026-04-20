{ den, ... }:
{
  den.aspects.javascript = {
    includes = with den.aspects; [ development ];
    elcoco = {
      source = ./javascript.el;
      extraPackages = epkgs: with epkgs; [
        typescript-mode
        (treesit-grammars.with-grammars (g: [ g.tree-sitter-typescript ]))
      ];
    };
    nixos.programs.npm.enable = true;
    provides.lord-valen.includes = [ den.aspects.javascript ];
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        nodejs
        nodePackages.pnpm
        yarn
        bun
        deno
      ];
    };
  };
}
