{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.nixos.theseus.imports = with modules.nixos; [
    disko
  ];
}
