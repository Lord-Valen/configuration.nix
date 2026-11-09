{
  den.aspects.claude = {
    nixpkgs-overlays = _: [
      (_final: prev: {
        nushell = prev.nushell.override {
          additionalFeatures = feats: feats ++ [ "mcp" ];
        };
      })
    ];
  };
}
