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

  load = src:
    lib.hive.load {
      inherit src cell;
      inputs = inputs // {inherit common;};
    };

  hosts = lib.loadAll load ./src;
in
  cell.lib.mkNixosConfigurations cell hosts
