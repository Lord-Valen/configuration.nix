{
  inputs,
  cell,
  lib,
}:
{
  hardware.opengl.driSupport32Bit = lib.mkDefault true;
  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
