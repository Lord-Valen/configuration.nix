{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    supercollider-with-sc3-plugins
    haskellPackages.tidal
  ];
}
