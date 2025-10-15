{ config, ... }:
{
  flake.modules.nixos.plymouth = {
    boot.plymouth.enable = true;
  };
  flake.modules.nixos.pc = {
    imports = [ config.flake.modules.nixos.plymouth ];
  };
}
