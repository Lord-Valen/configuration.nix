{ inputs, ... }:
{
  den.aspects.nixos-facter.nixos = {
    imports = [ (inputs.nixos-facter-modules.nixosModules.facter or { }) ];
  };
}
