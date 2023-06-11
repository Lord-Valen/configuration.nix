{
  inputs,
  cell,
}: let
  load = cell.lib.load inputs cell;
in
  cell.lib.rakeLeaves ../nixos.old/profiles
  // {
    core = load ./core;
    games = load ./games;
    geoclue = {services.geoclue2.enable = true;};
    gnome = load ./gnome;
    hyprland = load ./hyprland;
    lightdm = load ./displayManager/lightdm;
    music = load ./music;
    pipewire = load ./pipewire;
    printing = load ./printing;
    regreet = load ./displayManager/regreet;
  }
