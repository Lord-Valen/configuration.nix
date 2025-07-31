{
  inputs,
  config,
  lib,
  ...
}:
{
  flake.modules.nixos.musnix = {
    imports = [ inputs.musnix.nixosModules.musnix ];
    musnix = {
      enable = true;
      rtcqs.enable = true;
      rtirq.enable = true;
    };
    services.das_watchdog.enable = lib.mkForce true;
  };
  flake.modules.nixos.audio.imports = [ config.flake.modules.nixos.musnix ];
}
