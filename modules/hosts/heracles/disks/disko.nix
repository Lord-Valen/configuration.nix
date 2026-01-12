{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.host.heracles.imports = with modules.nixos; [
    disko
  ];
}
