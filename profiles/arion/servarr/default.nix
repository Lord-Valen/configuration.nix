{ config, lib, pkgs, ... }:

{
  imports = [ ../common.nix ];
  virtualisation.arion.projects.servarr.settings = {
    imports = [ ./arion-compose.nix ];
  };
}
