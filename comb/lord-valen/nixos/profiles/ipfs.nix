{
  config,
  lib,
  pkgs,
  ...
}: {
  services.kubo = {
    enable = true;
    enableGC = true;
    settings.Gateway.PublicGateways = null;
  };
}
