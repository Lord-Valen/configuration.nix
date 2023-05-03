{
  inputs,
  cell,
}: let
  load = cell.lib.load inputs cell;
in
  cell.lib.rakeLeaves ../home.old/profiles
  // {
    core = load ./core;
    doom = load ./doom;
  }
