{ den, ... }:
{
  den.aspects.theseus = {
    includes = with den.aspects; [ nixos-facter ];
    nixos.facter.reportPath = ./facter.json;
  };
}
