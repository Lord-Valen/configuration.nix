{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.host.theseus = {
    imports = with modules.nixos; [
      nixos-facter
    ];
    facter.reportPath = ./facter.json;
  };
}
