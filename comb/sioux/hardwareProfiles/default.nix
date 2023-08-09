{
  inputs,
  cell,
}: let
  inherit (cell) lib;

  load = lib.load inputs cell;

  hosts = lib.loadAll load ./src;
in
  hosts
