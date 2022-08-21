{ config, lib, pkgs, ... }:

{
  networking = {
    enableIPv6 = true;
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  programs.nm-applet.enable = true;
}
