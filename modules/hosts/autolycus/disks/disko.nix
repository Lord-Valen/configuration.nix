{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.host.autolycus.imports = with modules.nixos; [
    disko
  ];
}
