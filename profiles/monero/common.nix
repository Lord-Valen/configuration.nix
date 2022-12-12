{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [monero-gui];

  services.monero = {
    enable = true;
    priorityNodes = [
      "node.moneroworld.com:18080"
      "opennode.xmr-tw.org:18080"
      "node.supportxmr.com:18080"
      "nodes.hashvault.pro:18080"
    ];
  };
}
