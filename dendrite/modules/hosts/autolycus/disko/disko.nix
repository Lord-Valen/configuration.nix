{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.autolycus.imports = with modules.nixos; [
    disko
  ];
}
