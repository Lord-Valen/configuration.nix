{ den, ... }:
{
  den.aspects.development.includes = with den.aspects; [ claude ];
  den.aspects.claude.nixos = {
    nixpkgs.overlays = [
      (_final: prev: {
        nushell = prev.nushell.override {
          additionalFeatures = feats: feats ++ [ "mcp" ];
        };
      })
    ];
  };
}
