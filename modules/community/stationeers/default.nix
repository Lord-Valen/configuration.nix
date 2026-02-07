{ config, ... }:
{
  flake.aspects.stationeers.nixos = {
    imports = [ config.flake.nixosModules.ssui ];
    nixpkgs.overlays = [ config.flake.overlays.ssui ];
    services.ssui = {
      enable = true;
      openFirewall = true;
    };
  };
}
