{ config, lib, pkgs, ... }:

{
  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
}
