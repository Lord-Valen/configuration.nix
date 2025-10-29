{
  flake.modules.nixos.nginx = {
    security.acme = {
      acceptTerms = true;
      defaults.email = "lord_valen@proton.me";
    };

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
