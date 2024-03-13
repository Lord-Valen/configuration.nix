{ inputs, cell }:
let
  common = {
    hardware.opengl.driSupport32Bit = true;
    hardware.enableRedistributableFirmware = true;
  };
in
inputs.hive.findLoad {
  inherit cell;
  inputs = inputs // {
    inherit common;
  };
  block = ./.;
}
