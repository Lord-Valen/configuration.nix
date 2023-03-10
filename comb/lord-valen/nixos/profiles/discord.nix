{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [discord betterdiscordctl];
}
