{ config, ... }:
{
  flake.modules.nixos.servarr = {
    imports = with config.flake.modules.nixos; [ nginx ];
  };
}
