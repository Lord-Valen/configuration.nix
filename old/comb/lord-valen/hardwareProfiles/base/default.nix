{
  inputs,
  cell,
  lib,
}:
{
  hardware.graphics.enable32Bit = lib.mkDefault true;
  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
