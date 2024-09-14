{
  inputs,
  pkgs,
  lib,
  config,
}:
{
  imports = [
    (inputs.musnix + "/modules/base.nix")
    (inputs.musnix + "/modules/rtirq.nix")
  ];

  musnix = {
    enable = true;
    rtcqs.enable = true;
    rtirq = {
      enable = true;
    };
  };

  services.das_watchdog.enable = true;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages-rt_latest;
}
