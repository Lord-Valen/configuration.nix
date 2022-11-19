{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.tdesktop];
}
