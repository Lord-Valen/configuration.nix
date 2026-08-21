{ config, ... }: {
  flake.overlays.ratbag = final: prev: {
    libratbag = prev.libratbag.overrideAttrs (prevAttrs: {
      version = "0-unstable-2026-08-18";

      src = prevAttrs.src.overrideAttrs {
        rev = "b8d4d3ca1f4d6b23c664ffee2888b8eb669bee21";
        hash = "sha256-8V/LIki/tI/9Wi6kuFJp6k1p+moMh8Gc8RNP1BUlZO8=";
      };
    });
  };
  den.aspects.ratbag.nixos = {
    nixpkgs.overlays = [ config.flake.overlays.ratbag ];
  };
}
