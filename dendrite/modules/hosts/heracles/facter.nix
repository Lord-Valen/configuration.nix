{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.heracles = {
    imports = with modules.nixos; [
      nixos-facter
    ];
    facter.reportPath = ./facter.json;
  };
}
