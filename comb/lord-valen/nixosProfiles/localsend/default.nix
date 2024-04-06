{
  inputs,
  cell,
  pkgs,
}:
{
  environment.systemPackages = with pkgs; [ localsend ];

  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
}
