{ den, ... }:
{
  den.aspects.weeping-willow = {
    includes = with den.aspects; [ nixos-facter ];
    nixos.facter.reportPath = ./facter.json;
  };
}
