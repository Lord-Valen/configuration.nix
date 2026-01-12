{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.nixos.autolycus.imports = with modules.nixos; [
    disko
  ];
}
