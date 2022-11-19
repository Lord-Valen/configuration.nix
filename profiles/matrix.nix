{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.element-desktop];
}
