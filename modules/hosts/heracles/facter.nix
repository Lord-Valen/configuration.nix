{ den, ... }:
{
  den.aspects.heracles = {
    includes = with den.aspects; [ nixos-facter ];
    nixos.facter.reportPath = ./facter.json;
  };
}
