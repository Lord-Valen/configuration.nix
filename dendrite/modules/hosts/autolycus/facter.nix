{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.autolycus = {
    imports = with modules.nixos; [
      nixos-facter
    ];
    facter.reportPath = ./facter.json;
  };
}
