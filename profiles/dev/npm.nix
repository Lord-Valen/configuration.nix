{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enables us to use `npm link` without running into permissions issues
  programs.npm.enable = true;
}
