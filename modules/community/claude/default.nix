{ den, ... }:
{
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
