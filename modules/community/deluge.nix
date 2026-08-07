{
  den.aspects.deluge = {
    nixos = {
      services.deluge.enable = true;
      networking.firewall.allowedTCPPorts = [ 6881 ];
      networking.firewall.allowedUDPPorts = [ 6881 ];
    };
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ deluge ];
    };
  };
}
