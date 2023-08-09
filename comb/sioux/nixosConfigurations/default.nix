{
  inputs,
  cell,
}: let
  inherit (cell) lib;

  bee = {
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs;
    home = inputs.home-manager;
  };
  time.timeZone = "Canada/Eastern";

  common = {inherit bee time;};
  load = lib.load (inputs // {inherit common;}) cell;

  hosts = lib.loadAll load ./src;
in
  cell.lib.mkNixosConfigurations cell hosts
