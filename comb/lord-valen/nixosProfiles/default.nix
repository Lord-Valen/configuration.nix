{
  inputs,
  cell,
}: let
  inherit (cell) lib;
  load = lib.load inputs cell;
in
  lib.rakeLeaves ../nixos.old/profiles
  // lib.loadAll load ./src
  // {
    geoclue = {services.geoclue2.enable = true;};
  }
