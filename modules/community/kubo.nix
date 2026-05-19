{
  den.aspects.kubo.nixos = {
    services.kubo = {
      enable = true;
      enableGC = true;
      settings = {
        Addresses.API = [ "/ip4/127.0.0.1/tcp/5001" ];
      };
    };
  };
  den.aspects.pc.nixos = {
    services.kubo.localDiscovery = true;
  };
}
