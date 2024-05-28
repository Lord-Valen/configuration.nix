{
  services.nginx = {
    enable = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
  };
  networking = {
    firewall.allowedTCPPorts = [ 80 ];
    firewall.allowedUDPPorts = [ 80 ];
  };
}
