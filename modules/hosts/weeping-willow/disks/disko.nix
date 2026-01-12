{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.nixos.weeping-willow.imports = with modules.nixos; [
    disko
  ];
}
