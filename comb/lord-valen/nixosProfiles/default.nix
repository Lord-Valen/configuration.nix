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
    adb = {programs.adb.enable = true;};
    arion = lib.loadAll load ./arion;
    geoclue = {services.geoclue2.enable = true;};
    users = lib.loadAll load ./users;
  }
