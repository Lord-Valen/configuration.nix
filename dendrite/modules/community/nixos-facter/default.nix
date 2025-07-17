{ inputs, ... }:
{
  flake.modules.nixos-facter = {
    imports = [ inputs.nixos-facter-modules.nixos-modules.facter ];
  };
}
