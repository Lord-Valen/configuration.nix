{
  inputs,
  cell,
  pkgs,
  lib,
}:
let
  inherit (cell.nixosModules) p2pool;

  inPeers = 32;
  outPeers = 64;
in
{
  imports = [ p2pool ];

  environment.systemPackages = with pkgs; [ monero-gui ];

  networking.firewall =
    let
      ports = [
        18080
        37889
        37888
      ];
    in
    {
      allowedUDPPorts = ports;
      allowedTCPPorts = ports;
    };

  services = {
    monero = {
      enable = true;
      mining.enable = false;

      priorityNodes = [
        "node.moneroworld.com:18080"
        "nodes.hashvault.pro:18080"
        "xmr-node.cakewallet.com:18080"
      ];

      extraConfig = ''
        zmq-pub=tcp://localhost:18083

        out-peers=${toString outPeers}
        in-peers=${toString inPeers}
      '';
    };

    p2pool = {
      inherit inPeers outPeers;
      enable = true;
      address = "44JVCqQB9CvNn1HJcL9SfyBdGLbFk1dApXV1DWBrsoi7GJyfJaa6Vjbi2Y9SCM5wmBTMxbamAm3sjRpEJMMy4R9EPvYWHQe";
    };

    xmrig = {
      enable = true;
      settings.pools = lib.singleton { url = "127.0.0.1:3333"; };
    };
  };
}
