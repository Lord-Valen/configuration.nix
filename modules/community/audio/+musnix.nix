{
  den,
  inputs,
  lib,
  ...
}:
{
  den.aspects.musnix.nixos = {
    imports = [ inputs.musnix.nixosModules.musnix ];
    musnix = {
      enable = true;
      rtcqs.enable = true;
      rtirq.enable = true;
    };
    services.das_watchdog.enable = lib.mkForce true;
  };
  den.aspects.audio.includes = with den.aspects; [ musnix ];
}
