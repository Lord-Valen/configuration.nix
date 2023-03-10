{
  config,
  lib,
  pkgs,
  ...
}: {
  fonts = {
    fonts = [
      pkgs.fira
      pkgs.liberation_ttf
    ];
    fontDir.enable = true;
  };
  environment.systemPackages = [pkgs.onlyoffice-bin];
}
