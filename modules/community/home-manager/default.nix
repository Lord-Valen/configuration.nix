{ inputs, ... }:
{
  flake.modules.nixos.home-manager = {
    imports = [ (inputs.home-manager.nixosModules.default or { }) ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs.hasGlobalPkgs = true;
    };
  };
}
