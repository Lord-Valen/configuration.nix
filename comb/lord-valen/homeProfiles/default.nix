{
  inputs,
  cell,
}: let
  load = cell.lib.load inputs cell;
in
  cell.lib.rakeLeaves ../home.old/profiles
  // {
    doom = load ./doom;
    eww = load ./eww;
    hyprland = load ./hyprland;
  }