{
  inputs,
  cell,
}: let
  load = cell.lib.load inputs cell;
in
  cell.lib.rakeLeaves ../nixos.old/profiles
  // load ./src
  // {
    geoclue = {services.geoclue2.enable = true;};
  }
