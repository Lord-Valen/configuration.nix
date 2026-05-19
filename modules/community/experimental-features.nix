{ den, ... }:
{
  den.aspects.base.includes = with den.aspects; [ flakes ];
  den.aspects.pc.includes = with den.aspects; [ pipe-operators ];
  den.aspects.flakes.nixos = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  den.aspects.pipe-operators.nixos = {
    nix.settings.experimental-features = [
      "pipe-operators"
    ];
  };
  den.aspects.ca-derivations.nixos = {
    nix.settings.experimental-features = [
      "ca-derivations"
    ];
  };
  den.aspects.dynamic-derivations = {
    includes = with den.aspects; [ ca-derivations ];
    nixos.nix.settings.experimental-features = [
      "dynamic-derivations"
      "recursive-nix"
    ];
  };
}
