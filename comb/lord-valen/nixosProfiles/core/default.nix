{
  lib,
  pkgs,
  ...
}: {
  # Service that makes Out of Memory Killer more effective
  services.earlyoom.enable = true;
}
