{
  inputs,
  cell,
}: let
  load = cell.lib.load inputs cell;
in
  cell.lib.rakeLeaves ../home.old/profiles
  // {
    doom = load ./doom;
    hyprland = load ./hyprland;
  }
