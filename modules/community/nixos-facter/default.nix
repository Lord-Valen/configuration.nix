{ inputs, ... }:
{
  flake.modules.nixos.nixos-facter = {
    imports = [ (inputs.nixos-facter-modules.nixosModules.facter or { }) ];
  };
}
