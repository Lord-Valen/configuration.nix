{
  inputs,
  cell,
}: let
  load = cell.lib.load inputs cell;
in
  cell.lib.rakeLeaves ../home.old/profiles
  // {
    doom = load ./doom;
    face = load ./face;
    helix = load ./helix;
    hyprland = load ./hyprland;
    shell = load ./shell;
  }
