{
  inputs,
  cell,
}: let
  inherit (cell) lib;

  common = {
    hardware.opengl.driSupport32Bit = true;
    hardware.enableRedistributableFirmware = true;
  };
  load = lib.load (inputs // {inherit common;}) cell;

  hosts = lib.loadAll load ./src;
in
  hosts
