{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  environment.systemPackages = with nixpkgs; [
    localsend
  ];

  networking.firewall.allowedTCPPorts = [53317];
  networking.firewall.allowedUDPPorts = [53317];
}
