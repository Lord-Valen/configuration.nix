{ lib, ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ git ];
      hardware = {
        graphics.enable32Bit = lib.mkDefault true;
        enableRedistributableFirmware = lib.mkDefault true;
      };
    };
}
