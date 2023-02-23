{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../common.nix];

  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };
}
