{ den, ... }:
{
  den.aspects.nginx = {
    includes = with den.aspects; [ acme ];
    nixos = {
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
  };
}
