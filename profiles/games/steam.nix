{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
    gamemode.enable = true;
  };

  hardware = {
    steam-hardware.enable = true;
  };

  environment.systemPackages = [pkgs.protonup-ng];
}
