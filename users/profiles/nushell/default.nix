{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.configFile = {
    "config.nu".source = ./config.nu;
    "env.nu".source = ./env.nu;
  };
}
