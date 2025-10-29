{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.nixos.printing =
    { pkgs, ... }:
    {
      imports = with modules.nixos; [
        avahi
      ];
      hardware.sane = {
        enable = true;
        extraBackends = with pkgs; [
          sane-airscan
        ];
        disabledDefaultBackends = [ "escl" ];
      };
      programs.system-config-printer.enable = true;
      environment.systemPackages = with pkgs; [ simple-scan ];

      services = {
        ipp-usb.enable = true;
        printing = {
          enable = true;
          drivers = with pkgs; [
            gutenprint
            gutenprintBin
            foomatic-filters
            brlaser
          ];
        };
        saned.enable = true;
      };
    };
}
