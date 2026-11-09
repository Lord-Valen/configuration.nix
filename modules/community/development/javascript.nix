{ den, ... }:
{
  den.aspects.javascript = {
    provides.lord-valen.includes = [ den.aspects.javascript ];
    includes = with den.aspects; [ development ];
    elcoco = {
      source = ./javascript.el;
      extraPackages =
        epkgs: with epkgs; [
          typescript-mode
          (treesit-grammars.with-grammars (g: [
            g.tree-sitter-javascript
            g.tree-sitter-typescript
            g.tree-sitter-tsx
          ]))
        ];
    };
    nixos.programs.npm.enable = true;
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        nodejs
        pnpm
        yarn
        bun
        typescript-language-server
      ];
    };
  };
}
