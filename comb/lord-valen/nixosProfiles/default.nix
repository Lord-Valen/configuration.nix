{
  inputs,
  cell,
}: let
  load = cell.lib.load inputs cell;
in
  cell.lib.rakeLeaves ../nixos.old/profiles
  // {
    core = load ./core;
    pipewire = load ./pipewire;
    music = load ./music;
    # games = load ./games;
    # monero = load ./monero;
  }
