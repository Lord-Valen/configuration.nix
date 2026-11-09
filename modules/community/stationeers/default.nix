{ config, ... }:
{
  den.aspects.stationeers = {
    nixpkgs-overlays = _: [ config.flake.overlays.ssui ];
    nixos = {
      imports = [ config.flake.nixosModules.ssui ];
      services.ssui.enable = true;
    };
  };
}
