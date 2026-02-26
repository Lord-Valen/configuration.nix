{ config, ... }:
{
  flake.modules.nixos.nginx = {
    imports = [ config.flake.modules.nixos.acme ];
    services.nginx = {
      enable = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
    };

    networking = {
      firewall.allowedTCPPorts = [
        80
        443
      ];
      firewall.allowedUDPPorts = [
        80
        443
      ];
    };
  };
}
