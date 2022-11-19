{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.brave
    pkgs.librewolf
    pkgs.tor-browser-bundle-bin
  ];
}
