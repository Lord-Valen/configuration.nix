{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.aspects.base.nixos = {
    imports = with modules.nixos; [
      flakes
    ];
  };
  flake.aspects.pc.nixos = {
    imports = with modules.nixos; [
      pipe-operators
    ];
  };
  flake.aspects.flakes.nixos = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  flake.aspects.pipe-operators.nixos = {
    nix.settings.experimental-features = [
      "pipe-operators"
    ];
  };
  flake.aspects.ca-derivations.nixos = {
    nix.settings.experimental-features = [
      "ca-derivations"
    ];
  };
  flake.aspects.dynamic-derivations.nixos = {
    imports = [ config.flake.modules.nixos.ca-derivations ];
    nix.settings.experimental-features = [
      "dynamic-derivations"
      "recursive-nix"
    ];
  };
}
