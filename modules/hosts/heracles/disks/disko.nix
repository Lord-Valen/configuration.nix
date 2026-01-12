{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.nixos.heracles.imports = with modules.nixos; [
    disko
  ];
}
