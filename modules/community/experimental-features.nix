{ config, ... }:
{
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
