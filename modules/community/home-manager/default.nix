{ inputs, ... }:
{
  den.aspects.home-manager.nixos = {
    imports = [ (inputs.home-manager.nixosModules.default or { }) ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs.hasGlobalPkgs = true;
      backupFileExtension = "hmbak";
    };
  };
}
