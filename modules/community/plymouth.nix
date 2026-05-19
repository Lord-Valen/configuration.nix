{ den, ... }:
{
  den.aspects.plymouth.nixos = {
    boot.plymouth.enable = true;
  };
  den.aspects.pc.includes = with den.aspects; [ plymouth ];
}
