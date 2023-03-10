{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../common.nix];
  virtualisation.arion.projects.pihole.settings = {
    imports = [./arion-compose.nix];
  };
}
