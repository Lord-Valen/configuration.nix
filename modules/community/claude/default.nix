{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.aspects.development.nixos = {
    imports = with modules.nixos; [ claude ];
  };
  flake.aspects.claude.nixos = {
    nixpkgs.overlays = [
      (final: prev: {
        nushell = prev.nushell.override {
          additionalFeatures = feats: feats ++ [ "mcp" ];
        };
      })
    ];
  };
}
