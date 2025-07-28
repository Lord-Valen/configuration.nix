{ lib, ... }:
{
  flake.modules.nixos.base = {
    hardware = {
      graphics.enable32Bit = lib.mkDefault true;
      enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}
